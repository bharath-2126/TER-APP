import 'package:csv/csv.dart';
import '../domain/statement_models.dart';

class StatementCsvService {
  /// Converts statement entries into standard RFC-4180 CSV
  static String generateCsv({
    required List<StatementEntry> entries,
    required String statementTitle,
    String? personOrAccount,
  }) {
    final List<List<dynamic>> rows = [];

    // Header Metadata
    rows.add(['TER (Track Every Rupee) - Financial Statement Export']);
    rows.add(['Report Title', statementTitle]);
    if (personOrAccount != null) {
      rows.add(['Counterparty / Account', personOrAccount]);
    }
    rows.add(['Export Date', DateTime.now().toIso8601String()]);
    rows.add([]); // Blank row

    // Table Column Headers
    rows.add([
      'Date',
      'Time',
      'Transaction ID',
      'Description',
      'Type',
      'Category',
      'Account / Card',
      'Person',
      'Amount (Rs)',
      'Direction',
      'Running Balance (Rs)',
      'Notes',
    ]);

    // Data rows
    for (final e in entries) {
      final date = '${e.timestamp.year}-${e.timestamp.month.toString().padLeft(2, '0')}-${e.timestamp.day.toString().padLeft(2, '0')}';
      final time = '${e.timestamp.hour.toString().padLeft(2, '0')}:${e.timestamp.minute.toString().padLeft(2, '0')}';
      final amount = (e.amountPaise / 100).toStringAsFixed(2);
      final running = (e.runningBalancePaise / 100).toStringAsFixed(2);
      final direction = e.isInflow ? 'Inflow' : 'Outflow';

      rows.add([
        date,
        time,
        e.transactionId,
        e.title,
        e.typeName,
        e.categoryName ?? 'General',
        e.accountOrCardName ?? 'N/A',
        e.personName ?? 'N/A',
        amount,
        direction,
        running,
        e.notes ?? '',
      ]);
    }

    return const ListToCsvConverter().convert(rows);
  }

  /// Convenience method for general statements
  static String generateGeneralStatementCsv({
    required String title,
    required String periodDescription,
    required List<StatementEntry> entries,
    String? personOrAccount,
  }) {
    return generateCsv(
      entries: entries,
      statementTitle: '$title ($periodDescription)',
      personOrAccount: personOrAccount,
    );
  }

  /// Convenience method for Person-wise reconciliation statements
  static String generatePersonStatementCsv(PersonStatementSummary summary) {
    final List<List<dynamic>> rows = [];

    rows.add(['TER (Track Every Rupee) - PERSON-WISE FINANCIAL STATEMENT']);
    rows.add(['Counterparty: ${summary.personName}']);
    if (summary.phone != null) rows.add(['Phone / Contact', summary.phone!]);
    rows.add(['Opening Outstanding', 'Rs. ${(summary.openingOutstandingPaise / 100).toStringAsFixed(2)}']);
    rows.add(['Period Lent', 'Rs. ${(summary.periodLentPaise / 100).toStringAsFixed(2)}']);
    rows.add(['Period Repaid', 'Rs. ${(summary.periodRepaidPaise / 100).toStringAsFixed(2)}']);
    rows.add(['Closing Outstanding', 'Rs. ${(summary.closingOutstandingPaise / 100).toStringAsFixed(2)}']);
    rows.add(['Export Date', DateTime.now().toIso8601String()]);
    rows.add([]);

    rows.add([
      'Date',
      'Time',
      'Transaction ID',
      'Description',
      'Type',
      'Amount (Rs)',
      'Direction',
      'Running Balance (Rs)',
      'Notes',
    ]);

    for (final e in summary.entries) {
      final date = '${e.timestamp.year}-${e.timestamp.month.toString().padLeft(2, '0')}-${e.timestamp.day.toString().padLeft(2, '0')}';
      final time = '${e.timestamp.hour.toString().padLeft(2, '0')}:${e.timestamp.minute.toString().padLeft(2, '0')}';
      final amount = (e.amountPaise / 100).toStringAsFixed(2);
      final running = (e.runningBalancePaise / 100).toStringAsFixed(2);
      final direction = e.isInflow ? 'Repayment (Cr)' : 'Lent (Dr)';

      rows.add([
        date,
        time,
        e.transactionId,
        e.title,
        e.typeName,
        amount,
        direction,
        running,
        e.notes ?? '',
      ]);
    }

    return const ListToCsvConverter().convert(rows);
  }
}
