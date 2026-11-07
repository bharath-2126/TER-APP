import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/financial_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Accounts,
  Cards,
  Categories,
  Persons,
  Debts,
  DebtRepayments,
  Transactions,
  DailyBudgetConfigTable,
  DailyBudgetSnapshots,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        // Enforce SQLite Foreign Keys, WAL mode and optimal cache configuration
        await customStatement('PRAGMA foreign_keys = ON;');
        await customStatement('PRAGMA journal_mode = WAL;');
        await customStatement('PRAGMA synchronous = NORMAL;');
      },
      onCreate: (m) async {
        await m.createAll();
        // Insert standard initial categories
        await _seedDefaultCategories();
      },
    );
  }

  Future<void> _seedDefaultCategories() async {
    final now = DateTime.now();
    final defaultCategories = [
      CategoriesCompanion.insert(
        id: 'cat_salary',
        name: 'Salary',
        type: 'income',
        icon: 'wallet',
        colorHex: '10B981',
        sortOrder: const Value(1),
      ),
      CategoriesCompanion.insert(
        id: 'cat_food',
        name: 'Food & Dining',
        type: 'expense',
        icon: 'utensils',
        colorHex: 'EF4444',
        sortOrder: const Value(2),
      ),
      CategoriesCompanion.insert(
        id: 'cat_shopping',
        name: 'Shopping',
        type: 'expense',
        icon: 'shopping-bag',
        colorHex: '3B82F6',
        sortOrder: const Value(3),
      ),
      CategoriesCompanion.insert(
        id: 'cat_bills',
        name: 'Electricity & Bills',
        type: 'expense',
        icon: 'zap',
        colorHex: 'F59E0B',
        sortOrder: const Value(4),
      ),
      CategoriesCompanion.insert(
        id: 'cat_transport',
        name: 'Transport',
        type: 'expense',
        icon: 'car',
        colorHex: '8B5CF6',
        sortOrder: const Value(5),
      ),
    ];

    for (final cat in defaultCategories) {
      await into(categories).insert(cat, mode: InsertMode.insertOrIgnore);
    }
  }
}

/// Opens the SQLite database in a background isolate for zero-frame-drop concurrency.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'ter_ledger.sqlite'));

    // NativeDatabase.createInBackground runs all disk I/O on a worker isolate
    return NativeDatabase.createInBackground(file);
  });
}
