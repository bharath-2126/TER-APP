import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_every_rupee/src/features/transactions/data/ledger_repository.dart';
import 'package:tracker_every_rupee/src/features/lending/domain/lending_engine.dart';
import 'package:tracker_every_rupee/src/features/transactions/domain/transaction_model.dart';

void main() {
  group('TER Split Transaction & Lending Integration Tests', () {
    late LedgerRepository repo;

    setUp(() {
      repo = LedgerRepository();
    });

    tearDown(() {
      repo.dispose();
    });

    test('Single-payer Split: Restaurant ₹1,000 bill with ₹400 personal share and ₹600 Rahul share', () async {
      final initialHdfc = repo.accounts.firstWhere((a) => a.id == 'acc_hdfc').currentBalancePaise;
      final initialRahul = repo.persons.firstWhere((p) => p.id == 'person_rahul').outstandingBalancePaise;

      expect(initialRahul, 30000); // ₹300.00 initial debt

      // Perform Split Transaction
      await repo.recordSplitTransaction(
        totalBillPaise: 100000, // ₹1,000.00
        mySharePaise: 40000,   // ₹400.00
        description: 'Dinner at Punjab Grill',
        fromAccountId: 'acc_hdfc',
        participantShares: {
          'person_rahul': 60000, // ₹600.00
        },
        transactionTimestamp: DateTime.now(),
      );

      // Invariant 1: Bank balance must be deducted by FULL ₹1,000
      final updatedHdfc = repo.accounts.firstWhere((a) => a.id == 'acc_hdfc').currentBalancePaise;
      expect(updatedHdfc, initialHdfc - 100000);

      // Invariant 2: Rahul's outstanding balance must increase by ₹600 (to ₹900)
      final updatedRahul = repo.persons.firstWhere((p) => p.id == 'person_rahul').outstandingBalancePaise;
      expect(updatedRahul, 90000); // ₹900.00

      // Invariant 3: Official expense recorded must ONLY be ₹400 personal share
      final personalTx = repo.transactions.firstWhere((t) => t.type == TransactionType.splitExpense);
      expect(personalTx.amountPaise, 40000);
      expect(personalTx.totalBillPaise, 100000);
      expect(personalTx.splitGroupId, isNotNull);

      // Invariant 4: Lending entry created for Rahul with splitGroupId link
      final rahulDebt = repo.debts.firstWhere((d) => d.personId == 'person_rahul' && d.principalPaise == 60000);
      expect(rahulDebt.outstandingBalancePaise, 60000);
      expect(rahulDebt.splitGroupId, personalTx.splitGroupId);
    });

    test('Lending Repayment Integration: Rahul returns ₹300, reducing balance from ₹900 to ₹600', () async {
      // 1. First record the split
      await repo.recordSplitTransaction(
        totalBillPaise: 100000,
        mySharePaise: 40000,
        description: 'Dinner at Punjab Grill',
        fromAccountId: 'acc_hdfc',
        participantShares: {'person_rahul': 60000},
        transactionTimestamp: DateTime.now(),
      );

      expect(repo.persons.firstWhere((p) => p.id == 'person_rahul').outstandingBalancePaise, 90000);
      final preRepaymentBank = repo.accounts.firstWhere((a) => a.id == 'acc_hdfc').currentBalancePaise;

      // 2. Rahul returns ₹300.00
      await repo.recordLendingRepayment(
        personId: 'person_rahul',
        amountPaise: 30000, // ₹300.00
        toAccountId: 'acc_hdfc',
        notes: 'Cash returned by Rahul for dinner split',
      );

      // Invariant: Rahul outstanding balance reduced to ₹600.00
      final finalRahul = repo.persons.firstWhere((p) => p.id == 'person_rahul').outstandingBalancePaise;
      expect(finalRahul, 60000);

      // Invariant: Bank balance credited by ₹300.00
      final postRepaymentBank = repo.accounts.firstWhere((a) => a.id == 'acc_hdfc').currentBalancePaise;
      expect(postRepaymentBank, preRepaymentBank + 30000);

      // Invariant: Repayment transaction logged
      final repaymentTx = repo.transactions.firstWhere((t) => t.type == TransactionType.debtRepayment);
      expect(repaymentTx.amountPaise, 30000);
    });
  });
}
