import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_every_rupee/src/features/lending/domain/lending_engine.dart';

void main() {
  group('LendingEngine Domain Tests', () {
    final originalDebt = DebtRecord(
      id: 'debt_101',
      personId: 'person_rahul',
      type: DebtType.lent,
      principalPaise: 1000000, // ₹10,000
      outstandingBalancePaise: 1000000,
      initialDate: DateTime(2026, 1, 1),
      status: DebtStatus.active,
    );

    test('Partial repayment correctly decrements outstanding balance without altering principal', () {
      final result = LendingEngine.applyRepayment(
        debt: originalDebt,
        repaymentId: 'rep_1',
        repaymentAmountPaise: 300000, // ₹3,000
        repaymentDate: DateTime(2026, 1, 15),
      );

      expect(result.newOutstandingPaise, 700000); // ₹7,000 remaining
      expect(result.newStatus, DebtStatus.partiallyPaid);
      expect(originalDebt.principalPaise, 1000000); // Original record remains immutable
    });

    test('Full repayment sets status to fullySettled', () {
      final result = LendingEngine.applyRepayment(
        debt: originalDebt,
        repaymentId: 'rep_2',
        repaymentAmountPaise: 1000000, // ₹10,000
        repaymentDate: DateTime(2026, 1, 20),
      );

      expect(result.newOutstandingPaise, 0);
      expect(result.newStatus, DebtStatus.fullySettled);
    });

    test('Throws ArgumentError if repayment exceeds outstanding balance', () {
      expect(
        () => LendingEngine.applyRepayment(
          debt: originalDebt,
          repaymentId: 'rep_invalid',
          repaymentAmountPaise: 1000001,
          repaymentDate: DateTime(2026, 1, 25),
        ),
        throwsArgumentError,
      );
    });

    test('Calculates aggregate receivables and payables accurately', () {
      final debts = [
        originalDebt,
        DebtRecord(
          id: 'debt_102',
          personId: 'person_priya',
          type: DebtType.borrowed,
          principalPaise: 500000,
          outstandingBalancePaise: 500000,
          initialDate: DateTime(2026, 1, 2),
          status: DebtStatus.active,
        ),
      ];

      final aggregates = LendingEngine.calculateAggregates(debts);
      expect(aggregates.totalLentOutstandingPaise, 1000000);
      expect(aggregates.totalBorrowedOutstandingPaise, 500000);
    });
  });
}
