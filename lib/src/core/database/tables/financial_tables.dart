import 'package:drift/drift.dart';

@DataClassName('AccountEntry')
class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get type => text()(); // 'bank', 'cash', 'wallet'
  IntColumn get openingBalancePaise => integer().withDefault(const Constant(0))();
  IntColumn get currentBalancePaise => integer().withDefault(const Constant(0))();
  TextColumn get currencyCode => text().withDefault(const Constant('INR'))();
  TextColumn get icon => text().nullable()();
  TextColumn get colorHex => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CardEntry')
class Cards extends Table {
  TextColumn get id => text()();
  TextColumn get accountId => text().nullable().references(Accounts, #id)();
  TextColumn get cardName => text().withLength(min: 1, max: 100)();
  TextColumn get cardType => text()(); // 'credit', 'debit', 'prepaid'
  TextColumn get issuerBank => text()();
  TextColumn get last4Digits => text().withLength(min: 4, max: 4)();
  TextColumn get cardholderName => text().nullable()();
  IntColumn get billingCycleDay => integer().nullable()();
  IntColumn get paymentDueDay => integer().nullable()();
  IntColumn get creditLimitPaise => integer().nullable()();
  IntColumn get currentOutstandingPaise => integer().withDefault(const Constant(0))();
  TextColumn get skinType => text().withDefault(const Constant('preset'))(); // 'preset', 'custom_image'
  TextColumn get skinAssetOrPath => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CategoryEntry')
class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get type => text()(); // 'expense', 'income', 'transfer'
  TextColumn get icon => text()();
  TextColumn get colorHex => text()();
  TextColumn get parentId => text().nullable().references(Categories, #id)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PersonEntry')
class Persons extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get phone => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get outstandingBalancePaise => integer().withDefault(const Constant(0))();
  TextColumn get avatarColor => text().withDefault(const Constant('2563EB'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DebtEntry')
class Debts extends Table {
  TextColumn get id => text()();
  TextColumn get personId => text().references(Persons, #id)();
  TextColumn get type => text()(); // 'lent', 'borrowed'
  IntColumn get principalPaise => integer()();
  IntColumn get outstandingBalancePaise => integer()();
  DateTimeColumn get initialDate => dateTime()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))(); // 'active', 'partiallyPaid', 'fullySettled'
  TextColumn get initialTransactionId => text().nullable()();
  TextColumn get splitGroupId => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DebtRepaymentEntry')
class DebtRepayments extends Table {
  TextColumn get id => text()();
  TextColumn get debtId => text().references(Debts, #id)();
  TextColumn get transactionId => text().nullable()();
  IntColumn get amountPaise => integer()();
  DateTimeColumn get repaymentDate => dateTime()();
  IntColumn get balanceAfterRepaymentPaise => integer()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SplitTransactionEntry')
class SplitTransactions extends Table {
  TextColumn get id => text()();
  IntColumn get totalBillPaise => integer()();
  TextColumn get description => text()();
  TextColumn get categoryId => text().nullable().references(Categories, #id)();
  TextColumn get paidFromAccountId => text().nullable().references(Accounts, #id)();
  TextColumn get cardId => text().nullable().references(Cards, #id)();
  IntColumn get mySharePaise => integer()();
  DateTimeColumn get transactionTimestamp => dateTime()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TransactionEntry')
class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()(); // 'income', 'expense', 'splitExpense', 'transfer', 'debtLend', 'debtBorrow', 'debtRepayment', 'creditCardPayment'
  IntColumn get amountPaise => integer()();
  TextColumn get fromAccountId => text().nullable().references(Accounts, #id)();
  TextColumn get toAccountId => text().nullable().references(Accounts, #id)();
  TextColumn get cardId => text().nullable().references(Cards, #id)();
  TextColumn get categoryId => text().nullable().references(Categories, #id)();
  TextColumn get personId => text().nullable().references(Persons, #id)();
  TextColumn get splitGroupId => text().nullable()();
  IntColumn get totalBillPaise => integer().nullable()();
  DateTimeColumn get transactionTimestamp => dateTime()();
  TextColumn get note => text().nullable()();
  BoolColumn get isExcludedFromBudget => boolean().withDefault(const Constant(false))();
  BoolColumn get isCleared => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DailyBudgetConfigEntry')
class DailyBudgetConfigTable extends Table {
  TextColumn get id => text()();
  IntColumn get dailyAllocationPaise => integer()();
  BoolColumn get enableCarryForward => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DailyBudgetSnapshotEntry')
class DailyBudgetSnapshots extends Table {
  IntColumn get dateEpochDay => integer()();
  IntColumn get allocatedPaise => integer()();
  IntColumn get spentPaise => integer()();
  IntColumn get carriedForwardPaise => integer()();
  IntColumn get netAvailablePaise => integer()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {dateEpochDay};
}
