import 'package:drift/drift.dart';

@DataClassName('AccountEntry')
class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get type => text()(); // 'bank', 'cash', 'wallet'
  Int64Column get openingBalancePaise => int64().withDefault(const Constant(0))();
  Int64Column get currentBalancePaise => int64().withDefault(const Constant(0))();
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
  Int64Column get creditLimitPaise => int64().nullable()();
  Int64Column get currentOutstandingPaise => int64().withDefault(const Constant(0))();
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
  Int64Column get principalPaise => int64()();
  Int64Column get outstandingBalancePaise => int64()();
  DateTimeColumn get initialDate => dateTime()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))(); // 'active', 'partiallyPaid', 'fullySettled'
  TextColumn get initialTransactionId => text().nullable()();
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
  Int64Column get amountPaise => int64()();
  DateTimeColumn get repaymentDate => dateTime()();
  Int64Column get balanceAfterRepaymentPaise => int64()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TransactionEntry')
class Transactions extends Table {
  TextColumn get id => text()();
  TextColumn get type => text()(); // 'income', 'expense', 'transfer', 'debtLend', 'debtBorrow', 'debtRepayment', 'creditCardPayment'
  Int64Column get amountPaise => int64()();
  TextColumn get fromAccountId => text().nullable().references(Accounts, #id)();
  TextColumn get toAccountId => text().nullable().references(Accounts, #id)();
  TextColumn get cardId => text().nullable().references(Cards, #id)();
  TextColumn get categoryId => text().nullable().references(Categories, #id)();
  TextColumn get personId => text().nullable().references(Persons, #id)();
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
  Int64Column get dailyAllocationPaise => int64()();
  BoolColumn get enableCarryForward => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DailyBudgetSnapshotEntry')
class DailyBudgetSnapshots extends Table {
  IntColumn get dateEpochDay => integer()();
  Int64Column get allocatedPaise => int64()();
  Int64Column get spentPaise => int64()();
  Int64Column get carriedForwardPaise => int64()();
  Int64Column get netAvailablePaise => int64()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {dateEpochDay};
}
