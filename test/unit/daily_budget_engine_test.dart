import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_every_rupee/src/features/budget/domain/daily_budget_engine.dart';

void main() {
  group('DailyBudgetEngine Tests', () {
    test('Computes daily budget snapshot with positive carry forward', () {
      final snapshot = DailyBudgetEngine.computeDay(
        dateEpochDay: 100,
        dailyAllocationPaise: 50000, // ₹500/day
        dayExpensesPaise: 20000, // ₹200 spent
        previousDayNetAvailablePaise: 10000, // ₹100 carried forward
        enableCarryForward: true,
      );

      // (500 + 100) - 200 = 400 remaining
      expect(snapshot.carriedForwardPaise, 10000);
      expect(snapshot.netAvailablePaise, 40000);
    });

    test('Cascade recalculates forward correctly when historical day is edited', () {
      // 3 days: day 1, day 2, day 3
      // Daily budget: ₹1,000 (100000 paise)
      // Day 1 spent: ₹400 -> leaves ₹600
      // Day 2 spent: ₹800 -> (1000 + 600) - 800 = leaves ₹800
      // Day 3 spent: ₹500 -> (1000 + 800) - 500 = leaves ₹1300
      final snapshots = DailyBudgetEngine.cascadeRecalculate(
        startEpochDay: 1,
        todayEpochDay: 3,
        dailyAllocationPaise: 100000,
        enableCarryForward: true,
        expensesByEpochDay: {
          1: 40000,
          2: 80000,
          3: 50000,
        },
        initialCarryForwardPaise: 0,
      );

      expect(snapshots.length, 3);
      expect(snapshots[0].netAvailablePaise, 60000); // Day 1
      expect(snapshots[1].netAvailablePaise, 80000); // Day 2
      expect(snapshots[2].netAvailablePaise, 130000); // Day 3
    });
  });
}
