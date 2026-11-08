import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/app_providers.dart';
import '../domain/statement_models.dart';
import '../data/statement_query_service.dart';
import '../data/statement_history_repository.dart';

final statementQueryServiceProvider = Provider<StatementQueryService>((ref) {
  final repo = ref.watch(ledgerRepositoryProvider);
  return StatementQueryService(repo);
});

final statementHistoryRepositoryProvider = Provider<StatementHistoryRepository>((ref) {
  return StatementHistoryRepository();
});

/// Current active filter criteria state
final activeStatementFilterProvider = StateProvider<StatementFilterCriteria>((ref) {
  return const StatementFilterCriteria();
});

/// Statement entries matching current active filter
final statementEntriesProvider = Provider<List<StatementEntry>>((ref) {
  final service = ref.watch(statementQueryServiceProvider);
  final criteria = ref.watch(activeStatementFilterProvider);
  // Re-run whenever transactions or debts update
  ref.watch(transactionsStreamProvider);
  ref.watch(debtsStreamProvider);
  return service.queryStatementEntries(criteria);
});

/// Person-wise reconciliation summary family provider
final personStatementSummaryProvider = Provider.family<PersonStatementSummary, String>((ref, personId) {
  final service = ref.watch(statementQueryServiceProvider);
  final criteria = ref.watch(activeStatementFilterProvider);
  ref.watch(transactionsStreamProvider);
  ref.watch(debtsStreamProvider);
  return service.queryPersonStatement(personId: personId, criteria: criteria);
});

/// Macro Outstanding Balance Summary Provider
final outstandingBalanceSummaryProvider = Provider<OutstandingBalanceSummary>((ref) {
  final service = ref.watch(statementQueryServiceProvider);
  ref.watch(debtsStreamProvider);
  ref.watch(personsStreamProvider);
  return service.queryOutstandingBalanceReport();
});
