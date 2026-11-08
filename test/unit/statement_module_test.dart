import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_every_rupee/src/features/transactions/data/ledger_repository.dart';
import 'package:tracker_every_rupee/src/features/transactions/domain/transaction_model.dart';
import 'package:tracker_every_rupee/src/features/statements/domain/statement_models.dart';
import 'package:tracker_every_rupee/src/features/statements/data/statement_query_service.dart';
import 'package:tracker_every_rupee/src/features/statements/data/statement_pdf_service.dart';
import 'package:tracker_every_rupee/src/features/statements/data/statement_csv_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LedgerRepository repo;
  late StatementQueryService queryService;

  setUp(() async {
    repo = LedgerRepository();
    queryService = StatementQueryService(repo);

    final now = DateTime.now();

    // 1. Income transaction (Salary)
    await repo.logTransaction(TransactionModel(
      id: 'tx_salary',
      type: TransactionType.income,
      amountPaise: 8500000, // ₹85,000
      toAccountId: 'acc_hdfc',
      categoryId: 'Salary',
      note: 'Monthly Salary Credit',
      transactionTimestamp: now.subtract(const Duration(days: 3)),
      createdAt: now,
      updatedAt: now,
    ));

    // 2. Expense transaction (Rent)
    await repo.logTransaction(TransactionModel(
      id: 'tx_rent',
      type: TransactionType.expense,
      amountPaise: 2500000, // ₹25,000
      fromAccountId: 'acc_hdfc',
      categoryId: 'Housing',
      note: 'Monthly Apartment Rent',
      transactionTimestamp: now.subtract(const Duration(days: 2)),
      createdAt: now,
      updatedAt: now,
    ));

    // 3. Split transaction with Rahul (₹1,000 bill: ₹400 personal, ₹600 lent to Rahul)
    await repo.recordSplitTransaction(
      totalBillPaise: 100000,
      mySharePaise: 40000,
      description: 'Dinner at BBQ Nation',
      fromAccountId: 'acc_hdfc',
      categoryId: 'Food',
      participantShares: {'person_rahul': 60000},
      transactionTimestamp: now.subtract(const Duration(days: 1)),
    );

    // 4. Repayment from Rahul
    await repo.recordLendingRepayment(
      personId: 'person_rahul',
      amountPaise: 30000, // ₹300 repayment
      toAccountId: 'acc_hdfc',
      notes: 'Partial Repayment for BBQ',
    );
  });

  group('StatementQueryService Tests', () {
    test('queryStatementEntries with default criteria returns entries sorted newest first', () {
      final entries = queryService.queryStatementEntries(const StatementFilterCriteria(
        datePreset: StatementDatePreset.thisMonth,
      ));

      expect(entries, isNotEmpty);
      for (int i = 0; i < entries.length - 1; i++) {
        expect(
          entries[i].timestamp.isAfter(entries[i + 1].timestamp) ||
              entries[i].timestamp.isAtSameMomentAs(entries[i + 1].timestamp),
          isTrue,
        );
      }
    });

    test('queryStatementEntries filters by transaction types correctly', () {
      final incomeEntries = queryService.queryStatementEntries(const StatementFilterCriteria(
        datePreset: StatementDatePreset.thisMonth,
        transactionTypes: {'income'},
      ));

      expect(incomeEntries, isNotEmpty);
      for (final entry in incomeEntries) {
        expect(entry.isInflow, isTrue);
      }
    });

    test('queryStatementEntries filters by amount range', () {
      final filtered = queryService.queryStatementEntries(const StatementFilterCriteria(
        datePreset: StatementDatePreset.thisMonth,
        minAmountPaise: 50000, // ₹500
        maxAmountPaise: 500000, // ₹5,000
      ));

      expect(filtered, isNotEmpty);
      for (final entry in filtered) {
        expect(entry.amountPaise, greaterThanOrEqualTo(50000));
        expect(entry.amountPaise, lessThanOrEqualTo(500000));
      }
    });

    test('queryPersonStatement calculates Rahul Kumar reconciliation correctly', () {
      final rahulSummary = queryService.queryPersonStatement(
        personId: 'person_rahul',
        criteria: const StatementFilterCriteria(datePreset: StatementDatePreset.thisMonth),
      );

      expect(rahulSummary.personName, equals('Rahul Kumar'));
      expect(rahulSummary.entries, isNotEmpty);
      // Math invariant: opening + periodLent - periodRepaid = closingOutstanding
      expect(
        rahulSummary.openingOutstandingPaise + rahulSummary.periodLentPaise - rahulSummary.periodRepaidPaise,
        equals(rahulSummary.closingOutstandingPaise),
      );
    });

    test('queryOutstandingBalanceReport aggregates receivables and payables accurately', () {
      final report = queryService.queryOutstandingBalanceReport();

      expect(report.totalReceivablesPaise, greaterThan(0));
      expect(
        report.netPositionPaise,
        equals(report.totalReceivablesPaise - report.totalPayablesPaise),
      );
      expect(report.personBalances, isNotEmpty);
    });
  });

  group('StatementCsvService Tests', () {
    test('generateGeneralStatementCsv produces RFC-compliant CSV with headers and rows', () {
      final entries = queryService.queryStatementEntries(const StatementFilterCriteria());
      final csv = StatementCsvService.generateGeneralStatementCsv(
        title: 'Test All Transactions',
        periodDescription: 'This Month',
        entries: entries,
      );

      expect(csv, contains('Report Title,Test All Transactions (This Month)'));
      expect(csv, contains('Date,Time,Transaction ID,Description,Type,Category,Account / Card,Person,Amount (Rs),Direction,Running Balance (Rs),Notes'));
      expect(csv.split('\n').length, greaterThan(entries.length));
    });

    test('generatePersonStatementCsv produces detailed counterparty statement with summary', () {
      final summary = queryService.queryPersonStatement(
        personId: 'person_rahul',
        criteria: const StatementFilterCriteria(),
      );
      final csv = StatementCsvService.generatePersonStatementCsv(summary);

      expect(csv, contains('PERSON-WISE FINANCIAL STATEMENT'));
      expect(csv, contains('Counterparty: Rahul Kumar'));
      expect(csv, contains('Opening Outstanding'));
      expect(csv, contains('Closing Outstanding'));
    });
  });

  group('StatementPdfService Tests', () {
    test('generateGeneralStatementPdf creates valid non-empty PDF bytes', () async {
      final entries = queryService.queryStatementEntries(const StatementFilterCriteria());
      final pdfBytes = await StatementPdfService.generateGeneralStatementPdf(
        title: 'Monthly Statement',
        periodDescription: 'November 2026',
        entries: entries,
      );

      expect(pdfBytes, isNotEmpty);
      // Valid PDF starts with %PDF
      final header = String.fromCharCodes(pdfBytes.take(4));
      expect(header, equals('%PDF'));
    });

    test('generatePersonStatementPdf creates valid non-empty PDF for counterparty', () async {
      final summary = queryService.queryPersonStatement(
        personId: 'person_rahul',
        criteria: const StatementFilterCriteria(),
      );
      final pdfBytes = await StatementPdfService.generatePersonStatementPdf(summary);

      expect(pdfBytes, isNotEmpty);
      final header = String.fromCharCodes(pdfBytes.take(4));
      expect(header, equals('%PDF'));
    });
  });
}
