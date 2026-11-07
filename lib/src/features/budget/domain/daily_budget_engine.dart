import 'package:flutter/foundation.dart';

@immutable
class DailyBudgetSnapshot {
  final int dateEpochDay; // e.g. DateTime.now().millisecondsSinceEpoch ~/ 86400000
  final int allocatedPaise;
  final int spentPaise;
  final int carriedForwardPaise;
  final int netAvailablePaise;

  const DailyBudgetSnapshot({
    required this.dateEpochDay,
    required this.allocatedPaise,
    required this.spentPaise,
    required this.carriedForwardPaise,
    required this.netAvailablePaise,
  });

  /// Remaining balance for the day (can be negative if over budget)
  int get remainingPaise => netAvailablePaise;

  /// Percentage of total available consumed (0.0 to 1.0+)
  double get burnRate {
    final totalPool = allocatedPaise + carriedForwardPaise;
    if (totalPool <= 0) return spentPaise > 0 ? 1.0 : 0.0;
    return spentPaise / totalPool;
  }
}

/// Pure domain calculation engine for Daily Budgeting with Automatic Carry-Forward.
abstract class DailyBudgetEngine {
  /// Computes a single day snapshot given daily allocation, expenses, and previous day's net available.
  static DailyBudgetSnapshot computeDay({
    required int dateEpochDay,
    required int dailyAllocationPaise,
    required int dayExpensesPaise,
    required int previousDayNetAvailablePaise,
    required bool enableCarryForward,
  }) {
    final carriedForward = enableCarryForward ? previousDayNetAvailablePaise : 0;
    final totalPool = dailyAllocationPaise + carriedForward;
    final netAvailable = totalPool - dayExpensesPaise;

    return DailyBudgetSnapshot(
      dateEpochDay: dateEpochDay,
      allocatedPaise: dailyAllocationPaise,
      spentPaise: dayExpensesPaise,
      carriedForwardPaise: carriedForward,
      netAvailablePaise: netAvailable,
    );
  }

  /// Recalculates all daily budget snapshots forward from an edited historical day up to the current day.
  /// Guarantees that any past edit accurately bubbles up into today's available budget.
  static List<DailyBudgetSnapshot> cascadeRecalculate({
    required int startEpochDay,
    required int todayEpochDay,
    required int dailyAllocationPaise,
    required bool enableCarryForward,
    required Map<int, int> expensesByEpochDay, // Map<epochDay, totalPaiseSpent>
    required int initialCarryForwardPaise,
  }) {
    final List<DailyBudgetSnapshot> updatedSnapshots = [];
    int previousNetAvailable = initialCarryForwardPaise;

    for (int currentDay = startEpochDay; currentDay <= todayEpochDay; currentDay++) {
      final spent = expensesByEpochDay[currentDay] ?? 0;

      final snapshot = computeDay(
        dateEpochDay: currentDay,
        dailyAllocationPaise: dailyAllocationPaise,
        dayExpensesPaise: spent,
        previousDayNetAvailablePaise: previousNetAvailable,
        enableCarryForward: enableCarryForward,
      );

      updatedSnapshots.add(snapshot);
      previousNetAvailable = snapshot.netAvailablePaise;
    }

    return updatedSnapshots;
  }
}
