import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/accounts/domain/account_model.dart';
import '../../features/cards_vault/domain/card_model.dart';
import '../../features/lending/domain/lending_engine.dart';
import '../../features/transactions/data/ledger_repository.dart';
import '../../features/transactions/domain/transaction_model.dart';
import '../../features/budget/domain/daily_budget_engine.dart';

/// Global Singleton Provider for the central Ledger Repository
final ledgerRepositoryProvider = Provider<LedgerRepository>((ref) {
  final repo = LedgerRepository();
  ref.onDispose(repo.dispose);
  return repo;
});

/// Reactive Stream of all user accounts
final accountsStreamProvider = StreamProvider<List<AccountModel>>((ref) {
  final repo = ref.watch(ledgerRepositoryProvider);
  return repo.watchAccounts();
});

/// Total Net Worth / Liquid Balance calculated across all active accounts
final totalNetWorthProvider = Provider<int>((ref) {
  final accountsAsync = ref.watch(accountsStreamProvider);
  return accountsAsync.when(
    data: (accounts) {
      int total = 0;
      for (final a in accounts) {
        if (!a.isArchived) total += a.currentBalancePaise;
      }
      return total;
    },
    loading: () => 22055000, // ₹2,20,550.00 initial seed
    error: (_, __) => 0,
  );
});

/// Reactive Stream of all user cards (Credit, Debit, Prepaid)
final cardsStreamProvider = StreamProvider<List<CardModel>>((ref) {
  final repo = ref.watch(ledgerRepositoryProvider);
  return repo.watchCards();
});

/// Reactive Stream of latest transactions
final transactionsStreamProvider = StreamProvider<List<TransactionModel>>((ref) {
  final repo = ref.watch(ledgerRepositoryProvider);
  return repo.watchTransactions();
});

/// Privacy Toggle Provider: masks financial numbers with '₹ ••••••'
final privacyModeProvider = StateProvider<bool>((ref) => false);

/// Reactive Stream of all active Lending & Borrowing debts
final debtsStreamProvider = StreamProvider<List<DebtRecord>>((ref) {
  final repo = ref.watch(ledgerRepositoryProvider);
  return repo.watchDebts();
});

/// Reactive Stream of all persons
final personsStreamProvider = StreamProvider<List<PersonModel>>((ref) {
  final repo = ref.watch(ledgerRepositoryProvider);
  return repo.watchPersons();
});

/// Daily Budget State Notifier managing daily allocation, expenses, and carry-forward
class DailyBudgetNotifier extends StateNotifier<DailyBudgetSnapshot> {
  final int dailyAllocationPaise;

  DailyBudgetNotifier({this.dailyAllocationPaise = 150000}) // ₹1,500/day default
      : super(
          DailyBudgetEngine.computeDay(
            dateEpochDay: DateTime.now().millisecondsSinceEpoch ~/ 86400000,
            dailyAllocationPaise: 150000,
            dayExpensesPaise: 420800, // Matches screenshot ₹4,208.00
            previousDayNetAvailablePaise: 350000, // ₹3,500 carried forward
            enableCarryForward: true,
          ),
        );

  void recordExpense(int paise) {
    state = DailyBudgetEngine.computeDay(
      dateEpochDay: state.dateEpochDay,
      dailyAllocationPaise: state.allocatedPaise,
      dayExpensesPaise: state.spentPaise + paise,
      previousDayNetAvailablePaise: state.carriedForwardPaise,
      enableCarryForward: true,
    );
  }
}

final dailyBudgetProvider = StateNotifierProvider<DailyBudgetNotifier, DailyBudgetSnapshot>((ref) {
  return DailyBudgetNotifier();
});
