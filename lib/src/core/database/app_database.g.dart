// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AccountsTable extends Accounts
    with TableInfo<$AccountsTable, AccountEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _openingBalancePaiseMeta =
      const VerificationMeta('openingBalancePaise');
  @override
  late final GeneratedColumn<int> openingBalancePaise = GeneratedColumn<int>(
      'opening_balance_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _currentBalancePaiseMeta =
      const VerificationMeta('currentBalancePaise');
  @override
  late final GeneratedColumn<int> currentBalancePaise = GeneratedColumn<int>(
      'current_balance_paise', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _currencyCodeMeta =
      const VerificationMeta('currencyCode');
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
      'currency_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('INR'));
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        type,
        openingBalancePaise,
        currentBalancePaise,
        currencyCode,
        icon,
        colorHex,
        isArchived,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts';
  @override
  VerificationContext validateIntegrity(Insertable<AccountEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('opening_balance_paise')) {
      context.handle(
          _openingBalancePaiseMeta,
          openingBalancePaise.isAcceptableOrUnknown(
              data['opening_balance_paise']!, _openingBalancePaiseMeta));
    }
    if (data.containsKey('current_balance_paise')) {
      context.handle(
          _currentBalancePaiseMeta,
          currentBalancePaise.isAcceptableOrUnknown(
              data['current_balance_paise']!, _currentBalancePaiseMeta));
    }
    if (data.containsKey('currency_code')) {
      context.handle(
          _currencyCodeMeta,
          currencyCode.isAcceptableOrUnknown(
              data['currency_code']!, _currencyCodeMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      openingBalancePaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}opening_balance_paise'])!,
      currentBalancePaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}current_balance_paise'])!,
      currencyCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_code'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex']),
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AccountsTable createAlias(String alias) {
    return $AccountsTable(attachedDatabase, alias);
  }
}

class AccountEntry extends DataClass implements Insertable<AccountEntry> {
  final String id;
  final String name;
  final String type;
  final int openingBalancePaise;
  final int currentBalancePaise;
  final String currencyCode;
  final String? icon;
  final String? colorHex;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AccountEntry(
      {required this.id,
      required this.name,
      required this.type,
      required this.openingBalancePaise,
      required this.currentBalancePaise,
      required this.currencyCode,
      this.icon,
      this.colorHex,
      required this.isArchived,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['opening_balance_paise'] = Variable<int>(openingBalancePaise);
    map['current_balance_paise'] = Variable<int>(currentBalancePaise);
    map['currency_code'] = Variable<String>(currencyCode);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || colorHex != null) {
      map['color_hex'] = Variable<String>(colorHex);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AccountsCompanion toCompanion(bool nullToAbsent) {
    return AccountsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      openingBalancePaise: Value(openingBalancePaise),
      currentBalancePaise: Value(currentBalancePaise),
      currencyCode: Value(currencyCode),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      colorHex: colorHex == null && nullToAbsent
          ? const Value.absent()
          : Value(colorHex),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AccountEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      openingBalancePaise:
          serializer.fromJson<int>(json['openingBalancePaise']),
      currentBalancePaise:
          serializer.fromJson<int>(json['currentBalancePaise']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      icon: serializer.fromJson<String?>(json['icon']),
      colorHex: serializer.fromJson<String?>(json['colorHex']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'openingBalancePaise': serializer.toJson<int>(openingBalancePaise),
      'currentBalancePaise': serializer.toJson<int>(currentBalancePaise),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'icon': serializer.toJson<String?>(icon),
      'colorHex': serializer.toJson<String?>(colorHex),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AccountEntry copyWith(
          {String? id,
          String? name,
          String? type,
          int? openingBalancePaise,
          int? currentBalancePaise,
          String? currencyCode,
          Value<String?> icon = const Value.absent(),
          Value<String?> colorHex = const Value.absent(),
          bool? isArchived,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      AccountEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        openingBalancePaise: openingBalancePaise ?? this.openingBalancePaise,
        currentBalancePaise: currentBalancePaise ?? this.currentBalancePaise,
        currencyCode: currencyCode ?? this.currencyCode,
        icon: icon.present ? icon.value : this.icon,
        colorHex: colorHex.present ? colorHex.value : this.colorHex,
        isArchived: isArchived ?? this.isArchived,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AccountEntry copyWithCompanion(AccountsCompanion data) {
    return AccountEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      openingBalancePaise: data.openingBalancePaise.present
          ? data.openingBalancePaise.value
          : this.openingBalancePaise,
      currentBalancePaise: data.currentBalancePaise.present
          ? data.currentBalancePaise.value
          : this.currentBalancePaise,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      icon: data.icon.present ? data.icon.value : this.icon,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('openingBalancePaise: $openingBalancePaise, ')
          ..write('currentBalancePaise: $currentBalancePaise, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('icon: $icon, ')
          ..write('colorHex: $colorHex, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      type,
      openingBalancePaise,
      currentBalancePaise,
      currencyCode,
      icon,
      colorHex,
      isArchived,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.openingBalancePaise == this.openingBalancePaise &&
          other.currentBalancePaise == this.currentBalancePaise &&
          other.currencyCode == this.currencyCode &&
          other.icon == this.icon &&
          other.colorHex == this.colorHex &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AccountsCompanion extends UpdateCompanion<AccountEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<int> openingBalancePaise;
  final Value<int> currentBalancePaise;
  final Value<String> currencyCode;
  final Value<String?> icon;
  final Value<String?> colorHex;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.openingBalancePaise = const Value.absent(),
    this.currentBalancePaise = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.icon = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccountsCompanion.insert({
    required String id,
    required String name,
    required String type,
    this.openingBalancePaise = const Value.absent(),
    this.currentBalancePaise = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.icon = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<AccountEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? openingBalancePaise,
    Expression<int>? currentBalancePaise,
    Expression<String>? currencyCode,
    Expression<String>? icon,
    Expression<String>? colorHex,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (openingBalancePaise != null)
        'opening_balance_paise': openingBalancePaise,
      if (currentBalancePaise != null)
        'current_balance_paise': currentBalancePaise,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (icon != null) 'icon': icon,
      if (colorHex != null) 'color_hex': colorHex,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccountsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? type,
      Value<int>? openingBalancePaise,
      Value<int>? currentBalancePaise,
      Value<String>? currencyCode,
      Value<String?>? icon,
      Value<String?>? colorHex,
      Value<bool>? isArchived,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return AccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      openingBalancePaise: openingBalancePaise ?? this.openingBalancePaise,
      currentBalancePaise: currentBalancePaise ?? this.currentBalancePaise,
      currencyCode: currencyCode ?? this.currencyCode,
      icon: icon ?? this.icon,
      colorHex: colorHex ?? this.colorHex,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (openingBalancePaise.present) {
      map['opening_balance_paise'] = Variable<int>(openingBalancePaise.value);
    }
    if (currentBalancePaise.present) {
      map['current_balance_paise'] = Variable<int>(currentBalancePaise.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('openingBalancePaise: $openingBalancePaise, ')
          ..write('currentBalancePaise: $currentBalancePaise, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('icon: $icon, ')
          ..write('colorHex: $colorHex, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CardsTable extends Cards with TableInfo<$CardsTable, CardEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _accountIdMeta =
      const VerificationMeta('accountId');
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
      'account_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES accounts (id)'));
  static const VerificationMeta _cardNameMeta =
      const VerificationMeta('cardName');
  @override
  late final GeneratedColumn<String> cardName = GeneratedColumn<String>(
      'card_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _cardTypeMeta =
      const VerificationMeta('cardType');
  @override
  late final GeneratedColumn<String> cardType = GeneratedColumn<String>(
      'card_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _issuerBankMeta =
      const VerificationMeta('issuerBank');
  @override
  late final GeneratedColumn<String> issuerBank = GeneratedColumn<String>(
      'issuer_bank', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _last4DigitsMeta =
      const VerificationMeta('last4Digits');
  @override
  late final GeneratedColumn<String> last4Digits = GeneratedColumn<String>(
      'last4_digits', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _cardholderNameMeta =
      const VerificationMeta('cardholderName');
  @override
  late final GeneratedColumn<String> cardholderName = GeneratedColumn<String>(
      'cardholder_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _billingCycleDayMeta =
      const VerificationMeta('billingCycleDay');
  @override
  late final GeneratedColumn<int> billingCycleDay = GeneratedColumn<int>(
      'billing_cycle_day', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _paymentDueDayMeta =
      const VerificationMeta('paymentDueDay');
  @override
  late final GeneratedColumn<int> paymentDueDay = GeneratedColumn<int>(
      'payment_due_day', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _creditLimitPaiseMeta =
      const VerificationMeta('creditLimitPaise');
  @override
  late final GeneratedColumn<int> creditLimitPaise = GeneratedColumn<int>(
      'credit_limit_paise', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _currentOutstandingPaiseMeta =
      const VerificationMeta('currentOutstandingPaise');
  @override
  late final GeneratedColumn<int> currentOutstandingPaise =
      GeneratedColumn<int>('current_outstanding_paise', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _skinTypeMeta =
      const VerificationMeta('skinType');
  @override
  late final GeneratedColumn<String> skinType = GeneratedColumn<String>(
      'skin_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('preset'));
  static const VerificationMeta _skinAssetOrPathMeta =
      const VerificationMeta('skinAssetOrPath');
  @override
  late final GeneratedColumn<String> skinAssetOrPath = GeneratedColumn<String>(
      'skin_asset_or_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        accountId,
        cardName,
        cardType,
        issuerBank,
        last4Digits,
        cardholderName,
        billingCycleDay,
        paymentDueDay,
        creditLimitPaise,
        currentOutstandingPaise,
        skinType,
        skinAssetOrPath,
        isArchived,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cards';
  @override
  VerificationContext validateIntegrity(Insertable<CardEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta,
          accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    }
    if (data.containsKey('card_name')) {
      context.handle(_cardNameMeta,
          cardName.isAcceptableOrUnknown(data['card_name']!, _cardNameMeta));
    } else if (isInserting) {
      context.missing(_cardNameMeta);
    }
    if (data.containsKey('card_type')) {
      context.handle(_cardTypeMeta,
          cardType.isAcceptableOrUnknown(data['card_type']!, _cardTypeMeta));
    } else if (isInserting) {
      context.missing(_cardTypeMeta);
    }
    if (data.containsKey('issuer_bank')) {
      context.handle(
          _issuerBankMeta,
          issuerBank.isAcceptableOrUnknown(
              data['issuer_bank']!, _issuerBankMeta));
    } else if (isInserting) {
      context.missing(_issuerBankMeta);
    }
    if (data.containsKey('last4_digits')) {
      context.handle(
          _last4DigitsMeta,
          last4Digits.isAcceptableOrUnknown(
              data['last4_digits']!, _last4DigitsMeta));
    } else if (isInserting) {
      context.missing(_last4DigitsMeta);
    }
    if (data.containsKey('cardholder_name')) {
      context.handle(
          _cardholderNameMeta,
          cardholderName.isAcceptableOrUnknown(
              data['cardholder_name']!, _cardholderNameMeta));
    }
    if (data.containsKey('billing_cycle_day')) {
      context.handle(
          _billingCycleDayMeta,
          billingCycleDay.isAcceptableOrUnknown(
              data['billing_cycle_day']!, _billingCycleDayMeta));
    }
    if (data.containsKey('payment_due_day')) {
      context.handle(
          _paymentDueDayMeta,
          paymentDueDay.isAcceptableOrUnknown(
              data['payment_due_day']!, _paymentDueDayMeta));
    }
    if (data.containsKey('credit_limit_paise')) {
      context.handle(
          _creditLimitPaiseMeta,
          creditLimitPaise.isAcceptableOrUnknown(
              data['credit_limit_paise']!, _creditLimitPaiseMeta));
    }
    if (data.containsKey('current_outstanding_paise')) {
      context.handle(
          _currentOutstandingPaiseMeta,
          currentOutstandingPaise.isAcceptableOrUnknown(
              data['current_outstanding_paise']!,
              _currentOutstandingPaiseMeta));
    }
    if (data.containsKey('skin_type')) {
      context.handle(_skinTypeMeta,
          skinType.isAcceptableOrUnknown(data['skin_type']!, _skinTypeMeta));
    }
    if (data.containsKey('skin_asset_or_path')) {
      context.handle(
          _skinAssetOrPathMeta,
          skinAssetOrPath.isAcceptableOrUnknown(
              data['skin_asset_or_path']!, _skinAssetOrPathMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CardEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      accountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_id']),
      cardName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_name'])!,
      cardType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_type'])!,
      issuerBank: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}issuer_bank'])!,
      last4Digits: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last4_digits'])!,
      cardholderName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cardholder_name']),
      billingCycleDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}billing_cycle_day']),
      paymentDueDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}payment_due_day']),
      creditLimitPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}credit_limit_paise']),
      currentOutstandingPaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}current_outstanding_paise'])!,
      skinType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}skin_type'])!,
      skinAssetOrPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}skin_asset_or_path']),
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CardsTable createAlias(String alias) {
    return $CardsTable(attachedDatabase, alias);
  }
}

class CardEntry extends DataClass implements Insertable<CardEntry> {
  final String id;
  final String? accountId;
  final String cardName;
  final String cardType;
  final String issuerBank;
  final String last4Digits;
  final String? cardholderName;
  final int? billingCycleDay;
  final int? paymentDueDay;
  final int? creditLimitPaise;
  final int currentOutstandingPaise;
  final String skinType;
  final String? skinAssetOrPath;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CardEntry(
      {required this.id,
      this.accountId,
      required this.cardName,
      required this.cardType,
      required this.issuerBank,
      required this.last4Digits,
      this.cardholderName,
      this.billingCycleDay,
      this.paymentDueDay,
      this.creditLimitPaise,
      required this.currentOutstandingPaise,
      required this.skinType,
      this.skinAssetOrPath,
      required this.isArchived,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<String>(accountId);
    }
    map['card_name'] = Variable<String>(cardName);
    map['card_type'] = Variable<String>(cardType);
    map['issuer_bank'] = Variable<String>(issuerBank);
    map['last4_digits'] = Variable<String>(last4Digits);
    if (!nullToAbsent || cardholderName != null) {
      map['cardholder_name'] = Variable<String>(cardholderName);
    }
    if (!nullToAbsent || billingCycleDay != null) {
      map['billing_cycle_day'] = Variable<int>(billingCycleDay);
    }
    if (!nullToAbsent || paymentDueDay != null) {
      map['payment_due_day'] = Variable<int>(paymentDueDay);
    }
    if (!nullToAbsent || creditLimitPaise != null) {
      map['credit_limit_paise'] = Variable<int>(creditLimitPaise);
    }
    map['current_outstanding_paise'] = Variable<int>(currentOutstandingPaise);
    map['skin_type'] = Variable<String>(skinType);
    if (!nullToAbsent || skinAssetOrPath != null) {
      map['skin_asset_or_path'] = Variable<String>(skinAssetOrPath);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CardsCompanion toCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: Value(id),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      cardName: Value(cardName),
      cardType: Value(cardType),
      issuerBank: Value(issuerBank),
      last4Digits: Value(last4Digits),
      cardholderName: cardholderName == null && nullToAbsent
          ? const Value.absent()
          : Value(cardholderName),
      billingCycleDay: billingCycleDay == null && nullToAbsent
          ? const Value.absent()
          : Value(billingCycleDay),
      paymentDueDay: paymentDueDay == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentDueDay),
      creditLimitPaise: creditLimitPaise == null && nullToAbsent
          ? const Value.absent()
          : Value(creditLimitPaise),
      currentOutstandingPaise: Value(currentOutstandingPaise),
      skinType: Value(skinType),
      skinAssetOrPath: skinAssetOrPath == null && nullToAbsent
          ? const Value.absent()
          : Value(skinAssetOrPath),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CardEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardEntry(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String?>(json['accountId']),
      cardName: serializer.fromJson<String>(json['cardName']),
      cardType: serializer.fromJson<String>(json['cardType']),
      issuerBank: serializer.fromJson<String>(json['issuerBank']),
      last4Digits: serializer.fromJson<String>(json['last4Digits']),
      cardholderName: serializer.fromJson<String?>(json['cardholderName']),
      billingCycleDay: serializer.fromJson<int?>(json['billingCycleDay']),
      paymentDueDay: serializer.fromJson<int?>(json['paymentDueDay']),
      creditLimitPaise: serializer.fromJson<int?>(json['creditLimitPaise']),
      currentOutstandingPaise:
          serializer.fromJson<int>(json['currentOutstandingPaise']),
      skinType: serializer.fromJson<String>(json['skinType']),
      skinAssetOrPath: serializer.fromJson<String?>(json['skinAssetOrPath']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String?>(accountId),
      'cardName': serializer.toJson<String>(cardName),
      'cardType': serializer.toJson<String>(cardType),
      'issuerBank': serializer.toJson<String>(issuerBank),
      'last4Digits': serializer.toJson<String>(last4Digits),
      'cardholderName': serializer.toJson<String?>(cardholderName),
      'billingCycleDay': serializer.toJson<int?>(billingCycleDay),
      'paymentDueDay': serializer.toJson<int?>(paymentDueDay),
      'creditLimitPaise': serializer.toJson<int?>(creditLimitPaise),
      'currentOutstandingPaise':
          serializer.toJson<int>(currentOutstandingPaise),
      'skinType': serializer.toJson<String>(skinType),
      'skinAssetOrPath': serializer.toJson<String?>(skinAssetOrPath),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CardEntry copyWith(
          {String? id,
          Value<String?> accountId = const Value.absent(),
          String? cardName,
          String? cardType,
          String? issuerBank,
          String? last4Digits,
          Value<String?> cardholderName = const Value.absent(),
          Value<int?> billingCycleDay = const Value.absent(),
          Value<int?> paymentDueDay = const Value.absent(),
          Value<int?> creditLimitPaise = const Value.absent(),
          int? currentOutstandingPaise,
          String? skinType,
          Value<String?> skinAssetOrPath = const Value.absent(),
          bool? isArchived,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CardEntry(
        id: id ?? this.id,
        accountId: accountId.present ? accountId.value : this.accountId,
        cardName: cardName ?? this.cardName,
        cardType: cardType ?? this.cardType,
        issuerBank: issuerBank ?? this.issuerBank,
        last4Digits: last4Digits ?? this.last4Digits,
        cardholderName:
            cardholderName.present ? cardholderName.value : this.cardholderName,
        billingCycleDay: billingCycleDay.present
            ? billingCycleDay.value
            : this.billingCycleDay,
        paymentDueDay:
            paymentDueDay.present ? paymentDueDay.value : this.paymentDueDay,
        creditLimitPaise: creditLimitPaise.present
            ? creditLimitPaise.value
            : this.creditLimitPaise,
        currentOutstandingPaise:
            currentOutstandingPaise ?? this.currentOutstandingPaise,
        skinType: skinType ?? this.skinType,
        skinAssetOrPath: skinAssetOrPath.present
            ? skinAssetOrPath.value
            : this.skinAssetOrPath,
        isArchived: isArchived ?? this.isArchived,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CardEntry copyWithCompanion(CardsCompanion data) {
    return CardEntry(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      cardName: data.cardName.present ? data.cardName.value : this.cardName,
      cardType: data.cardType.present ? data.cardType.value : this.cardType,
      issuerBank:
          data.issuerBank.present ? data.issuerBank.value : this.issuerBank,
      last4Digits:
          data.last4Digits.present ? data.last4Digits.value : this.last4Digits,
      cardholderName: data.cardholderName.present
          ? data.cardholderName.value
          : this.cardholderName,
      billingCycleDay: data.billingCycleDay.present
          ? data.billingCycleDay.value
          : this.billingCycleDay,
      paymentDueDay: data.paymentDueDay.present
          ? data.paymentDueDay.value
          : this.paymentDueDay,
      creditLimitPaise: data.creditLimitPaise.present
          ? data.creditLimitPaise.value
          : this.creditLimitPaise,
      currentOutstandingPaise: data.currentOutstandingPaise.present
          ? data.currentOutstandingPaise.value
          : this.currentOutstandingPaise,
      skinType: data.skinType.present ? data.skinType.value : this.skinType,
      skinAssetOrPath: data.skinAssetOrPath.present
          ? data.skinAssetOrPath.value
          : this.skinAssetOrPath,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardEntry(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('cardName: $cardName, ')
          ..write('cardType: $cardType, ')
          ..write('issuerBank: $issuerBank, ')
          ..write('last4Digits: $last4Digits, ')
          ..write('cardholderName: $cardholderName, ')
          ..write('billingCycleDay: $billingCycleDay, ')
          ..write('paymentDueDay: $paymentDueDay, ')
          ..write('creditLimitPaise: $creditLimitPaise, ')
          ..write('currentOutstandingPaise: $currentOutstandingPaise, ')
          ..write('skinType: $skinType, ')
          ..write('skinAssetOrPath: $skinAssetOrPath, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      accountId,
      cardName,
      cardType,
      issuerBank,
      last4Digits,
      cardholderName,
      billingCycleDay,
      paymentDueDay,
      creditLimitPaise,
      currentOutstandingPaise,
      skinType,
      skinAssetOrPath,
      isArchived,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardEntry &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.cardName == this.cardName &&
          other.cardType == this.cardType &&
          other.issuerBank == this.issuerBank &&
          other.last4Digits == this.last4Digits &&
          other.cardholderName == this.cardholderName &&
          other.billingCycleDay == this.billingCycleDay &&
          other.paymentDueDay == this.paymentDueDay &&
          other.creditLimitPaise == this.creditLimitPaise &&
          other.currentOutstandingPaise == this.currentOutstandingPaise &&
          other.skinType == this.skinType &&
          other.skinAssetOrPath == this.skinAssetOrPath &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CardsCompanion extends UpdateCompanion<CardEntry> {
  final Value<String> id;
  final Value<String?> accountId;
  final Value<String> cardName;
  final Value<String> cardType;
  final Value<String> issuerBank;
  final Value<String> last4Digits;
  final Value<String?> cardholderName;
  final Value<int?> billingCycleDay;
  final Value<int?> paymentDueDay;
  final Value<int?> creditLimitPaise;
  final Value<int> currentOutstandingPaise;
  final Value<String> skinType;
  final Value<String?> skinAssetOrPath;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.cardName = const Value.absent(),
    this.cardType = const Value.absent(),
    this.issuerBank = const Value.absent(),
    this.last4Digits = const Value.absent(),
    this.cardholderName = const Value.absent(),
    this.billingCycleDay = const Value.absent(),
    this.paymentDueDay = const Value.absent(),
    this.creditLimitPaise = const Value.absent(),
    this.currentOutstandingPaise = const Value.absent(),
    this.skinType = const Value.absent(),
    this.skinAssetOrPath = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CardsCompanion.insert({
    required String id,
    this.accountId = const Value.absent(),
    required String cardName,
    required String cardType,
    required String issuerBank,
    required String last4Digits,
    this.cardholderName = const Value.absent(),
    this.billingCycleDay = const Value.absent(),
    this.paymentDueDay = const Value.absent(),
    this.creditLimitPaise = const Value.absent(),
    this.currentOutstandingPaise = const Value.absent(),
    this.skinType = const Value.absent(),
    this.skinAssetOrPath = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        cardName = Value(cardName),
        cardType = Value(cardType),
        issuerBank = Value(issuerBank),
        last4Digits = Value(last4Digits),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CardEntry> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<String>? cardName,
    Expression<String>? cardType,
    Expression<String>? issuerBank,
    Expression<String>? last4Digits,
    Expression<String>? cardholderName,
    Expression<int>? billingCycleDay,
    Expression<int>? paymentDueDay,
    Expression<int>? creditLimitPaise,
    Expression<int>? currentOutstandingPaise,
    Expression<String>? skinType,
    Expression<String>? skinAssetOrPath,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (cardName != null) 'card_name': cardName,
      if (cardType != null) 'card_type': cardType,
      if (issuerBank != null) 'issuer_bank': issuerBank,
      if (last4Digits != null) 'last4_digits': last4Digits,
      if (cardholderName != null) 'cardholder_name': cardholderName,
      if (billingCycleDay != null) 'billing_cycle_day': billingCycleDay,
      if (paymentDueDay != null) 'payment_due_day': paymentDueDay,
      if (creditLimitPaise != null) 'credit_limit_paise': creditLimitPaise,
      if (currentOutstandingPaise != null)
        'current_outstanding_paise': currentOutstandingPaise,
      if (skinType != null) 'skin_type': skinType,
      if (skinAssetOrPath != null) 'skin_asset_or_path': skinAssetOrPath,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CardsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? accountId,
      Value<String>? cardName,
      Value<String>? cardType,
      Value<String>? issuerBank,
      Value<String>? last4Digits,
      Value<String?>? cardholderName,
      Value<int?>? billingCycleDay,
      Value<int?>? paymentDueDay,
      Value<int?>? creditLimitPaise,
      Value<int>? currentOutstandingPaise,
      Value<String>? skinType,
      Value<String?>? skinAssetOrPath,
      Value<bool>? isArchived,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CardsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      cardName: cardName ?? this.cardName,
      cardType: cardType ?? this.cardType,
      issuerBank: issuerBank ?? this.issuerBank,
      last4Digits: last4Digits ?? this.last4Digits,
      cardholderName: cardholderName ?? this.cardholderName,
      billingCycleDay: billingCycleDay ?? this.billingCycleDay,
      paymentDueDay: paymentDueDay ?? this.paymentDueDay,
      creditLimitPaise: creditLimitPaise ?? this.creditLimitPaise,
      currentOutstandingPaise:
          currentOutstandingPaise ?? this.currentOutstandingPaise,
      skinType: skinType ?? this.skinType,
      skinAssetOrPath: skinAssetOrPath ?? this.skinAssetOrPath,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (cardName.present) {
      map['card_name'] = Variable<String>(cardName.value);
    }
    if (cardType.present) {
      map['card_type'] = Variable<String>(cardType.value);
    }
    if (issuerBank.present) {
      map['issuer_bank'] = Variable<String>(issuerBank.value);
    }
    if (last4Digits.present) {
      map['last4_digits'] = Variable<String>(last4Digits.value);
    }
    if (cardholderName.present) {
      map['cardholder_name'] = Variable<String>(cardholderName.value);
    }
    if (billingCycleDay.present) {
      map['billing_cycle_day'] = Variable<int>(billingCycleDay.value);
    }
    if (paymentDueDay.present) {
      map['payment_due_day'] = Variable<int>(paymentDueDay.value);
    }
    if (creditLimitPaise.present) {
      map['credit_limit_paise'] = Variable<int>(creditLimitPaise.value);
    }
    if (currentOutstandingPaise.present) {
      map['current_outstanding_paise'] =
          Variable<int>(currentOutstandingPaise.value);
    }
    if (skinType.present) {
      map['skin_type'] = Variable<String>(skinType.value);
    }
    if (skinAssetOrPath.present) {
      map['skin_asset_or_path'] = Variable<String>(skinAssetOrPath.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('cardName: $cardName, ')
          ..write('cardType: $cardType, ')
          ..write('issuerBank: $issuerBank, ')
          ..write('last4Digits: $last4Digits, ')
          ..write('cardholderName: $cardholderName, ')
          ..write('billingCycleDay: $billingCycleDay, ')
          ..write('paymentDueDay: $paymentDueDay, ')
          ..write('creditLimitPaise: $creditLimitPaise, ')
          ..write('currentOutstandingPaise: $currentOutstandingPaise, ')
          ..write('skinType: $skinType, ')
          ..write('skinAssetOrPath: $skinAssetOrPath, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, CategoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, type, icon, colorHex, parentId, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<CategoryEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    } else if (isInserting) {
      context.missing(_colorHexMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex'])!,
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_id']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class CategoryEntry extends DataClass implements Insertable<CategoryEntry> {
  final String id;
  final String name;
  final String type;
  final String icon;
  final String colorHex;
  final String? parentId;
  final int sortOrder;
  const CategoryEntry(
      {required this.id,
      required this.name,
      required this.type,
      required this.icon,
      required this.colorHex,
      this.parentId,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['icon'] = Variable<String>(icon);
    map['color_hex'] = Variable<String>(colorHex);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      icon: Value(icon),
      colorHex: Value(colorHex),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      sortOrder: Value(sortOrder),
    );
  }

  factory CategoryEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      icon: serializer.fromJson<String>(json['icon']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'icon': serializer.toJson<String>(icon),
      'colorHex': serializer.toJson<String>(colorHex),
      'parentId': serializer.toJson<String?>(parentId),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  CategoryEntry copyWith(
          {String? id,
          String? name,
          String? type,
          String? icon,
          String? colorHex,
          Value<String?> parentId = const Value.absent(),
          int? sortOrder}) =>
      CategoryEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        icon: icon ?? this.icon,
        colorHex: colorHex ?? this.colorHex,
        parentId: parentId.present ? parentId.value : this.parentId,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  CategoryEntry copyWithCompanion(CategoriesCompanion data) {
    return CategoryEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      icon: data.icon.present ? data.icon.value : this.icon,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('icon: $icon, ')
          ..write('colorHex: $colorHex, ')
          ..write('parentId: $parentId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, icon, colorHex, parentId, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.icon == this.icon &&
          other.colorHex == this.colorHex &&
          other.parentId == this.parentId &&
          other.sortOrder == this.sortOrder);
}

class CategoriesCompanion extends UpdateCompanion<CategoryEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> icon;
  final Value<String> colorHex;
  final Value<String?> parentId;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.icon = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.parentId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required String type,
    required String icon,
    required String colorHex,
    this.parentId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type),
        icon = Value(icon),
        colorHex = Value(colorHex);
  static Insertable<CategoryEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? icon,
    Expression<String>? colorHex,
    Expression<String>? parentId,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (icon != null) 'icon': icon,
      if (colorHex != null) 'color_hex': colorHex,
      if (parentId != null) 'parent_id': parentId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? type,
      Value<String>? icon,
      Value<String>? colorHex,
      Value<String?>? parentId,
      Value<int>? sortOrder,
      Value<int>? rowid}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      icon: icon ?? this.icon,
      colorHex: colorHex ?? this.colorHex,
      parentId: parentId ?? this.parentId,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('icon: $icon, ')
          ..write('colorHex: $colorHex, ')
          ..write('parentId: $parentId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PersonsTable extends Persons with TableInfo<$PersonsTable, PersonEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _outstandingBalancePaiseMeta =
      const VerificationMeta('outstandingBalancePaise');
  @override
  late final GeneratedColumn<int> outstandingBalancePaise =
      GeneratedColumn<int>('outstanding_balance_paise', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _avatarColorMeta =
      const VerificationMeta('avatarColor');
  @override
  late final GeneratedColumn<String> avatarColor = GeneratedColumn<String>(
      'avatar_color', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('2563EB'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        phone,
        email,
        notes,
        outstandingBalancePaise,
        avatarColor,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persons';
  @override
  VerificationContext validateIntegrity(Insertable<PersonEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('outstanding_balance_paise')) {
      context.handle(
          _outstandingBalancePaiseMeta,
          outstandingBalancePaise.isAcceptableOrUnknown(
              data['outstanding_balance_paise']!,
              _outstandingBalancePaiseMeta));
    }
    if (data.containsKey('avatar_color')) {
      context.handle(
          _avatarColorMeta,
          avatarColor.isAcceptableOrUnknown(
              data['avatar_color']!, _avatarColorMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      outstandingBalancePaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}outstanding_balance_paise'])!,
      avatarColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_color'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PersonsTable createAlias(String alias) {
    return $PersonsTable(attachedDatabase, alias);
  }
}

class PersonEntry extends DataClass implements Insertable<PersonEntry> {
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final String? notes;
  final int outstandingBalancePaise;
  final String avatarColor;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PersonEntry(
      {required this.id,
      required this.name,
      this.phone,
      this.email,
      this.notes,
      required this.outstandingBalancePaise,
      required this.avatarColor,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['outstanding_balance_paise'] = Variable<int>(outstandingBalancePaise);
    map['avatar_color'] = Variable<String>(avatarColor);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PersonsCompanion toCompanion(bool nullToAbsent) {
    return PersonsCompanion(
      id: Value(id),
      name: Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      outstandingBalancePaise: Value(outstandingBalancePaise),
      avatarColor: Value(avatarColor),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PersonEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonEntry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      notes: serializer.fromJson<String?>(json['notes']),
      outstandingBalancePaise:
          serializer.fromJson<int>(json['outstandingBalancePaise']),
      avatarColor: serializer.fromJson<String>(json['avatarColor']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'notes': serializer.toJson<String?>(notes),
      'outstandingBalancePaise':
          serializer.toJson<int>(outstandingBalancePaise),
      'avatarColor': serializer.toJson<String>(avatarColor),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PersonEntry copyWith(
          {String? id,
          String? name,
          Value<String?> phone = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          int? outstandingBalancePaise,
          String? avatarColor,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PersonEntry(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone.present ? phone.value : this.phone,
        email: email.present ? email.value : this.email,
        notes: notes.present ? notes.value : this.notes,
        outstandingBalancePaise:
            outstandingBalancePaise ?? this.outstandingBalancePaise,
        avatarColor: avatarColor ?? this.avatarColor,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PersonEntry copyWithCompanion(PersonsCompanion data) {
    return PersonEntry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      notes: data.notes.present ? data.notes.value : this.notes,
      outstandingBalancePaise: data.outstandingBalancePaise.present
          ? data.outstandingBalancePaise.value
          : this.outstandingBalancePaise,
      avatarColor:
          data.avatarColor.present ? data.avatarColor.value : this.avatarColor,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonEntry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('notes: $notes, ')
          ..write('outstandingBalancePaise: $outstandingBalancePaise, ')
          ..write('avatarColor: $avatarColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone, email, notes,
      outstandingBalancePaise, avatarColor, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonEntry &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.notes == this.notes &&
          other.outstandingBalancePaise == this.outstandingBalancePaise &&
          other.avatarColor == this.avatarColor &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PersonsCompanion extends UpdateCompanion<PersonEntry> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> notes;
  final Value<int> outstandingBalancePaise;
  final Value<String> avatarColor;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PersonsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.notes = const Value.absent(),
    this.outstandingBalancePaise = const Value.absent(),
    this.avatarColor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersonsCompanion.insert({
    required String id,
    required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.notes = const Value.absent(),
    this.outstandingBalancePaise = const Value.absent(),
    this.avatarColor = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PersonEntry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? notes,
    Expression<int>? outstandingBalancePaise,
    Expression<String>? avatarColor,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (notes != null) 'notes': notes,
      if (outstandingBalancePaise != null)
        'outstanding_balance_paise': outstandingBalancePaise,
      if (avatarColor != null) 'avatar_color': avatarColor,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersonsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? phone,
      Value<String?>? email,
      Value<String?>? notes,
      Value<int>? outstandingBalancePaise,
      Value<String>? avatarColor,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PersonsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      notes: notes ?? this.notes,
      outstandingBalancePaise:
          outstandingBalancePaise ?? this.outstandingBalancePaise,
      avatarColor: avatarColor ?? this.avatarColor,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (outstandingBalancePaise.present) {
      map['outstanding_balance_paise'] =
          Variable<int>(outstandingBalancePaise.value);
    }
    if (avatarColor.present) {
      map['avatar_color'] = Variable<String>(avatarColor.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('notes: $notes, ')
          ..write('outstandingBalancePaise: $outstandingBalancePaise, ')
          ..write('avatarColor: $avatarColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DebtsTable extends Debts with TableInfo<$DebtsTable, DebtEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _personIdMeta =
      const VerificationMeta('personId');
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
      'person_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES persons (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _principalPaiseMeta =
      const VerificationMeta('principalPaise');
  @override
  late final GeneratedColumn<int> principalPaise = GeneratedColumn<int>(
      'principal_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _outstandingBalancePaiseMeta =
      const VerificationMeta('outstandingBalancePaise');
  @override
  late final GeneratedColumn<int> outstandingBalancePaise =
      GeneratedColumn<int>('outstanding_balance_paise', aliasedName, false,
          type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _initialDateMeta =
      const VerificationMeta('initialDate');
  @override
  late final GeneratedColumn<DateTime> initialDate = GeneratedColumn<DateTime>(
      'initial_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _initialTransactionIdMeta =
      const VerificationMeta('initialTransactionId');
  @override
  late final GeneratedColumn<String> initialTransactionId =
      GeneratedColumn<String>('initial_transaction_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _splitGroupIdMeta =
      const VerificationMeta('splitGroupId');
  @override
  late final GeneratedColumn<String> splitGroupId = GeneratedColumn<String>(
      'split_group_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        personId,
        type,
        principalPaise,
        outstandingBalancePaise,
        initialDate,
        dueDate,
        status,
        initialTransactionId,
        splitGroupId,
        notes,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debts';
  @override
  VerificationContext validateIntegrity(Insertable<DebtEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('person_id')) {
      context.handle(_personIdMeta,
          personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta));
    } else if (isInserting) {
      context.missing(_personIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('principal_paise')) {
      context.handle(
          _principalPaiseMeta,
          principalPaise.isAcceptableOrUnknown(
              data['principal_paise']!, _principalPaiseMeta));
    } else if (isInserting) {
      context.missing(_principalPaiseMeta);
    }
    if (data.containsKey('outstanding_balance_paise')) {
      context.handle(
          _outstandingBalancePaiseMeta,
          outstandingBalancePaise.isAcceptableOrUnknown(
              data['outstanding_balance_paise']!,
              _outstandingBalancePaiseMeta));
    } else if (isInserting) {
      context.missing(_outstandingBalancePaiseMeta);
    }
    if (data.containsKey('initial_date')) {
      context.handle(
          _initialDateMeta,
          initialDate.isAcceptableOrUnknown(
              data['initial_date']!, _initialDateMeta));
    } else if (isInserting) {
      context.missing(_initialDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('initial_transaction_id')) {
      context.handle(
          _initialTransactionIdMeta,
          initialTransactionId.isAcceptableOrUnknown(
              data['initial_transaction_id']!, _initialTransactionIdMeta));
    }
    if (data.containsKey('split_group_id')) {
      context.handle(
          _splitGroupIdMeta,
          splitGroupId.isAcceptableOrUnknown(
              data['split_group_id']!, _splitGroupIdMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DebtEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DebtEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      personId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      principalPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}principal_paise'])!,
      outstandingBalancePaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}outstanding_balance_paise'])!,
      initialDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}initial_date'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      initialTransactionId: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}initial_transaction_id']),
      splitGroupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}split_group_id']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DebtsTable createAlias(String alias) {
    return $DebtsTable(attachedDatabase, alias);
  }
}

class DebtEntry extends DataClass implements Insertable<DebtEntry> {
  final String id;
  final String personId;
  final String type;
  final int principalPaise;
  final int outstandingBalancePaise;
  final DateTime initialDate;
  final DateTime? dueDate;
  final String status;
  final String? initialTransactionId;
  final String? splitGroupId;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DebtEntry(
      {required this.id,
      required this.personId,
      required this.type,
      required this.principalPaise,
      required this.outstandingBalancePaise,
      required this.initialDate,
      this.dueDate,
      required this.status,
      this.initialTransactionId,
      this.splitGroupId,
      this.notes,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['person_id'] = Variable<String>(personId);
    map['type'] = Variable<String>(type);
    map['principal_paise'] = Variable<int>(principalPaise);
    map['outstanding_balance_paise'] = Variable<int>(outstandingBalancePaise);
    map['initial_date'] = Variable<DateTime>(initialDate);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || initialTransactionId != null) {
      map['initial_transaction_id'] = Variable<String>(initialTransactionId);
    }
    if (!nullToAbsent || splitGroupId != null) {
      map['split_group_id'] = Variable<String>(splitGroupId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DebtsCompanion toCompanion(bool nullToAbsent) {
    return DebtsCompanion(
      id: Value(id),
      personId: Value(personId),
      type: Value(type),
      principalPaise: Value(principalPaise),
      outstandingBalancePaise: Value(outstandingBalancePaise),
      initialDate: Value(initialDate),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      status: Value(status),
      initialTransactionId: initialTransactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(initialTransactionId),
      splitGroupId: splitGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(splitGroupId),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DebtEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DebtEntry(
      id: serializer.fromJson<String>(json['id']),
      personId: serializer.fromJson<String>(json['personId']),
      type: serializer.fromJson<String>(json['type']),
      principalPaise: serializer.fromJson<int>(json['principalPaise']),
      outstandingBalancePaise:
          serializer.fromJson<int>(json['outstandingBalancePaise']),
      initialDate: serializer.fromJson<DateTime>(json['initialDate']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      status: serializer.fromJson<String>(json['status']),
      initialTransactionId:
          serializer.fromJson<String?>(json['initialTransactionId']),
      splitGroupId: serializer.fromJson<String?>(json['splitGroupId']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'personId': serializer.toJson<String>(personId),
      'type': serializer.toJson<String>(type),
      'principalPaise': serializer.toJson<int>(principalPaise),
      'outstandingBalancePaise':
          serializer.toJson<int>(outstandingBalancePaise),
      'initialDate': serializer.toJson<DateTime>(initialDate),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'status': serializer.toJson<String>(status),
      'initialTransactionId': serializer.toJson<String?>(initialTransactionId),
      'splitGroupId': serializer.toJson<String?>(splitGroupId),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DebtEntry copyWith(
          {String? id,
          String? personId,
          String? type,
          int? principalPaise,
          int? outstandingBalancePaise,
          DateTime? initialDate,
          Value<DateTime?> dueDate = const Value.absent(),
          String? status,
          Value<String?> initialTransactionId = const Value.absent(),
          Value<String?> splitGroupId = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DebtEntry(
        id: id ?? this.id,
        personId: personId ?? this.personId,
        type: type ?? this.type,
        principalPaise: principalPaise ?? this.principalPaise,
        outstandingBalancePaise:
            outstandingBalancePaise ?? this.outstandingBalancePaise,
        initialDate: initialDate ?? this.initialDate,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        status: status ?? this.status,
        initialTransactionId: initialTransactionId.present
            ? initialTransactionId.value
            : this.initialTransactionId,
        splitGroupId:
            splitGroupId.present ? splitGroupId.value : this.splitGroupId,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DebtEntry copyWithCompanion(DebtsCompanion data) {
    return DebtEntry(
      id: data.id.present ? data.id.value : this.id,
      personId: data.personId.present ? data.personId.value : this.personId,
      type: data.type.present ? data.type.value : this.type,
      principalPaise: data.principalPaise.present
          ? data.principalPaise.value
          : this.principalPaise,
      outstandingBalancePaise: data.outstandingBalancePaise.present
          ? data.outstandingBalancePaise.value
          : this.outstandingBalancePaise,
      initialDate:
          data.initialDate.present ? data.initialDate.value : this.initialDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      status: data.status.present ? data.status.value : this.status,
      initialTransactionId: data.initialTransactionId.present
          ? data.initialTransactionId.value
          : this.initialTransactionId,
      splitGroupId: data.splitGroupId.present
          ? data.splitGroupId.value
          : this.splitGroupId,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DebtEntry(')
          ..write('id: $id, ')
          ..write('personId: $personId, ')
          ..write('type: $type, ')
          ..write('principalPaise: $principalPaise, ')
          ..write('outstandingBalancePaise: $outstandingBalancePaise, ')
          ..write('initialDate: $initialDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('initialTransactionId: $initialTransactionId, ')
          ..write('splitGroupId: $splitGroupId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      personId,
      type,
      principalPaise,
      outstandingBalancePaise,
      initialDate,
      dueDate,
      status,
      initialTransactionId,
      splitGroupId,
      notes,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DebtEntry &&
          other.id == this.id &&
          other.personId == this.personId &&
          other.type == this.type &&
          other.principalPaise == this.principalPaise &&
          other.outstandingBalancePaise == this.outstandingBalancePaise &&
          other.initialDate == this.initialDate &&
          other.dueDate == this.dueDate &&
          other.status == this.status &&
          other.initialTransactionId == this.initialTransactionId &&
          other.splitGroupId == this.splitGroupId &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DebtsCompanion extends UpdateCompanion<DebtEntry> {
  final Value<String> id;
  final Value<String> personId;
  final Value<String> type;
  final Value<int> principalPaise;
  final Value<int> outstandingBalancePaise;
  final Value<DateTime> initialDate;
  final Value<DateTime?> dueDate;
  final Value<String> status;
  final Value<String?> initialTransactionId;
  final Value<String?> splitGroupId;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DebtsCompanion({
    this.id = const Value.absent(),
    this.personId = const Value.absent(),
    this.type = const Value.absent(),
    this.principalPaise = const Value.absent(),
    this.outstandingBalancePaise = const Value.absent(),
    this.initialDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.status = const Value.absent(),
    this.initialTransactionId = const Value.absent(),
    this.splitGroupId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DebtsCompanion.insert({
    required String id,
    required String personId,
    required String type,
    required int principalPaise,
    required int outstandingBalancePaise,
    required DateTime initialDate,
    this.dueDate = const Value.absent(),
    this.status = const Value.absent(),
    this.initialTransactionId = const Value.absent(),
    this.splitGroupId = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        personId = Value(personId),
        type = Value(type),
        principalPaise = Value(principalPaise),
        outstandingBalancePaise = Value(outstandingBalancePaise),
        initialDate = Value(initialDate),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<DebtEntry> custom({
    Expression<String>? id,
    Expression<String>? personId,
    Expression<String>? type,
    Expression<int>? principalPaise,
    Expression<int>? outstandingBalancePaise,
    Expression<DateTime>? initialDate,
    Expression<DateTime>? dueDate,
    Expression<String>? status,
    Expression<String>? initialTransactionId,
    Expression<String>? splitGroupId,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (personId != null) 'person_id': personId,
      if (type != null) 'type': type,
      if (principalPaise != null) 'principal_paise': principalPaise,
      if (outstandingBalancePaise != null)
        'outstanding_balance_paise': outstandingBalancePaise,
      if (initialDate != null) 'initial_date': initialDate,
      if (dueDate != null) 'due_date': dueDate,
      if (status != null) 'status': status,
      if (initialTransactionId != null)
        'initial_transaction_id': initialTransactionId,
      if (splitGroupId != null) 'split_group_id': splitGroupId,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DebtsCompanion copyWith(
      {Value<String>? id,
      Value<String>? personId,
      Value<String>? type,
      Value<int>? principalPaise,
      Value<int>? outstandingBalancePaise,
      Value<DateTime>? initialDate,
      Value<DateTime?>? dueDate,
      Value<String>? status,
      Value<String?>? initialTransactionId,
      Value<String?>? splitGroupId,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return DebtsCompanion(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      type: type ?? this.type,
      principalPaise: principalPaise ?? this.principalPaise,
      outstandingBalancePaise:
          outstandingBalancePaise ?? this.outstandingBalancePaise,
      initialDate: initialDate ?? this.initialDate,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      initialTransactionId: initialTransactionId ?? this.initialTransactionId,
      splitGroupId: splitGroupId ?? this.splitGroupId,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (principalPaise.present) {
      map['principal_paise'] = Variable<int>(principalPaise.value);
    }
    if (outstandingBalancePaise.present) {
      map['outstanding_balance_paise'] =
          Variable<int>(outstandingBalancePaise.value);
    }
    if (initialDate.present) {
      map['initial_date'] = Variable<DateTime>(initialDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (initialTransactionId.present) {
      map['initial_transaction_id'] =
          Variable<String>(initialTransactionId.value);
    }
    if (splitGroupId.present) {
      map['split_group_id'] = Variable<String>(splitGroupId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtsCompanion(')
          ..write('id: $id, ')
          ..write('personId: $personId, ')
          ..write('type: $type, ')
          ..write('principalPaise: $principalPaise, ')
          ..write('outstandingBalancePaise: $outstandingBalancePaise, ')
          ..write('initialDate: $initialDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('status: $status, ')
          ..write('initialTransactionId: $initialTransactionId, ')
          ..write('splitGroupId: $splitGroupId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DebtRepaymentsTable extends DebtRepayments
    with TableInfo<$DebtRepaymentsTable, DebtRepaymentEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtRepaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _debtIdMeta = const VerificationMeta('debtId');
  @override
  late final GeneratedColumn<String> debtId = GeneratedColumn<String>(
      'debt_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES debts (id)'));
  static const VerificationMeta _transactionIdMeta =
      const VerificationMeta('transactionId');
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
      'transaction_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _amountPaiseMeta =
      const VerificationMeta('amountPaise');
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
      'amount_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _repaymentDateMeta =
      const VerificationMeta('repaymentDate');
  @override
  late final GeneratedColumn<DateTime> repaymentDate =
      GeneratedColumn<DateTime>('repayment_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _balanceAfterRepaymentPaiseMeta =
      const VerificationMeta('balanceAfterRepaymentPaise');
  @override
  late final GeneratedColumn<int> balanceAfterRepaymentPaise =
      GeneratedColumn<int>('balance_after_repayment_paise', aliasedName, false,
          type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        debtId,
        transactionId,
        amountPaise,
        repaymentDate,
        balanceAfterRepaymentPaise,
        notes,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debt_repayments';
  @override
  VerificationContext validateIntegrity(Insertable<DebtRepaymentEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('debt_id')) {
      context.handle(_debtIdMeta,
          debtId.isAcceptableOrUnknown(data['debt_id']!, _debtIdMeta));
    } else if (isInserting) {
      context.missing(_debtIdMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
          _transactionIdMeta,
          transactionId.isAcceptableOrUnknown(
              data['transaction_id']!, _transactionIdMeta));
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
          _amountPaiseMeta,
          amountPaise.isAcceptableOrUnknown(
              data['amount_paise']!, _amountPaiseMeta));
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    if (data.containsKey('repayment_date')) {
      context.handle(
          _repaymentDateMeta,
          repaymentDate.isAcceptableOrUnknown(
              data['repayment_date']!, _repaymentDateMeta));
    } else if (isInserting) {
      context.missing(_repaymentDateMeta);
    }
    if (data.containsKey('balance_after_repayment_paise')) {
      context.handle(
          _balanceAfterRepaymentPaiseMeta,
          balanceAfterRepaymentPaise.isAcceptableOrUnknown(
              data['balance_after_repayment_paise']!,
              _balanceAfterRepaymentPaiseMeta));
    } else if (isInserting) {
      context.missing(_balanceAfterRepaymentPaiseMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DebtRepaymentEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DebtRepaymentEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      debtId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}debt_id'])!,
      transactionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}transaction_id']),
      amountPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_paise'])!,
      repaymentDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}repayment_date'])!,
      balanceAfterRepaymentPaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}balance_after_repayment_paise'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DebtRepaymentsTable createAlias(String alias) {
    return $DebtRepaymentsTable(attachedDatabase, alias);
  }
}

class DebtRepaymentEntry extends DataClass
    implements Insertable<DebtRepaymentEntry> {
  final String id;
  final String debtId;
  final String? transactionId;
  final int amountPaise;
  final DateTime repaymentDate;
  final int balanceAfterRepaymentPaise;
  final String? notes;
  final DateTime createdAt;
  const DebtRepaymentEntry(
      {required this.id,
      required this.debtId,
      this.transactionId,
      required this.amountPaise,
      required this.repaymentDate,
      required this.balanceAfterRepaymentPaise,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['debt_id'] = Variable<String>(debtId);
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<String>(transactionId);
    }
    map['amount_paise'] = Variable<int>(amountPaise);
    map['repayment_date'] = Variable<DateTime>(repaymentDate);
    map['balance_after_repayment_paise'] =
        Variable<int>(balanceAfterRepaymentPaise);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DebtRepaymentsCompanion toCompanion(bool nullToAbsent) {
    return DebtRepaymentsCompanion(
      id: Value(id),
      debtId: Value(debtId),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      amountPaise: Value(amountPaise),
      repaymentDate: Value(repaymentDate),
      balanceAfterRepaymentPaise: Value(balanceAfterRepaymentPaise),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory DebtRepaymentEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DebtRepaymentEntry(
      id: serializer.fromJson<String>(json['id']),
      debtId: serializer.fromJson<String>(json['debtId']),
      transactionId: serializer.fromJson<String?>(json['transactionId']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
      repaymentDate: serializer.fromJson<DateTime>(json['repaymentDate']),
      balanceAfterRepaymentPaise:
          serializer.fromJson<int>(json['balanceAfterRepaymentPaise']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'debtId': serializer.toJson<String>(debtId),
      'transactionId': serializer.toJson<String?>(transactionId),
      'amountPaise': serializer.toJson<int>(amountPaise),
      'repaymentDate': serializer.toJson<DateTime>(repaymentDate),
      'balanceAfterRepaymentPaise':
          serializer.toJson<int>(balanceAfterRepaymentPaise),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DebtRepaymentEntry copyWith(
          {String? id,
          String? debtId,
          Value<String?> transactionId = const Value.absent(),
          int? amountPaise,
          DateTime? repaymentDate,
          int? balanceAfterRepaymentPaise,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      DebtRepaymentEntry(
        id: id ?? this.id,
        debtId: debtId ?? this.debtId,
        transactionId:
            transactionId.present ? transactionId.value : this.transactionId,
        amountPaise: amountPaise ?? this.amountPaise,
        repaymentDate: repaymentDate ?? this.repaymentDate,
        balanceAfterRepaymentPaise:
            balanceAfterRepaymentPaise ?? this.balanceAfterRepaymentPaise,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  DebtRepaymentEntry copyWithCompanion(DebtRepaymentsCompanion data) {
    return DebtRepaymentEntry(
      id: data.id.present ? data.id.value : this.id,
      debtId: data.debtId.present ? data.debtId.value : this.debtId,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      amountPaise:
          data.amountPaise.present ? data.amountPaise.value : this.amountPaise,
      repaymentDate: data.repaymentDate.present
          ? data.repaymentDate.value
          : this.repaymentDate,
      balanceAfterRepaymentPaise: data.balanceAfterRepaymentPaise.present
          ? data.balanceAfterRepaymentPaise.value
          : this.balanceAfterRepaymentPaise,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DebtRepaymentEntry(')
          ..write('id: $id, ')
          ..write('debtId: $debtId, ')
          ..write('transactionId: $transactionId, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('repaymentDate: $repaymentDate, ')
          ..write('balanceAfterRepaymentPaise: $balanceAfterRepaymentPaise, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, debtId, transactionId, amountPaise,
      repaymentDate, balanceAfterRepaymentPaise, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DebtRepaymentEntry &&
          other.id == this.id &&
          other.debtId == this.debtId &&
          other.transactionId == this.transactionId &&
          other.amountPaise == this.amountPaise &&
          other.repaymentDate == this.repaymentDate &&
          other.balanceAfterRepaymentPaise == this.balanceAfterRepaymentPaise &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class DebtRepaymentsCompanion extends UpdateCompanion<DebtRepaymentEntry> {
  final Value<String> id;
  final Value<String> debtId;
  final Value<String?> transactionId;
  final Value<int> amountPaise;
  final Value<DateTime> repaymentDate;
  final Value<int> balanceAfterRepaymentPaise;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DebtRepaymentsCompanion({
    this.id = const Value.absent(),
    this.debtId = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.repaymentDate = const Value.absent(),
    this.balanceAfterRepaymentPaise = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DebtRepaymentsCompanion.insert({
    required String id,
    required String debtId,
    this.transactionId = const Value.absent(),
    required int amountPaise,
    required DateTime repaymentDate,
    required int balanceAfterRepaymentPaise,
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        debtId = Value(debtId),
        amountPaise = Value(amountPaise),
        repaymentDate = Value(repaymentDate),
        balanceAfterRepaymentPaise = Value(balanceAfterRepaymentPaise),
        createdAt = Value(createdAt);
  static Insertable<DebtRepaymentEntry> custom({
    Expression<String>? id,
    Expression<String>? debtId,
    Expression<String>? transactionId,
    Expression<int>? amountPaise,
    Expression<DateTime>? repaymentDate,
    Expression<int>? balanceAfterRepaymentPaise,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (debtId != null) 'debt_id': debtId,
      if (transactionId != null) 'transaction_id': transactionId,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (repaymentDate != null) 'repayment_date': repaymentDate,
      if (balanceAfterRepaymentPaise != null)
        'balance_after_repayment_paise': balanceAfterRepaymentPaise,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DebtRepaymentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? debtId,
      Value<String?>? transactionId,
      Value<int>? amountPaise,
      Value<DateTime>? repaymentDate,
      Value<int>? balanceAfterRepaymentPaise,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return DebtRepaymentsCompanion(
      id: id ?? this.id,
      debtId: debtId ?? this.debtId,
      transactionId: transactionId ?? this.transactionId,
      amountPaise: amountPaise ?? this.amountPaise,
      repaymentDate: repaymentDate ?? this.repaymentDate,
      balanceAfterRepaymentPaise:
          balanceAfterRepaymentPaise ?? this.balanceAfterRepaymentPaise,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (debtId.present) {
      map['debt_id'] = Variable<String>(debtId.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (repaymentDate.present) {
      map['repayment_date'] = Variable<DateTime>(repaymentDate.value);
    }
    if (balanceAfterRepaymentPaise.present) {
      map['balance_after_repayment_paise'] =
          Variable<int>(balanceAfterRepaymentPaise.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtRepaymentsCompanion(')
          ..write('id: $id, ')
          ..write('debtId: $debtId, ')
          ..write('transactionId: $transactionId, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('repaymentDate: $repaymentDate, ')
          ..write('balanceAfterRepaymentPaise: $balanceAfterRepaymentPaise, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SplitTransactionsTable extends SplitTransactions
    with TableInfo<$SplitTransactionsTable, SplitTransactionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SplitTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalBillPaiseMeta =
      const VerificationMeta('totalBillPaise');
  @override
  late final GeneratedColumn<int> totalBillPaise = GeneratedColumn<int>(
      'total_bill_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'));
  static const VerificationMeta _paidFromAccountIdMeta =
      const VerificationMeta('paidFromAccountId');
  @override
  late final GeneratedColumn<String> paidFromAccountId =
      GeneratedColumn<String>('paid_from_account_id', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints:
              GeneratedColumn.constraintIsAlways('REFERENCES accounts (id)'));
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
      'card_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cards (id)'));
  static const VerificationMeta _mySharePaiseMeta =
      const VerificationMeta('mySharePaise');
  @override
  late final GeneratedColumn<int> mySharePaise = GeneratedColumn<int>(
      'my_share_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _transactionTimestampMeta =
      const VerificationMeta('transactionTimestamp');
  @override
  late final GeneratedColumn<DateTime> transactionTimestamp =
      GeneratedColumn<DateTime>('transaction_timestamp', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        totalBillPaise,
        description,
        categoryId,
        paidFromAccountId,
        cardId,
        mySharePaise,
        transactionTimestamp,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'split_transactions';
  @override
  VerificationContext validateIntegrity(
      Insertable<SplitTransactionEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('total_bill_paise')) {
      context.handle(
          _totalBillPaiseMeta,
          totalBillPaise.isAcceptableOrUnknown(
              data['total_bill_paise']!, _totalBillPaiseMeta));
    } else if (isInserting) {
      context.missing(_totalBillPaiseMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('paid_from_account_id')) {
      context.handle(
          _paidFromAccountIdMeta,
          paidFromAccountId.isAcceptableOrUnknown(
              data['paid_from_account_id']!, _paidFromAccountIdMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    }
    if (data.containsKey('my_share_paise')) {
      context.handle(
          _mySharePaiseMeta,
          mySharePaise.isAcceptableOrUnknown(
              data['my_share_paise']!, _mySharePaiseMeta));
    } else if (isInserting) {
      context.missing(_mySharePaiseMeta);
    }
    if (data.containsKey('transaction_timestamp')) {
      context.handle(
          _transactionTimestampMeta,
          transactionTimestamp.isAcceptableOrUnknown(
              data['transaction_timestamp']!, _transactionTimestampMeta));
    } else if (isInserting) {
      context.missing(_transactionTimestampMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SplitTransactionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SplitTransactionEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      totalBillPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_bill_paise'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id']),
      paidFromAccountId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}paid_from_account_id']),
      cardId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_id']),
      mySharePaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}my_share_paise'])!,
      transactionTimestamp: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}transaction_timestamp'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SplitTransactionsTable createAlias(String alias) {
    return $SplitTransactionsTable(attachedDatabase, alias);
  }
}

class SplitTransactionEntry extends DataClass
    implements Insertable<SplitTransactionEntry> {
  final String id;
  final int totalBillPaise;
  final String description;
  final String? categoryId;
  final String? paidFromAccountId;
  final String? cardId;
  final int mySharePaise;
  final DateTime transactionTimestamp;
  final DateTime createdAt;
  const SplitTransactionEntry(
      {required this.id,
      required this.totalBillPaise,
      required this.description,
      this.categoryId,
      this.paidFromAccountId,
      this.cardId,
      required this.mySharePaise,
      required this.transactionTimestamp,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['total_bill_paise'] = Variable<int>(totalBillPaise);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || paidFromAccountId != null) {
      map['paid_from_account_id'] = Variable<String>(paidFromAccountId);
    }
    if (!nullToAbsent || cardId != null) {
      map['card_id'] = Variable<String>(cardId);
    }
    map['my_share_paise'] = Variable<int>(mySharePaise);
    map['transaction_timestamp'] = Variable<DateTime>(transactionTimestamp);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SplitTransactionsCompanion toCompanion(bool nullToAbsent) {
    return SplitTransactionsCompanion(
      id: Value(id),
      totalBillPaise: Value(totalBillPaise),
      description: Value(description),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      paidFromAccountId: paidFromAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(paidFromAccountId),
      cardId:
          cardId == null && nullToAbsent ? const Value.absent() : Value(cardId),
      mySharePaise: Value(mySharePaise),
      transactionTimestamp: Value(transactionTimestamp),
      createdAt: Value(createdAt),
    );
  }

  factory SplitTransactionEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SplitTransactionEntry(
      id: serializer.fromJson<String>(json['id']),
      totalBillPaise: serializer.fromJson<int>(json['totalBillPaise']),
      description: serializer.fromJson<String>(json['description']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      paidFromAccountId:
          serializer.fromJson<String?>(json['paidFromAccountId']),
      cardId: serializer.fromJson<String?>(json['cardId']),
      mySharePaise: serializer.fromJson<int>(json['mySharePaise']),
      transactionTimestamp:
          serializer.fromJson<DateTime>(json['transactionTimestamp']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'totalBillPaise': serializer.toJson<int>(totalBillPaise),
      'description': serializer.toJson<String>(description),
      'categoryId': serializer.toJson<String?>(categoryId),
      'paidFromAccountId': serializer.toJson<String?>(paidFromAccountId),
      'cardId': serializer.toJson<String?>(cardId),
      'mySharePaise': serializer.toJson<int>(mySharePaise),
      'transactionTimestamp': serializer.toJson<DateTime>(transactionTimestamp),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SplitTransactionEntry copyWith(
          {String? id,
          int? totalBillPaise,
          String? description,
          Value<String?> categoryId = const Value.absent(),
          Value<String?> paidFromAccountId = const Value.absent(),
          Value<String?> cardId = const Value.absent(),
          int? mySharePaise,
          DateTime? transactionTimestamp,
          DateTime? createdAt}) =>
      SplitTransactionEntry(
        id: id ?? this.id,
        totalBillPaise: totalBillPaise ?? this.totalBillPaise,
        description: description ?? this.description,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        paidFromAccountId: paidFromAccountId.present
            ? paidFromAccountId.value
            : this.paidFromAccountId,
        cardId: cardId.present ? cardId.value : this.cardId,
        mySharePaise: mySharePaise ?? this.mySharePaise,
        transactionTimestamp: transactionTimestamp ?? this.transactionTimestamp,
        createdAt: createdAt ?? this.createdAt,
      );
  SplitTransactionEntry copyWithCompanion(SplitTransactionsCompanion data) {
    return SplitTransactionEntry(
      id: data.id.present ? data.id.value : this.id,
      totalBillPaise: data.totalBillPaise.present
          ? data.totalBillPaise.value
          : this.totalBillPaise,
      description:
          data.description.present ? data.description.value : this.description,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      paidFromAccountId: data.paidFromAccountId.present
          ? data.paidFromAccountId.value
          : this.paidFromAccountId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      mySharePaise: data.mySharePaise.present
          ? data.mySharePaise.value
          : this.mySharePaise,
      transactionTimestamp: data.transactionTimestamp.present
          ? data.transactionTimestamp.value
          : this.transactionTimestamp,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SplitTransactionEntry(')
          ..write('id: $id, ')
          ..write('totalBillPaise: $totalBillPaise, ')
          ..write('description: $description, ')
          ..write('categoryId: $categoryId, ')
          ..write('paidFromAccountId: $paidFromAccountId, ')
          ..write('cardId: $cardId, ')
          ..write('mySharePaise: $mySharePaise, ')
          ..write('transactionTimestamp: $transactionTimestamp, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, totalBillPaise, description, categoryId,
      paidFromAccountId, cardId, mySharePaise, transactionTimestamp, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SplitTransactionEntry &&
          other.id == this.id &&
          other.totalBillPaise == this.totalBillPaise &&
          other.description == this.description &&
          other.categoryId == this.categoryId &&
          other.paidFromAccountId == this.paidFromAccountId &&
          other.cardId == this.cardId &&
          other.mySharePaise == this.mySharePaise &&
          other.transactionTimestamp == this.transactionTimestamp &&
          other.createdAt == this.createdAt);
}

class SplitTransactionsCompanion
    extends UpdateCompanion<SplitTransactionEntry> {
  final Value<String> id;
  final Value<int> totalBillPaise;
  final Value<String> description;
  final Value<String?> categoryId;
  final Value<String?> paidFromAccountId;
  final Value<String?> cardId;
  final Value<int> mySharePaise;
  final Value<DateTime> transactionTimestamp;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SplitTransactionsCompanion({
    this.id = const Value.absent(),
    this.totalBillPaise = const Value.absent(),
    this.description = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.paidFromAccountId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.mySharePaise = const Value.absent(),
    this.transactionTimestamp = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SplitTransactionsCompanion.insert({
    required String id,
    required int totalBillPaise,
    required String description,
    this.categoryId = const Value.absent(),
    this.paidFromAccountId = const Value.absent(),
    this.cardId = const Value.absent(),
    required int mySharePaise,
    required DateTime transactionTimestamp,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        totalBillPaise = Value(totalBillPaise),
        description = Value(description),
        mySharePaise = Value(mySharePaise),
        transactionTimestamp = Value(transactionTimestamp),
        createdAt = Value(createdAt);
  static Insertable<SplitTransactionEntry> custom({
    Expression<String>? id,
    Expression<int>? totalBillPaise,
    Expression<String>? description,
    Expression<String>? categoryId,
    Expression<String>? paidFromAccountId,
    Expression<String>? cardId,
    Expression<int>? mySharePaise,
    Expression<DateTime>? transactionTimestamp,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (totalBillPaise != null) 'total_bill_paise': totalBillPaise,
      if (description != null) 'description': description,
      if (categoryId != null) 'category_id': categoryId,
      if (paidFromAccountId != null) 'paid_from_account_id': paidFromAccountId,
      if (cardId != null) 'card_id': cardId,
      if (mySharePaise != null) 'my_share_paise': mySharePaise,
      if (transactionTimestamp != null)
        'transaction_timestamp': transactionTimestamp,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SplitTransactionsCompanion copyWith(
      {Value<String>? id,
      Value<int>? totalBillPaise,
      Value<String>? description,
      Value<String?>? categoryId,
      Value<String?>? paidFromAccountId,
      Value<String?>? cardId,
      Value<int>? mySharePaise,
      Value<DateTime>? transactionTimestamp,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SplitTransactionsCompanion(
      id: id ?? this.id,
      totalBillPaise: totalBillPaise ?? this.totalBillPaise,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      paidFromAccountId: paidFromAccountId ?? this.paidFromAccountId,
      cardId: cardId ?? this.cardId,
      mySharePaise: mySharePaise ?? this.mySharePaise,
      transactionTimestamp: transactionTimestamp ?? this.transactionTimestamp,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (totalBillPaise.present) {
      map['total_bill_paise'] = Variable<int>(totalBillPaise.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (paidFromAccountId.present) {
      map['paid_from_account_id'] = Variable<String>(paidFromAccountId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (mySharePaise.present) {
      map['my_share_paise'] = Variable<int>(mySharePaise.value);
    }
    if (transactionTimestamp.present) {
      map['transaction_timestamp'] =
          Variable<DateTime>(transactionTimestamp.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SplitTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('totalBillPaise: $totalBillPaise, ')
          ..write('description: $description, ')
          ..write('categoryId: $categoryId, ')
          ..write('paidFromAccountId: $paidFromAccountId, ')
          ..write('cardId: $cardId, ')
          ..write('mySharePaise: $mySharePaise, ')
          ..write('transactionTimestamp: $transactionTimestamp, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountPaiseMeta =
      const VerificationMeta('amountPaise');
  @override
  late final GeneratedColumn<int> amountPaise = GeneratedColumn<int>(
      'amount_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _fromAccountIdMeta =
      const VerificationMeta('fromAccountId');
  @override
  late final GeneratedColumn<String> fromAccountId = GeneratedColumn<String>(
      'from_account_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES accounts (id)'));
  static const VerificationMeta _toAccountIdMeta =
      const VerificationMeta('toAccountId');
  @override
  late final GeneratedColumn<String> toAccountId = GeneratedColumn<String>(
      'to_account_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES accounts (id)'));
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
      'card_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES cards (id)'));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES categories (id)'));
  static const VerificationMeta _personIdMeta =
      const VerificationMeta('personId');
  @override
  late final GeneratedColumn<String> personId = GeneratedColumn<String>(
      'person_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES persons (id)'));
  static const VerificationMeta _splitGroupIdMeta =
      const VerificationMeta('splitGroupId');
  @override
  late final GeneratedColumn<String> splitGroupId = GeneratedColumn<String>(
      'split_group_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _totalBillPaiseMeta =
      const VerificationMeta('totalBillPaise');
  @override
  late final GeneratedColumn<int> totalBillPaise = GeneratedColumn<int>(
      'total_bill_paise', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _transactionTimestampMeta =
      const VerificationMeta('transactionTimestamp');
  @override
  late final GeneratedColumn<DateTime> transactionTimestamp =
      GeneratedColumn<DateTime>('transaction_timestamp', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isExcludedFromBudgetMeta =
      const VerificationMeta('isExcludedFromBudget');
  @override
  late final GeneratedColumn<bool> isExcludedFromBudget = GeneratedColumn<bool>(
      'is_excluded_from_budget', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_excluded_from_budget" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isClearedMeta =
      const VerificationMeta('isCleared');
  @override
  late final GeneratedColumn<bool> isCleared = GeneratedColumn<bool>(
      'is_cleared', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_cleared" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        type,
        amountPaise,
        fromAccountId,
        toAccountId,
        cardId,
        categoryId,
        personId,
        splitGroupId,
        totalBillPaise,
        transactionTimestamp,
        note,
        isExcludedFromBudget,
        isCleared,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<TransactionEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount_paise')) {
      context.handle(
          _amountPaiseMeta,
          amountPaise.isAcceptableOrUnknown(
              data['amount_paise']!, _amountPaiseMeta));
    } else if (isInserting) {
      context.missing(_amountPaiseMeta);
    }
    if (data.containsKey('from_account_id')) {
      context.handle(
          _fromAccountIdMeta,
          fromAccountId.isAcceptableOrUnknown(
              data['from_account_id']!, _fromAccountIdMeta));
    }
    if (data.containsKey('to_account_id')) {
      context.handle(
          _toAccountIdMeta,
          toAccountId.isAcceptableOrUnknown(
              data['to_account_id']!, _toAccountIdMeta));
    }
    if (data.containsKey('card_id')) {
      context.handle(_cardIdMeta,
          cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('person_id')) {
      context.handle(_personIdMeta,
          personId.isAcceptableOrUnknown(data['person_id']!, _personIdMeta));
    }
    if (data.containsKey('split_group_id')) {
      context.handle(
          _splitGroupIdMeta,
          splitGroupId.isAcceptableOrUnknown(
              data['split_group_id']!, _splitGroupIdMeta));
    }
    if (data.containsKey('total_bill_paise')) {
      context.handle(
          _totalBillPaiseMeta,
          totalBillPaise.isAcceptableOrUnknown(
              data['total_bill_paise']!, _totalBillPaiseMeta));
    }
    if (data.containsKey('transaction_timestamp')) {
      context.handle(
          _transactionTimestampMeta,
          transactionTimestamp.isAcceptableOrUnknown(
              data['transaction_timestamp']!, _transactionTimestampMeta));
    } else if (isInserting) {
      context.missing(_transactionTimestampMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('is_excluded_from_budget')) {
      context.handle(
          _isExcludedFromBudgetMeta,
          isExcludedFromBudget.isAcceptableOrUnknown(
              data['is_excluded_from_budget']!, _isExcludedFromBudgetMeta));
    }
    if (data.containsKey('is_cleared')) {
      context.handle(_isClearedMeta,
          isCleared.isAcceptableOrUnknown(data['is_cleared']!, _isClearedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      amountPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_paise'])!,
      fromAccountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}from_account_id']),
      toAccountId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}to_account_id']),
      cardId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_id']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id']),
      personId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person_id']),
      splitGroupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}split_group_id']),
      totalBillPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_bill_paise']),
      transactionTimestamp: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}transaction_timestamp'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      isExcludedFromBudget: attachedDatabase.typeMapping.read(DriftSqlType.bool,
          data['${effectivePrefix}is_excluded_from_budget'])!,
      isCleared: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_cleared'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class TransactionEntry extends DataClass
    implements Insertable<TransactionEntry> {
  final String id;
  final String type;
  final int amountPaise;
  final String? fromAccountId;
  final String? toAccountId;
  final String? cardId;
  final String? categoryId;
  final String? personId;
  final String? splitGroupId;
  final int? totalBillPaise;
  final DateTime transactionTimestamp;
  final String? note;
  final bool isExcludedFromBudget;
  final bool isCleared;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TransactionEntry(
      {required this.id,
      required this.type,
      required this.amountPaise,
      this.fromAccountId,
      this.toAccountId,
      this.cardId,
      this.categoryId,
      this.personId,
      this.splitGroupId,
      this.totalBillPaise,
      required this.transactionTimestamp,
      this.note,
      required this.isExcludedFromBudget,
      required this.isCleared,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['amount_paise'] = Variable<int>(amountPaise);
    if (!nullToAbsent || fromAccountId != null) {
      map['from_account_id'] = Variable<String>(fromAccountId);
    }
    if (!nullToAbsent || toAccountId != null) {
      map['to_account_id'] = Variable<String>(toAccountId);
    }
    if (!nullToAbsent || cardId != null) {
      map['card_id'] = Variable<String>(cardId);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || personId != null) {
      map['person_id'] = Variable<String>(personId);
    }
    if (!nullToAbsent || splitGroupId != null) {
      map['split_group_id'] = Variable<String>(splitGroupId);
    }
    if (!nullToAbsent || totalBillPaise != null) {
      map['total_bill_paise'] = Variable<int>(totalBillPaise);
    }
    map['transaction_timestamp'] = Variable<DateTime>(transactionTimestamp);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_excluded_from_budget'] = Variable<bool>(isExcludedFromBudget);
    map['is_cleared'] = Variable<bool>(isCleared);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      type: Value(type),
      amountPaise: Value(amountPaise),
      fromAccountId: fromAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(fromAccountId),
      toAccountId: toAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(toAccountId),
      cardId:
          cardId == null && nullToAbsent ? const Value.absent() : Value(cardId),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      personId: personId == null && nullToAbsent
          ? const Value.absent()
          : Value(personId),
      splitGroupId: splitGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(splitGroupId),
      totalBillPaise: totalBillPaise == null && nullToAbsent
          ? const Value.absent()
          : Value(totalBillPaise),
      transactionTimestamp: Value(transactionTimestamp),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isExcludedFromBudget: Value(isExcludedFromBudget),
      isCleared: Value(isCleared),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TransactionEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionEntry(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      amountPaise: serializer.fromJson<int>(json['amountPaise']),
      fromAccountId: serializer.fromJson<String?>(json['fromAccountId']),
      toAccountId: serializer.fromJson<String?>(json['toAccountId']),
      cardId: serializer.fromJson<String?>(json['cardId']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      personId: serializer.fromJson<String?>(json['personId']),
      splitGroupId: serializer.fromJson<String?>(json['splitGroupId']),
      totalBillPaise: serializer.fromJson<int?>(json['totalBillPaise']),
      transactionTimestamp:
          serializer.fromJson<DateTime>(json['transactionTimestamp']),
      note: serializer.fromJson<String?>(json['note']),
      isExcludedFromBudget:
          serializer.fromJson<bool>(json['isExcludedFromBudget']),
      isCleared: serializer.fromJson<bool>(json['isCleared']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'amountPaise': serializer.toJson<int>(amountPaise),
      'fromAccountId': serializer.toJson<String?>(fromAccountId),
      'toAccountId': serializer.toJson<String?>(toAccountId),
      'cardId': serializer.toJson<String?>(cardId),
      'categoryId': serializer.toJson<String?>(categoryId),
      'personId': serializer.toJson<String?>(personId),
      'splitGroupId': serializer.toJson<String?>(splitGroupId),
      'totalBillPaise': serializer.toJson<int?>(totalBillPaise),
      'transactionTimestamp': serializer.toJson<DateTime>(transactionTimestamp),
      'note': serializer.toJson<String?>(note),
      'isExcludedFromBudget': serializer.toJson<bool>(isExcludedFromBudget),
      'isCleared': serializer.toJson<bool>(isCleared),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TransactionEntry copyWith(
          {String? id,
          String? type,
          int? amountPaise,
          Value<String?> fromAccountId = const Value.absent(),
          Value<String?> toAccountId = const Value.absent(),
          Value<String?> cardId = const Value.absent(),
          Value<String?> categoryId = const Value.absent(),
          Value<String?> personId = const Value.absent(),
          Value<String?> splitGroupId = const Value.absent(),
          Value<int?> totalBillPaise = const Value.absent(),
          DateTime? transactionTimestamp,
          Value<String?> note = const Value.absent(),
          bool? isExcludedFromBudget,
          bool? isCleared,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      TransactionEntry(
        id: id ?? this.id,
        type: type ?? this.type,
        amountPaise: amountPaise ?? this.amountPaise,
        fromAccountId:
            fromAccountId.present ? fromAccountId.value : this.fromAccountId,
        toAccountId: toAccountId.present ? toAccountId.value : this.toAccountId,
        cardId: cardId.present ? cardId.value : this.cardId,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        personId: personId.present ? personId.value : this.personId,
        splitGroupId:
            splitGroupId.present ? splitGroupId.value : this.splitGroupId,
        totalBillPaise:
            totalBillPaise.present ? totalBillPaise.value : this.totalBillPaise,
        transactionTimestamp: transactionTimestamp ?? this.transactionTimestamp,
        note: note.present ? note.value : this.note,
        isExcludedFromBudget: isExcludedFromBudget ?? this.isExcludedFromBudget,
        isCleared: isCleared ?? this.isCleared,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  TransactionEntry copyWithCompanion(TransactionsCompanion data) {
    return TransactionEntry(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      amountPaise:
          data.amountPaise.present ? data.amountPaise.value : this.amountPaise,
      fromAccountId: data.fromAccountId.present
          ? data.fromAccountId.value
          : this.fromAccountId,
      toAccountId:
          data.toAccountId.present ? data.toAccountId.value : this.toAccountId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      personId: data.personId.present ? data.personId.value : this.personId,
      splitGroupId: data.splitGroupId.present
          ? data.splitGroupId.value
          : this.splitGroupId,
      totalBillPaise: data.totalBillPaise.present
          ? data.totalBillPaise.value
          : this.totalBillPaise,
      transactionTimestamp: data.transactionTimestamp.present
          ? data.transactionTimestamp.value
          : this.transactionTimestamp,
      note: data.note.present ? data.note.value : this.note,
      isExcludedFromBudget: data.isExcludedFromBudget.present
          ? data.isExcludedFromBudget.value
          : this.isExcludedFromBudget,
      isCleared: data.isCleared.present ? data.isCleared.value : this.isCleared,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionEntry(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('fromAccountId: $fromAccountId, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('cardId: $cardId, ')
          ..write('categoryId: $categoryId, ')
          ..write('personId: $personId, ')
          ..write('splitGroupId: $splitGroupId, ')
          ..write('totalBillPaise: $totalBillPaise, ')
          ..write('transactionTimestamp: $transactionTimestamp, ')
          ..write('note: $note, ')
          ..write('isExcludedFromBudget: $isExcludedFromBudget, ')
          ..write('isCleared: $isCleared, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      type,
      amountPaise,
      fromAccountId,
      toAccountId,
      cardId,
      categoryId,
      personId,
      splitGroupId,
      totalBillPaise,
      transactionTimestamp,
      note,
      isExcludedFromBudget,
      isCleared,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionEntry &&
          other.id == this.id &&
          other.type == this.type &&
          other.amountPaise == this.amountPaise &&
          other.fromAccountId == this.fromAccountId &&
          other.toAccountId == this.toAccountId &&
          other.cardId == this.cardId &&
          other.categoryId == this.categoryId &&
          other.personId == this.personId &&
          other.splitGroupId == this.splitGroupId &&
          other.totalBillPaise == this.totalBillPaise &&
          other.transactionTimestamp == this.transactionTimestamp &&
          other.note == this.note &&
          other.isExcludedFromBudget == this.isExcludedFromBudget &&
          other.isCleared == this.isCleared &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TransactionsCompanion extends UpdateCompanion<TransactionEntry> {
  final Value<String> id;
  final Value<String> type;
  final Value<int> amountPaise;
  final Value<String?> fromAccountId;
  final Value<String?> toAccountId;
  final Value<String?> cardId;
  final Value<String?> categoryId;
  final Value<String?> personId;
  final Value<String?> splitGroupId;
  final Value<int?> totalBillPaise;
  final Value<DateTime> transactionTimestamp;
  final Value<String?> note;
  final Value<bool> isExcludedFromBudget;
  final Value<bool> isCleared;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.amountPaise = const Value.absent(),
    this.fromAccountId = const Value.absent(),
    this.toAccountId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.personId = const Value.absent(),
    this.splitGroupId = const Value.absent(),
    this.totalBillPaise = const Value.absent(),
    this.transactionTimestamp = const Value.absent(),
    this.note = const Value.absent(),
    this.isExcludedFromBudget = const Value.absent(),
    this.isCleared = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required String type,
    required int amountPaise,
    this.fromAccountId = const Value.absent(),
    this.toAccountId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.personId = const Value.absent(),
    this.splitGroupId = const Value.absent(),
    this.totalBillPaise = const Value.absent(),
    required DateTime transactionTimestamp,
    this.note = const Value.absent(),
    this.isExcludedFromBudget = const Value.absent(),
    this.isCleared = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        amountPaise = Value(amountPaise),
        transactionTimestamp = Value(transactionTimestamp),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TransactionEntry> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<int>? amountPaise,
    Expression<String>? fromAccountId,
    Expression<String>? toAccountId,
    Expression<String>? cardId,
    Expression<String>? categoryId,
    Expression<String>? personId,
    Expression<String>? splitGroupId,
    Expression<int>? totalBillPaise,
    Expression<DateTime>? transactionTimestamp,
    Expression<String>? note,
    Expression<bool>? isExcludedFromBudget,
    Expression<bool>? isCleared,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (amountPaise != null) 'amount_paise': amountPaise,
      if (fromAccountId != null) 'from_account_id': fromAccountId,
      if (toAccountId != null) 'to_account_id': toAccountId,
      if (cardId != null) 'card_id': cardId,
      if (categoryId != null) 'category_id': categoryId,
      if (personId != null) 'person_id': personId,
      if (splitGroupId != null) 'split_group_id': splitGroupId,
      if (totalBillPaise != null) 'total_bill_paise': totalBillPaise,
      if (transactionTimestamp != null)
        'transaction_timestamp': transactionTimestamp,
      if (note != null) 'note': note,
      if (isExcludedFromBudget != null)
        'is_excluded_from_budget': isExcludedFromBudget,
      if (isCleared != null) 'is_cleared': isCleared,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? type,
      Value<int>? amountPaise,
      Value<String?>? fromAccountId,
      Value<String?>? toAccountId,
      Value<String?>? cardId,
      Value<String?>? categoryId,
      Value<String?>? personId,
      Value<String?>? splitGroupId,
      Value<int?>? totalBillPaise,
      Value<DateTime>? transactionTimestamp,
      Value<String?>? note,
      Value<bool>? isExcludedFromBudget,
      Value<bool>? isCleared,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      amountPaise: amountPaise ?? this.amountPaise,
      fromAccountId: fromAccountId ?? this.fromAccountId,
      toAccountId: toAccountId ?? this.toAccountId,
      cardId: cardId ?? this.cardId,
      categoryId: categoryId ?? this.categoryId,
      personId: personId ?? this.personId,
      splitGroupId: splitGroupId ?? this.splitGroupId,
      totalBillPaise: totalBillPaise ?? this.totalBillPaise,
      transactionTimestamp: transactionTimestamp ?? this.transactionTimestamp,
      note: note ?? this.note,
      isExcludedFromBudget: isExcludedFromBudget ?? this.isExcludedFromBudget,
      isCleared: isCleared ?? this.isCleared,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amountPaise.present) {
      map['amount_paise'] = Variable<int>(amountPaise.value);
    }
    if (fromAccountId.present) {
      map['from_account_id'] = Variable<String>(fromAccountId.value);
    }
    if (toAccountId.present) {
      map['to_account_id'] = Variable<String>(toAccountId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (personId.present) {
      map['person_id'] = Variable<String>(personId.value);
    }
    if (splitGroupId.present) {
      map['split_group_id'] = Variable<String>(splitGroupId.value);
    }
    if (totalBillPaise.present) {
      map['total_bill_paise'] = Variable<int>(totalBillPaise.value);
    }
    if (transactionTimestamp.present) {
      map['transaction_timestamp'] =
          Variable<DateTime>(transactionTimestamp.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isExcludedFromBudget.present) {
      map['is_excluded_from_budget'] =
          Variable<bool>(isExcludedFromBudget.value);
    }
    if (isCleared.present) {
      map['is_cleared'] = Variable<bool>(isCleared.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amountPaise: $amountPaise, ')
          ..write('fromAccountId: $fromAccountId, ')
          ..write('toAccountId: $toAccountId, ')
          ..write('cardId: $cardId, ')
          ..write('categoryId: $categoryId, ')
          ..write('personId: $personId, ')
          ..write('splitGroupId: $splitGroupId, ')
          ..write('totalBillPaise: $totalBillPaise, ')
          ..write('transactionTimestamp: $transactionTimestamp, ')
          ..write('note: $note, ')
          ..write('isExcludedFromBudget: $isExcludedFromBudget, ')
          ..write('isCleared: $isCleared, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyBudgetConfigTableTable extends DailyBudgetConfigTable
    with TableInfo<$DailyBudgetConfigTableTable, DailyBudgetConfigEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyBudgetConfigTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dailyAllocationPaiseMeta =
      const VerificationMeta('dailyAllocationPaise');
  @override
  late final GeneratedColumn<int> dailyAllocationPaise = GeneratedColumn<int>(
      'daily_allocation_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _enableCarryForwardMeta =
      const VerificationMeta('enableCarryForward');
  @override
  late final GeneratedColumn<bool> enableCarryForward = GeneratedColumn<bool>(
      'enable_carry_forward', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enable_carry_forward" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, dailyAllocationPaise, enableCarryForward, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_budget_config_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<DailyBudgetConfigEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('daily_allocation_paise')) {
      context.handle(
          _dailyAllocationPaiseMeta,
          dailyAllocationPaise.isAcceptableOrUnknown(
              data['daily_allocation_paise']!, _dailyAllocationPaiseMeta));
    } else if (isInserting) {
      context.missing(_dailyAllocationPaiseMeta);
    }
    if (data.containsKey('enable_carry_forward')) {
      context.handle(
          _enableCarryForwardMeta,
          enableCarryForward.isAcceptableOrUnknown(
              data['enable_carry_forward']!, _enableCarryForwardMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyBudgetConfigEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyBudgetConfigEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      dailyAllocationPaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}daily_allocation_paise'])!,
      enableCarryForward: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}enable_carry_forward'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DailyBudgetConfigTableTable createAlias(String alias) {
    return $DailyBudgetConfigTableTable(attachedDatabase, alias);
  }
}

class DailyBudgetConfigEntry extends DataClass
    implements Insertable<DailyBudgetConfigEntry> {
  final String id;
  final int dailyAllocationPaise;
  final bool enableCarryForward;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DailyBudgetConfigEntry(
      {required this.id,
      required this.dailyAllocationPaise,
      required this.enableCarryForward,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['daily_allocation_paise'] = Variable<int>(dailyAllocationPaise);
    map['enable_carry_forward'] = Variable<bool>(enableCarryForward);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyBudgetConfigTableCompanion toCompanion(bool nullToAbsent) {
    return DailyBudgetConfigTableCompanion(
      id: Value(id),
      dailyAllocationPaise: Value(dailyAllocationPaise),
      enableCarryForward: Value(enableCarryForward),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyBudgetConfigEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyBudgetConfigEntry(
      id: serializer.fromJson<String>(json['id']),
      dailyAllocationPaise:
          serializer.fromJson<int>(json['dailyAllocationPaise']),
      enableCarryForward: serializer.fromJson<bool>(json['enableCarryForward']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dailyAllocationPaise': serializer.toJson<int>(dailyAllocationPaise),
      'enableCarryForward': serializer.toJson<bool>(enableCarryForward),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyBudgetConfigEntry copyWith(
          {String? id,
          int? dailyAllocationPaise,
          bool? enableCarryForward,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      DailyBudgetConfigEntry(
        id: id ?? this.id,
        dailyAllocationPaise: dailyAllocationPaise ?? this.dailyAllocationPaise,
        enableCarryForward: enableCarryForward ?? this.enableCarryForward,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DailyBudgetConfigEntry copyWithCompanion(
      DailyBudgetConfigTableCompanion data) {
    return DailyBudgetConfigEntry(
      id: data.id.present ? data.id.value : this.id,
      dailyAllocationPaise: data.dailyAllocationPaise.present
          ? data.dailyAllocationPaise.value
          : this.dailyAllocationPaise,
      enableCarryForward: data.enableCarryForward.present
          ? data.enableCarryForward.value
          : this.enableCarryForward,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyBudgetConfigEntry(')
          ..write('id: $id, ')
          ..write('dailyAllocationPaise: $dailyAllocationPaise, ')
          ..write('enableCarryForward: $enableCarryForward, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, dailyAllocationPaise, enableCarryForward, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyBudgetConfigEntry &&
          other.id == this.id &&
          other.dailyAllocationPaise == this.dailyAllocationPaise &&
          other.enableCarryForward == this.enableCarryForward &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DailyBudgetConfigTableCompanion
    extends UpdateCompanion<DailyBudgetConfigEntry> {
  final Value<String> id;
  final Value<int> dailyAllocationPaise;
  final Value<bool> enableCarryForward;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DailyBudgetConfigTableCompanion({
    this.id = const Value.absent(),
    this.dailyAllocationPaise = const Value.absent(),
    this.enableCarryForward = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyBudgetConfigTableCompanion.insert({
    required String id,
    required int dailyAllocationPaise,
    this.enableCarryForward = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        dailyAllocationPaise = Value(dailyAllocationPaise),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<DailyBudgetConfigEntry> custom({
    Expression<String>? id,
    Expression<int>? dailyAllocationPaise,
    Expression<bool>? enableCarryForward,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dailyAllocationPaise != null)
        'daily_allocation_paise': dailyAllocationPaise,
      if (enableCarryForward != null)
        'enable_carry_forward': enableCarryForward,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyBudgetConfigTableCompanion copyWith(
      {Value<String>? id,
      Value<int>? dailyAllocationPaise,
      Value<bool>? enableCarryForward,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return DailyBudgetConfigTableCompanion(
      id: id ?? this.id,
      dailyAllocationPaise: dailyAllocationPaise ?? this.dailyAllocationPaise,
      enableCarryForward: enableCarryForward ?? this.enableCarryForward,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dailyAllocationPaise.present) {
      map['daily_allocation_paise'] = Variable<int>(dailyAllocationPaise.value);
    }
    if (enableCarryForward.present) {
      map['enable_carry_forward'] = Variable<bool>(enableCarryForward.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyBudgetConfigTableCompanion(')
          ..write('id: $id, ')
          ..write('dailyAllocationPaise: $dailyAllocationPaise, ')
          ..write('enableCarryForward: $enableCarryForward, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyBudgetSnapshotsTable extends DailyBudgetSnapshots
    with TableInfo<$DailyBudgetSnapshotsTable, DailyBudgetSnapshotEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyBudgetSnapshotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateEpochDayMeta =
      const VerificationMeta('dateEpochDay');
  @override
  late final GeneratedColumn<int> dateEpochDay = GeneratedColumn<int>(
      'date_epoch_day', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _allocatedPaiseMeta =
      const VerificationMeta('allocatedPaise');
  @override
  late final GeneratedColumn<int> allocatedPaise = GeneratedColumn<int>(
      'allocated_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _spentPaiseMeta =
      const VerificationMeta('spentPaise');
  @override
  late final GeneratedColumn<int> spentPaise = GeneratedColumn<int>(
      'spent_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _carriedForwardPaiseMeta =
      const VerificationMeta('carriedForwardPaise');
  @override
  late final GeneratedColumn<int> carriedForwardPaise = GeneratedColumn<int>(
      'carried_forward_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _netAvailablePaiseMeta =
      const VerificationMeta('netAvailablePaise');
  @override
  late final GeneratedColumn<int> netAvailablePaise = GeneratedColumn<int>(
      'net_available_paise', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        dateEpochDay,
        allocatedPaise,
        spentPaise,
        carriedForwardPaise,
        netAvailablePaise,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_budget_snapshots';
  @override
  VerificationContext validateIntegrity(
      Insertable<DailyBudgetSnapshotEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date_epoch_day')) {
      context.handle(
          _dateEpochDayMeta,
          dateEpochDay.isAcceptableOrUnknown(
              data['date_epoch_day']!, _dateEpochDayMeta));
    }
    if (data.containsKey('allocated_paise')) {
      context.handle(
          _allocatedPaiseMeta,
          allocatedPaise.isAcceptableOrUnknown(
              data['allocated_paise']!, _allocatedPaiseMeta));
    } else if (isInserting) {
      context.missing(_allocatedPaiseMeta);
    }
    if (data.containsKey('spent_paise')) {
      context.handle(
          _spentPaiseMeta,
          spentPaise.isAcceptableOrUnknown(
              data['spent_paise']!, _spentPaiseMeta));
    } else if (isInserting) {
      context.missing(_spentPaiseMeta);
    }
    if (data.containsKey('carried_forward_paise')) {
      context.handle(
          _carriedForwardPaiseMeta,
          carriedForwardPaise.isAcceptableOrUnknown(
              data['carried_forward_paise']!, _carriedForwardPaiseMeta));
    } else if (isInserting) {
      context.missing(_carriedForwardPaiseMeta);
    }
    if (data.containsKey('net_available_paise')) {
      context.handle(
          _netAvailablePaiseMeta,
          netAvailablePaise.isAcceptableOrUnknown(
              data['net_available_paise']!, _netAvailablePaiseMeta));
    } else if (isInserting) {
      context.missing(_netAvailablePaiseMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dateEpochDay};
  @override
  DailyBudgetSnapshotEntry map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyBudgetSnapshotEntry(
      dateEpochDay: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date_epoch_day'])!,
      allocatedPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}allocated_paise'])!,
      spentPaise: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}spent_paise'])!,
      carriedForwardPaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}carried_forward_paise'])!,
      netAvailablePaise: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}net_available_paise'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DailyBudgetSnapshotsTable createAlias(String alias) {
    return $DailyBudgetSnapshotsTable(attachedDatabase, alias);
  }
}

class DailyBudgetSnapshotEntry extends DataClass
    implements Insertable<DailyBudgetSnapshotEntry> {
  final int dateEpochDay;
  final int allocatedPaise;
  final int spentPaise;
  final int carriedForwardPaise;
  final int netAvailablePaise;
  final DateTime updatedAt;
  const DailyBudgetSnapshotEntry(
      {required this.dateEpochDay,
      required this.allocatedPaise,
      required this.spentPaise,
      required this.carriedForwardPaise,
      required this.netAvailablePaise,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date_epoch_day'] = Variable<int>(dateEpochDay);
    map['allocated_paise'] = Variable<int>(allocatedPaise);
    map['spent_paise'] = Variable<int>(spentPaise);
    map['carried_forward_paise'] = Variable<int>(carriedForwardPaise);
    map['net_available_paise'] = Variable<int>(netAvailablePaise);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyBudgetSnapshotsCompanion toCompanion(bool nullToAbsent) {
    return DailyBudgetSnapshotsCompanion(
      dateEpochDay: Value(dateEpochDay),
      allocatedPaise: Value(allocatedPaise),
      spentPaise: Value(spentPaise),
      carriedForwardPaise: Value(carriedForwardPaise),
      netAvailablePaise: Value(netAvailablePaise),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyBudgetSnapshotEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyBudgetSnapshotEntry(
      dateEpochDay: serializer.fromJson<int>(json['dateEpochDay']),
      allocatedPaise: serializer.fromJson<int>(json['allocatedPaise']),
      spentPaise: serializer.fromJson<int>(json['spentPaise']),
      carriedForwardPaise:
          serializer.fromJson<int>(json['carriedForwardPaise']),
      netAvailablePaise: serializer.fromJson<int>(json['netAvailablePaise']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dateEpochDay': serializer.toJson<int>(dateEpochDay),
      'allocatedPaise': serializer.toJson<int>(allocatedPaise),
      'spentPaise': serializer.toJson<int>(spentPaise),
      'carriedForwardPaise': serializer.toJson<int>(carriedForwardPaise),
      'netAvailablePaise': serializer.toJson<int>(netAvailablePaise),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyBudgetSnapshotEntry copyWith(
          {int? dateEpochDay,
          int? allocatedPaise,
          int? spentPaise,
          int? carriedForwardPaise,
          int? netAvailablePaise,
          DateTime? updatedAt}) =>
      DailyBudgetSnapshotEntry(
        dateEpochDay: dateEpochDay ?? this.dateEpochDay,
        allocatedPaise: allocatedPaise ?? this.allocatedPaise,
        spentPaise: spentPaise ?? this.spentPaise,
        carriedForwardPaise: carriedForwardPaise ?? this.carriedForwardPaise,
        netAvailablePaise: netAvailablePaise ?? this.netAvailablePaise,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  DailyBudgetSnapshotEntry copyWithCompanion(
      DailyBudgetSnapshotsCompanion data) {
    return DailyBudgetSnapshotEntry(
      dateEpochDay: data.dateEpochDay.present
          ? data.dateEpochDay.value
          : this.dateEpochDay,
      allocatedPaise: data.allocatedPaise.present
          ? data.allocatedPaise.value
          : this.allocatedPaise,
      spentPaise:
          data.spentPaise.present ? data.spentPaise.value : this.spentPaise,
      carriedForwardPaise: data.carriedForwardPaise.present
          ? data.carriedForwardPaise.value
          : this.carriedForwardPaise,
      netAvailablePaise: data.netAvailablePaise.present
          ? data.netAvailablePaise.value
          : this.netAvailablePaise,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyBudgetSnapshotEntry(')
          ..write('dateEpochDay: $dateEpochDay, ')
          ..write('allocatedPaise: $allocatedPaise, ')
          ..write('spentPaise: $spentPaise, ')
          ..write('carriedForwardPaise: $carriedForwardPaise, ')
          ..write('netAvailablePaise: $netAvailablePaise, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(dateEpochDay, allocatedPaise, spentPaise,
      carriedForwardPaise, netAvailablePaise, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyBudgetSnapshotEntry &&
          other.dateEpochDay == this.dateEpochDay &&
          other.allocatedPaise == this.allocatedPaise &&
          other.spentPaise == this.spentPaise &&
          other.carriedForwardPaise == this.carriedForwardPaise &&
          other.netAvailablePaise == this.netAvailablePaise &&
          other.updatedAt == this.updatedAt);
}

class DailyBudgetSnapshotsCompanion
    extends UpdateCompanion<DailyBudgetSnapshotEntry> {
  final Value<int> dateEpochDay;
  final Value<int> allocatedPaise;
  final Value<int> spentPaise;
  final Value<int> carriedForwardPaise;
  final Value<int> netAvailablePaise;
  final Value<DateTime> updatedAt;
  const DailyBudgetSnapshotsCompanion({
    this.dateEpochDay = const Value.absent(),
    this.allocatedPaise = const Value.absent(),
    this.spentPaise = const Value.absent(),
    this.carriedForwardPaise = const Value.absent(),
    this.netAvailablePaise = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DailyBudgetSnapshotsCompanion.insert({
    this.dateEpochDay = const Value.absent(),
    required int allocatedPaise,
    required int spentPaise,
    required int carriedForwardPaise,
    required int netAvailablePaise,
    required DateTime updatedAt,
  })  : allocatedPaise = Value(allocatedPaise),
        spentPaise = Value(spentPaise),
        carriedForwardPaise = Value(carriedForwardPaise),
        netAvailablePaise = Value(netAvailablePaise),
        updatedAt = Value(updatedAt);
  static Insertable<DailyBudgetSnapshotEntry> custom({
    Expression<int>? dateEpochDay,
    Expression<int>? allocatedPaise,
    Expression<int>? spentPaise,
    Expression<int>? carriedForwardPaise,
    Expression<int>? netAvailablePaise,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (dateEpochDay != null) 'date_epoch_day': dateEpochDay,
      if (allocatedPaise != null) 'allocated_paise': allocatedPaise,
      if (spentPaise != null) 'spent_paise': spentPaise,
      if (carriedForwardPaise != null)
        'carried_forward_paise': carriedForwardPaise,
      if (netAvailablePaise != null) 'net_available_paise': netAvailablePaise,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DailyBudgetSnapshotsCompanion copyWith(
      {Value<int>? dateEpochDay,
      Value<int>? allocatedPaise,
      Value<int>? spentPaise,
      Value<int>? carriedForwardPaise,
      Value<int>? netAvailablePaise,
      Value<DateTime>? updatedAt}) {
    return DailyBudgetSnapshotsCompanion(
      dateEpochDay: dateEpochDay ?? this.dateEpochDay,
      allocatedPaise: allocatedPaise ?? this.allocatedPaise,
      spentPaise: spentPaise ?? this.spentPaise,
      carriedForwardPaise: carriedForwardPaise ?? this.carriedForwardPaise,
      netAvailablePaise: netAvailablePaise ?? this.netAvailablePaise,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dateEpochDay.present) {
      map['date_epoch_day'] = Variable<int>(dateEpochDay.value);
    }
    if (allocatedPaise.present) {
      map['allocated_paise'] = Variable<int>(allocatedPaise.value);
    }
    if (spentPaise.present) {
      map['spent_paise'] = Variable<int>(spentPaise.value);
    }
    if (carriedForwardPaise.present) {
      map['carried_forward_paise'] = Variable<int>(carriedForwardPaise.value);
    }
    if (netAvailablePaise.present) {
      map['net_available_paise'] = Variable<int>(netAvailablePaise.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyBudgetSnapshotsCompanion(')
          ..write('dateEpochDay: $dateEpochDay, ')
          ..write('allocatedPaise: $allocatedPaise, ')
          ..write('spentPaise: $spentPaise, ')
          ..write('carriedForwardPaise: $carriedForwardPaise, ')
          ..write('netAvailablePaise: $netAvailablePaise, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AccountsTable accounts = $AccountsTable(this);
  late final $CardsTable cards = $CardsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $PersonsTable persons = $PersonsTable(this);
  late final $DebtsTable debts = $DebtsTable(this);
  late final $DebtRepaymentsTable debtRepayments = $DebtRepaymentsTable(this);
  late final $SplitTransactionsTable splitTransactions =
      $SplitTransactionsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $DailyBudgetConfigTableTable dailyBudgetConfigTable =
      $DailyBudgetConfigTableTable(this);
  late final $DailyBudgetSnapshotsTable dailyBudgetSnapshots =
      $DailyBudgetSnapshotsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        accounts,
        cards,
        categories,
        persons,
        debts,
        debtRepayments,
        splitTransactions,
        transactions,
        dailyBudgetConfigTable,
        dailyBudgetSnapshots
      ];
}

typedef $$AccountsTableCreateCompanionBuilder = AccountsCompanion Function({
  required String id,
  required String name,
  required String type,
  Value<int> openingBalancePaise,
  Value<int> currentBalancePaise,
  Value<String> currencyCode,
  Value<String?> icon,
  Value<String?> colorHex,
  Value<bool> isArchived,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$AccountsTableUpdateCompanionBuilder = AccountsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> type,
  Value<int> openingBalancePaise,
  Value<int> currentBalancePaise,
  Value<String> currencyCode,
  Value<String?> icon,
  Value<String?> colorHex,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$AccountsTableReferences
    extends BaseReferences<_$AppDatabase, $AccountsTable, AccountEntry> {
  $$AccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CardsTable, List<CardEntry>> _cardsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.cards,
          aliasName: $_aliasNameGenerator(db.accounts.id, db.cards.accountId));

  $$CardsTableProcessedTableManager get cardsRefs {
    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SplitTransactionsTable,
      List<SplitTransactionEntry>> _splitTransactionsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.splitTransactions,
          aliasName: $_aliasNameGenerator(
              db.accounts.id, db.splitTransactions.paidFromAccountId));

  $$SplitTransactionsTableProcessedTableManager get splitTransactionsRefs {
    final manager =
        $$SplitTransactionsTableTableManager($_db, $_db.splitTransactions)
            .filter((f) =>
                f.paidFromAccountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_splitTransactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AccountsTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get openingBalancePaise => $composableBuilder(
      column: $table.openingBalancePaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentBalancePaise => $composableBuilder(
      column: $table.currentBalancePaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> cardsRefs(
      Expression<bool> Function($$CardsTableFilterComposer f) f) {
    final $$CardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.accountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableFilterComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> splitTransactionsRefs(
      Expression<bool> Function($$SplitTransactionsTableFilterComposer f) f) {
    final $$SplitTransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.splitTransactions,
        getReferencedColumn: (t) => t.paidFromAccountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SplitTransactionsTableFilterComposer(
              $db: $db,
              $table: $db.splitTransactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$AccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get openingBalancePaise => $composableBuilder(
      column: $table.openingBalancePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentBalancePaise => $composableBuilder(
      column: $table.currentBalancePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTable> {
  $$AccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get openingBalancePaise => $composableBuilder(
      column: $table.openingBalancePaise, builder: (column) => column);

  GeneratedColumn<int> get currentBalancePaise => $composableBuilder(
      column: $table.currentBalancePaise, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> cardsRefs<T extends Object>(
      Expression<T> Function($$CardsTableAnnotationComposer a) f) {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.accountId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableAnnotationComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> splitTransactionsRefs<T extends Object>(
      Expression<T> Function($$SplitTransactionsTableAnnotationComposer a) f) {
    final $$SplitTransactionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.splitTransactions,
            getReferencedColumn: (t) => t.paidFromAccountId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SplitTransactionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.splitTransactions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$AccountsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AccountsTable,
    AccountEntry,
    $$AccountsTableFilterComposer,
    $$AccountsTableOrderingComposer,
    $$AccountsTableAnnotationComposer,
    $$AccountsTableCreateCompanionBuilder,
    $$AccountsTableUpdateCompanionBuilder,
    (AccountEntry, $$AccountsTableReferences),
    AccountEntry,
    PrefetchHooks Function({bool cardsRefs, bool splitTransactionsRefs})> {
  $$AccountsTableTableManager(_$AppDatabase db, $AccountsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> openingBalancePaise = const Value.absent(),
            Value<int> currentBalancePaise = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<String?> colorHex = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AccountsCompanion(
            id: id,
            name: name,
            type: type,
            openingBalancePaise: openingBalancePaise,
            currentBalancePaise: currentBalancePaise,
            currencyCode: currencyCode,
            icon: icon,
            colorHex: colorHex,
            isArchived: isArchived,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String type,
            Value<int> openingBalancePaise = const Value.absent(),
            Value<int> currentBalancePaise = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<String?> colorHex = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AccountsCompanion.insert(
            id: id,
            name: name,
            type: type,
            openingBalancePaise: openingBalancePaise,
            currentBalancePaise: currentBalancePaise,
            currencyCode: currencyCode,
            icon: icon,
            colorHex: colorHex,
            isArchived: isArchived,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$AccountsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {cardsRefs = false, splitTransactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (cardsRefs) db.cards,
                if (splitTransactionsRefs) db.splitTransactions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cardsRefs)
                    await $_getPrefetchedData<AccountEntry, $AccountsTable,
                            CardEntry>(
                        currentTable: table,
                        referencedTable:
                            $$AccountsTableReferences._cardsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountsTableReferences(db, table, p0).cardsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.accountId == item.id),
                        typedResults: items),
                  if (splitTransactionsRefs)
                    await $_getPrefetchedData<AccountEntry, $AccountsTable,
                            SplitTransactionEntry>(
                        currentTable: table,
                        referencedTable: $$AccountsTableReferences
                            ._splitTransactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AccountsTableReferences(db, table, p0)
                                .splitTransactionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.paidFromAccountId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AccountsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AccountsTable,
    AccountEntry,
    $$AccountsTableFilterComposer,
    $$AccountsTableOrderingComposer,
    $$AccountsTableAnnotationComposer,
    $$AccountsTableCreateCompanionBuilder,
    $$AccountsTableUpdateCompanionBuilder,
    (AccountEntry, $$AccountsTableReferences),
    AccountEntry,
    PrefetchHooks Function({bool cardsRefs, bool splitTransactionsRefs})>;
typedef $$CardsTableCreateCompanionBuilder = CardsCompanion Function({
  required String id,
  Value<String?> accountId,
  required String cardName,
  required String cardType,
  required String issuerBank,
  required String last4Digits,
  Value<String?> cardholderName,
  Value<int?> billingCycleDay,
  Value<int?> paymentDueDay,
  Value<int?> creditLimitPaise,
  Value<int> currentOutstandingPaise,
  Value<String> skinType,
  Value<String?> skinAssetOrPath,
  Value<bool> isArchived,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CardsTableUpdateCompanionBuilder = CardsCompanion Function({
  Value<String> id,
  Value<String?> accountId,
  Value<String> cardName,
  Value<String> cardType,
  Value<String> issuerBank,
  Value<String> last4Digits,
  Value<String?> cardholderName,
  Value<int?> billingCycleDay,
  Value<int?> paymentDueDay,
  Value<int?> creditLimitPaise,
  Value<int> currentOutstandingPaise,
  Value<String> skinType,
  Value<String?> skinAssetOrPath,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$CardsTableReferences
    extends BaseReferences<_$AppDatabase, $CardsTable, CardEntry> {
  $$CardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _accountIdTable(_$AppDatabase db) => db.accounts
      .createAlias($_aliasNameGenerator(db.cards.accountId, db.accounts.id));

  $$AccountsTableProcessedTableManager? get accountId {
    final $_column = $_itemColumn<String>('account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SplitTransactionsTable,
      List<SplitTransactionEntry>> _splitTransactionsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.splitTransactions,
          aliasName:
              $_aliasNameGenerator(db.cards.id, db.splitTransactions.cardId));

  $$SplitTransactionsTableProcessedTableManager get splitTransactionsRefs {
    final manager =
        $$SplitTransactionsTableTableManager($_db, $_db.splitTransactions)
            .filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_splitTransactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionsTable, List<TransactionEntry>>
      _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.transactions,
          aliasName: $_aliasNameGenerator(db.cards.id, db.transactions.cardId));

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CardsTableFilterComposer extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardName => $composableBuilder(
      column: $table.cardName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardType => $composableBuilder(
      column: $table.cardType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get issuerBank => $composableBuilder(
      column: $table.issuerBank, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get last4Digits => $composableBuilder(
      column: $table.last4Digits, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardholderName => $composableBuilder(
      column: $table.cardholderName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get billingCycleDay => $composableBuilder(
      column: $table.billingCycleDay,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paymentDueDay => $composableBuilder(
      column: $table.paymentDueDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get creditLimitPaise => $composableBuilder(
      column: $table.creditLimitPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentOutstandingPaise => $composableBuilder(
      column: $table.currentOutstandingPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get skinType => $composableBuilder(
      column: $table.skinType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get skinAssetOrPath => $composableBuilder(
      column: $table.skinAssetOrPath,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get accountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> splitTransactionsRefs(
      Expression<bool> Function($$SplitTransactionsTableFilterComposer f) f) {
    final $$SplitTransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.splitTransactions,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SplitTransactionsTableFilterComposer(
              $db: $db,
              $table: $db.splitTransactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transactionsRefs(
      Expression<bool> Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CardsTableOrderingComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardName => $composableBuilder(
      column: $table.cardName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardType => $composableBuilder(
      column: $table.cardType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get issuerBank => $composableBuilder(
      column: $table.issuerBank, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get last4Digits => $composableBuilder(
      column: $table.last4Digits, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardholderName => $composableBuilder(
      column: $table.cardholderName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get billingCycleDay => $composableBuilder(
      column: $table.billingCycleDay,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paymentDueDay => $composableBuilder(
      column: $table.paymentDueDay,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get creditLimitPaise => $composableBuilder(
      column: $table.creditLimitPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentOutstandingPaise => $composableBuilder(
      column: $table.currentOutstandingPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get skinType => $composableBuilder(
      column: $table.skinType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get skinAssetOrPath => $composableBuilder(
      column: $table.skinAssetOrPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get accountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cardName =>
      $composableBuilder(column: $table.cardName, builder: (column) => column);

  GeneratedColumn<String> get cardType =>
      $composableBuilder(column: $table.cardType, builder: (column) => column);

  GeneratedColumn<String> get issuerBank => $composableBuilder(
      column: $table.issuerBank, builder: (column) => column);

  GeneratedColumn<String> get last4Digits => $composableBuilder(
      column: $table.last4Digits, builder: (column) => column);

  GeneratedColumn<String> get cardholderName => $composableBuilder(
      column: $table.cardholderName, builder: (column) => column);

  GeneratedColumn<int> get billingCycleDay => $composableBuilder(
      column: $table.billingCycleDay, builder: (column) => column);

  GeneratedColumn<int> get paymentDueDay => $composableBuilder(
      column: $table.paymentDueDay, builder: (column) => column);

  GeneratedColumn<int> get creditLimitPaise => $composableBuilder(
      column: $table.creditLimitPaise, builder: (column) => column);

  GeneratedColumn<int> get currentOutstandingPaise => $composableBuilder(
      column: $table.currentOutstandingPaise, builder: (column) => column);

  GeneratedColumn<String> get skinType =>
      $composableBuilder(column: $table.skinType, builder: (column) => column);

  GeneratedColumn<String> get skinAssetOrPath => $composableBuilder(
      column: $table.skinAssetOrPath, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AccountsTableAnnotationComposer get accountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.accountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> splitTransactionsRefs<T extends Object>(
      Expression<T> Function($$SplitTransactionsTableAnnotationComposer a) f) {
    final $$SplitTransactionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.splitTransactions,
            getReferencedColumn: (t) => t.cardId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SplitTransactionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.splitTransactions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> transactionsRefs<T extends Object>(
      Expression<T> Function($$TransactionsTableAnnotationComposer a) f) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.cardId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CardsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CardsTable,
    CardEntry,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (CardEntry, $$CardsTableReferences),
    CardEntry,
    PrefetchHooks Function(
        {bool accountId, bool splitTransactionsRefs, bool transactionsRefs})> {
  $$CardsTableTableManager(_$AppDatabase db, $CardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> accountId = const Value.absent(),
            Value<String> cardName = const Value.absent(),
            Value<String> cardType = const Value.absent(),
            Value<String> issuerBank = const Value.absent(),
            Value<String> last4Digits = const Value.absent(),
            Value<String?> cardholderName = const Value.absent(),
            Value<int?> billingCycleDay = const Value.absent(),
            Value<int?> paymentDueDay = const Value.absent(),
            Value<int?> creditLimitPaise = const Value.absent(),
            Value<int> currentOutstandingPaise = const Value.absent(),
            Value<String> skinType = const Value.absent(),
            Value<String?> skinAssetOrPath = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CardsCompanion(
            id: id,
            accountId: accountId,
            cardName: cardName,
            cardType: cardType,
            issuerBank: issuerBank,
            last4Digits: last4Digits,
            cardholderName: cardholderName,
            billingCycleDay: billingCycleDay,
            paymentDueDay: paymentDueDay,
            creditLimitPaise: creditLimitPaise,
            currentOutstandingPaise: currentOutstandingPaise,
            skinType: skinType,
            skinAssetOrPath: skinAssetOrPath,
            isArchived: isArchived,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> accountId = const Value.absent(),
            required String cardName,
            required String cardType,
            required String issuerBank,
            required String last4Digits,
            Value<String?> cardholderName = const Value.absent(),
            Value<int?> billingCycleDay = const Value.absent(),
            Value<int?> paymentDueDay = const Value.absent(),
            Value<int?> creditLimitPaise = const Value.absent(),
            Value<int> currentOutstandingPaise = const Value.absent(),
            Value<String> skinType = const Value.absent(),
            Value<String?> skinAssetOrPath = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CardsCompanion.insert(
            id: id,
            accountId: accountId,
            cardName: cardName,
            cardType: cardType,
            issuerBank: issuerBank,
            last4Digits: last4Digits,
            cardholderName: cardholderName,
            billingCycleDay: billingCycleDay,
            paymentDueDay: paymentDueDay,
            creditLimitPaise: creditLimitPaise,
            currentOutstandingPaise: currentOutstandingPaise,
            skinType: skinType,
            skinAssetOrPath: skinAssetOrPath,
            isArchived: isArchived,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$CardsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {accountId = false,
              splitTransactionsRefs = false,
              transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (splitTransactionsRefs) db.splitTransactions,
                if (transactionsRefs) db.transactions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (accountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.accountId,
                    referencedTable: $$CardsTableReferences._accountIdTable(db),
                    referencedColumn:
                        $$CardsTableReferences._accountIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (splitTransactionsRefs)
                    await $_getPrefetchedData<CardEntry, $CardsTable,
                            SplitTransactionEntry>(
                        currentTable: table,
                        referencedTable: $$CardsTableReferences
                            ._splitTransactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CardsTableReferences(db, table, p0)
                                .splitTransactionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.cardId == item.id),
                        typedResults: items),
                  if (transactionsRefs)
                    await $_getPrefetchedData<CardEntry, $CardsTable,
                            TransactionEntry>(
                        currentTable: table,
                        referencedTable:
                            $$CardsTableReferences._transactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CardsTableReferences(db, table, p0)
                                .transactionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.cardId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CardsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CardsTable,
    CardEntry,
    $$CardsTableFilterComposer,
    $$CardsTableOrderingComposer,
    $$CardsTableAnnotationComposer,
    $$CardsTableCreateCompanionBuilder,
    $$CardsTableUpdateCompanionBuilder,
    (CardEntry, $$CardsTableReferences),
    CardEntry,
    PrefetchHooks Function(
        {bool accountId, bool splitTransactionsRefs, bool transactionsRefs})>;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  required String name,
  required String type,
  required String icon,
  required String colorHex,
  Value<String?> parentId,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> type,
  Value<String> icon,
  Value<String> colorHex,
  Value<String?> parentId,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, CategoryEntry> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _parentIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
          $_aliasNameGenerator(db.categories.parentId, db.categories.id));

  $$CategoriesTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<String>('parent_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SplitTransactionsTable,
      List<SplitTransactionEntry>> _splitTransactionsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.splitTransactions,
          aliasName: $_aliasNameGenerator(
              db.categories.id, db.splitTransactions.categoryId));

  $$SplitTransactionsTableProcessedTableManager get splitTransactionsRefs {
    final manager = $$SplitTransactionsTableTableManager(
            $_db, $_db.splitTransactions)
        .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_splitTransactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionsTable, List<TransactionEntry>>
      _transactionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactions,
              aliasName: $_aliasNameGenerator(
                  db.categories.id, db.transactions.categoryId));

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  $$CategoriesTableFilterComposer get parentId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> splitTransactionsRefs(
      Expression<bool> Function($$SplitTransactionsTableFilterComposer f) f) {
    final $$SplitTransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.splitTransactions,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SplitTransactionsTableFilterComposer(
              $db: $db,
              $table: $db.splitTransactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transactionsRefs(
      Expression<bool> Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorHex => $composableBuilder(
      column: $table.colorHex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  $$CategoriesTableOrderingComposer get parentId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get parentId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> splitTransactionsRefs<T extends Object>(
      Expression<T> Function($$SplitTransactionsTableAnnotationComposer a) f) {
    final $$SplitTransactionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.splitTransactions,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SplitTransactionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.splitTransactions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> transactionsRefs<T extends Object>(
      Expression<T> Function($$TransactionsTableAnnotationComposer a) f) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    CategoryEntry,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (CategoryEntry, $$CategoriesTableReferences),
    CategoryEntry,
    PrefetchHooks Function(
        {bool parentId, bool splitTransactionsRefs, bool transactionsRefs})> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> colorHex = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion(
            id: id,
            name: name,
            type: type,
            icon: icon,
            colorHex: colorHex,
            parentId: parentId,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String type,
            required String icon,
            required String colorHex,
            Value<String?> parentId = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            id: id,
            name: name,
            type: type,
            icon: icon,
            colorHex: colorHex,
            parentId: parentId,
            sortOrder: sortOrder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {parentId = false,
              splitTransactionsRefs = false,
              transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (splitTransactionsRefs) db.splitTransactions,
                if (transactionsRefs) db.transactions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (parentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parentId,
                    referencedTable:
                        $$CategoriesTableReferences._parentIdTable(db),
                    referencedColumn:
                        $$CategoriesTableReferences._parentIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (splitTransactionsRefs)
                    await $_getPrefetchedData<CategoryEntry, $CategoriesTable,
                            SplitTransactionEntry>(
                        currentTable: table,
                        referencedTable: $$CategoriesTableReferences
                            ._splitTransactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriesTableReferences(db, table, p0)
                                .splitTransactionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items),
                  if (transactionsRefs)
                    await $_getPrefetchedData<CategoryEntry, $CategoriesTable,
                            TransactionEntry>(
                        currentTable: table,
                        referencedTable: $$CategoriesTableReferences
                            ._transactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriesTableReferences(db, table, p0)
                                .transactionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTable,
    CategoryEntry,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (CategoryEntry, $$CategoriesTableReferences),
    CategoryEntry,
    PrefetchHooks Function(
        {bool parentId, bool splitTransactionsRefs, bool transactionsRefs})>;
typedef $$PersonsTableCreateCompanionBuilder = PersonsCompanion Function({
  required String id,
  required String name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> notes,
  Value<int> outstandingBalancePaise,
  Value<String> avatarColor,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$PersonsTableUpdateCompanionBuilder = PersonsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> notes,
  Value<int> outstandingBalancePaise,
  Value<String> avatarColor,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$PersonsTableReferences
    extends BaseReferences<_$AppDatabase, $PersonsTable, PersonEntry> {
  $$PersonsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DebtsTable, List<DebtEntry>> _debtsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.debts,
          aliasName: $_aliasNameGenerator(db.persons.id, db.debts.personId));

  $$DebtsTableProcessedTableManager get debtsRefs {
    final manager = $$DebtsTableTableManager($_db, $_db.debts)
        .filter((f) => f.personId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_debtsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionsTable, List<TransactionEntry>>
      _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.transactions,
          aliasName:
              $_aliasNameGenerator(db.persons.id, db.transactions.personId));

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter((f) => f.personId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PersonsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get outstandingBalancePaise => $composableBuilder(
      column: $table.outstandingBalancePaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarColor => $composableBuilder(
      column: $table.avatarColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> debtsRefs(
      Expression<bool> Function($$DebtsTableFilterComposer f) f) {
    final $$DebtsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.debts,
        getReferencedColumn: (t) => t.personId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtsTableFilterComposer(
              $db: $db,
              $table: $db.debts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> transactionsRefs(
      Expression<bool> Function($$TransactionsTableFilterComposer f) f) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.personId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableFilterComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PersonsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get outstandingBalancePaise => $composableBuilder(
      column: $table.outstandingBalancePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarColor => $composableBuilder(
      column: $table.avatarColor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PersonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get outstandingBalancePaise => $composableBuilder(
      column: $table.outstandingBalancePaise, builder: (column) => column);

  GeneratedColumn<String> get avatarColor => $composableBuilder(
      column: $table.avatarColor, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> debtsRefs<T extends Object>(
      Expression<T> Function($$DebtsTableAnnotationComposer a) f) {
    final $$DebtsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.debts,
        getReferencedColumn: (t) => t.personId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtsTableAnnotationComposer(
              $db: $db,
              $table: $db.debts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> transactionsRefs<T extends Object>(
      Expression<T> Function($$TransactionsTableAnnotationComposer a) f) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactions,
        getReferencedColumn: (t) => t.personId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.transactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PersonsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PersonsTable,
    PersonEntry,
    $$PersonsTableFilterComposer,
    $$PersonsTableOrderingComposer,
    $$PersonsTableAnnotationComposer,
    $$PersonsTableCreateCompanionBuilder,
    $$PersonsTableUpdateCompanionBuilder,
    (PersonEntry, $$PersonsTableReferences),
    PersonEntry,
    PrefetchHooks Function({bool debtsRefs, bool transactionsRefs})> {
  $$PersonsTableTableManager(_$AppDatabase db, $PersonsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> outstandingBalancePaise = const Value.absent(),
            Value<String> avatarColor = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PersonsCompanion(
            id: id,
            name: name,
            phone: phone,
            email: email,
            notes: notes,
            outstandingBalancePaise: outstandingBalancePaise,
            avatarColor: avatarColor,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> phone = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> outstandingBalancePaise = const Value.absent(),
            Value<String> avatarColor = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PersonsCompanion.insert(
            id: id,
            name: name,
            phone: phone,
            email: email,
            notes: notes,
            outstandingBalancePaise: outstandingBalancePaise,
            avatarColor: avatarColor,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PersonsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {debtsRefs = false, transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (debtsRefs) db.debts,
                if (transactionsRefs) db.transactions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (debtsRefs)
                    await $_getPrefetchedData<PersonEntry, $PersonsTable,
                            DebtEntry>(
                        currentTable: table,
                        referencedTable:
                            $$PersonsTableReferences._debtsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PersonsTableReferences(db, table, p0).debtsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.personId == item.id),
                        typedResults: items),
                  if (transactionsRefs)
                    await $_getPrefetchedData<PersonEntry, $PersonsTable,
                            TransactionEntry>(
                        currentTable: table,
                        referencedTable:
                            $$PersonsTableReferences._transactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PersonsTableReferences(db, table, p0)
                                .transactionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.personId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PersonsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PersonsTable,
    PersonEntry,
    $$PersonsTableFilterComposer,
    $$PersonsTableOrderingComposer,
    $$PersonsTableAnnotationComposer,
    $$PersonsTableCreateCompanionBuilder,
    $$PersonsTableUpdateCompanionBuilder,
    (PersonEntry, $$PersonsTableReferences),
    PersonEntry,
    PrefetchHooks Function({bool debtsRefs, bool transactionsRefs})>;
typedef $$DebtsTableCreateCompanionBuilder = DebtsCompanion Function({
  required String id,
  required String personId,
  required String type,
  required int principalPaise,
  required int outstandingBalancePaise,
  required DateTime initialDate,
  Value<DateTime?> dueDate,
  Value<String> status,
  Value<String?> initialTransactionId,
  Value<String?> splitGroupId,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$DebtsTableUpdateCompanionBuilder = DebtsCompanion Function({
  Value<String> id,
  Value<String> personId,
  Value<String> type,
  Value<int> principalPaise,
  Value<int> outstandingBalancePaise,
  Value<DateTime> initialDate,
  Value<DateTime?> dueDate,
  Value<String> status,
  Value<String?> initialTransactionId,
  Value<String?> splitGroupId,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$DebtsTableReferences
    extends BaseReferences<_$AppDatabase, $DebtsTable, DebtEntry> {
  $$DebtsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PersonsTable _personIdTable(_$AppDatabase db) => db.persons
      .createAlias($_aliasNameGenerator(db.debts.personId, db.persons.id));

  $$PersonsTableProcessedTableManager get personId {
    final $_column = $_itemColumn<String>('person_id')!;

    final manager = $$PersonsTableTableManager($_db, $_db.persons)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$DebtRepaymentsTable, List<DebtRepaymentEntry>>
      _debtRepaymentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.debtRepayments,
              aliasName:
                  $_aliasNameGenerator(db.debts.id, db.debtRepayments.debtId));

  $$DebtRepaymentsTableProcessedTableManager get debtRepaymentsRefs {
    final manager = $$DebtRepaymentsTableTableManager($_db, $_db.debtRepayments)
        .filter((f) => f.debtId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_debtRepaymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DebtsTableFilterComposer extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get principalPaise => $composableBuilder(
      column: $table.principalPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get outstandingBalancePaise => $composableBuilder(
      column: $table.outstandingBalancePaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get initialDate => $composableBuilder(
      column: $table.initialDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get initialTransactionId => $composableBuilder(
      column: $table.initialTransactionId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get splitGroupId => $composableBuilder(
      column: $table.splitGroupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$PersonsTableFilterComposer get personId {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.personId,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableFilterComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> debtRepaymentsRefs(
      Expression<bool> Function($$DebtRepaymentsTableFilterComposer f) f) {
    final $$DebtRepaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.debtRepayments,
        getReferencedColumn: (t) => t.debtId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtRepaymentsTableFilterComposer(
              $db: $db,
              $table: $db.debtRepayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DebtsTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get principalPaise => $composableBuilder(
      column: $table.principalPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get outstandingBalancePaise => $composableBuilder(
      column: $table.outstandingBalancePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get initialDate => $composableBuilder(
      column: $table.initialDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get initialTransactionId => $composableBuilder(
      column: $table.initialTransactionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get splitGroupId => $composableBuilder(
      column: $table.splitGroupId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$PersonsTableOrderingComposer get personId {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.personId,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableOrderingComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DebtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get principalPaise => $composableBuilder(
      column: $table.principalPaise, builder: (column) => column);

  GeneratedColumn<int> get outstandingBalancePaise => $composableBuilder(
      column: $table.outstandingBalancePaise, builder: (column) => column);

  GeneratedColumn<DateTime> get initialDate => $composableBuilder(
      column: $table.initialDate, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get initialTransactionId => $composableBuilder(
      column: $table.initialTransactionId, builder: (column) => column);

  GeneratedColumn<String> get splitGroupId => $composableBuilder(
      column: $table.splitGroupId, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PersonsTableAnnotationComposer get personId {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.personId,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableAnnotationComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> debtRepaymentsRefs<T extends Object>(
      Expression<T> Function($$DebtRepaymentsTableAnnotationComposer a) f) {
    final $$DebtRepaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.debtRepayments,
        getReferencedColumn: (t) => t.debtId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtRepaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.debtRepayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DebtsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DebtsTable,
    DebtEntry,
    $$DebtsTableFilterComposer,
    $$DebtsTableOrderingComposer,
    $$DebtsTableAnnotationComposer,
    $$DebtsTableCreateCompanionBuilder,
    $$DebtsTableUpdateCompanionBuilder,
    (DebtEntry, $$DebtsTableReferences),
    DebtEntry,
    PrefetchHooks Function({bool personId, bool debtRepaymentsRefs})> {
  $$DebtsTableTableManager(_$AppDatabase db, $DebtsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> personId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> principalPaise = const Value.absent(),
            Value<int> outstandingBalancePaise = const Value.absent(),
            Value<DateTime> initialDate = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> initialTransactionId = const Value.absent(),
            Value<String?> splitGroupId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DebtsCompanion(
            id: id,
            personId: personId,
            type: type,
            principalPaise: principalPaise,
            outstandingBalancePaise: outstandingBalancePaise,
            initialDate: initialDate,
            dueDate: dueDate,
            status: status,
            initialTransactionId: initialTransactionId,
            splitGroupId: splitGroupId,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String personId,
            required String type,
            required int principalPaise,
            required int outstandingBalancePaise,
            required DateTime initialDate,
            Value<DateTime?> dueDate = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> initialTransactionId = const Value.absent(),
            Value<String?> splitGroupId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              DebtsCompanion.insert(
            id: id,
            personId: personId,
            type: type,
            principalPaise: principalPaise,
            outstandingBalancePaise: outstandingBalancePaise,
            initialDate: initialDate,
            dueDate: dueDate,
            status: status,
            initialTransactionId: initialTransactionId,
            splitGroupId: splitGroupId,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$DebtsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {personId = false, debtRepaymentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (debtRepaymentsRefs) db.debtRepayments
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (personId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.personId,
                    referencedTable: $$DebtsTableReferences._personIdTable(db),
                    referencedColumn:
                        $$DebtsTableReferences._personIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (debtRepaymentsRefs)
                    await $_getPrefetchedData<DebtEntry, $DebtsTable,
                            DebtRepaymentEntry>(
                        currentTable: table,
                        referencedTable:
                            $$DebtsTableReferences._debtRepaymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DebtsTableReferences(db, table, p0)
                                .debtRepaymentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.debtId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DebtsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DebtsTable,
    DebtEntry,
    $$DebtsTableFilterComposer,
    $$DebtsTableOrderingComposer,
    $$DebtsTableAnnotationComposer,
    $$DebtsTableCreateCompanionBuilder,
    $$DebtsTableUpdateCompanionBuilder,
    (DebtEntry, $$DebtsTableReferences),
    DebtEntry,
    PrefetchHooks Function({bool personId, bool debtRepaymentsRefs})>;
typedef $$DebtRepaymentsTableCreateCompanionBuilder = DebtRepaymentsCompanion
    Function({
  required String id,
  required String debtId,
  Value<String?> transactionId,
  required int amountPaise,
  required DateTime repaymentDate,
  required int balanceAfterRepaymentPaise,
  Value<String?> notes,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$DebtRepaymentsTableUpdateCompanionBuilder = DebtRepaymentsCompanion
    Function({
  Value<String> id,
  Value<String> debtId,
  Value<String?> transactionId,
  Value<int> amountPaise,
  Value<DateTime> repaymentDate,
  Value<int> balanceAfterRepaymentPaise,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$DebtRepaymentsTableReferences extends BaseReferences<
    _$AppDatabase, $DebtRepaymentsTable, DebtRepaymentEntry> {
  $$DebtRepaymentsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $DebtsTable _debtIdTable(_$AppDatabase db) => db.debts
      .createAlias($_aliasNameGenerator(db.debtRepayments.debtId, db.debts.id));

  $$DebtsTableProcessedTableManager get debtId {
    final $_column = $_itemColumn<String>('debt_id')!;

    final manager = $$DebtsTableTableManager($_db, $_db.debts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_debtIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$DebtRepaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $DebtRepaymentsTable> {
  $$DebtRepaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get transactionId => $composableBuilder(
      column: $table.transactionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get repaymentDate => $composableBuilder(
      column: $table.repaymentDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get balanceAfterRepaymentPaise => $composableBuilder(
      column: $table.balanceAfterRepaymentPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$DebtsTableFilterComposer get debtId {
    final $$DebtsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.debtId,
        referencedTable: $db.debts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtsTableFilterComposer(
              $db: $db,
              $table: $db.debts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DebtRepaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtRepaymentsTable> {
  $$DebtRepaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get transactionId => $composableBuilder(
      column: $table.transactionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get repaymentDate => $composableBuilder(
      column: $table.repaymentDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get balanceAfterRepaymentPaise => $composableBuilder(
      column: $table.balanceAfterRepaymentPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$DebtsTableOrderingComposer get debtId {
    final $$DebtsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.debtId,
        referencedTable: $db.debts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtsTableOrderingComposer(
              $db: $db,
              $table: $db.debts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DebtRepaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtRepaymentsTable> {
  $$DebtRepaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get transactionId => $composableBuilder(
      column: $table.transactionId, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => column);

  GeneratedColumn<DateTime> get repaymentDate => $composableBuilder(
      column: $table.repaymentDate, builder: (column) => column);

  GeneratedColumn<int> get balanceAfterRepaymentPaise => $composableBuilder(
      column: $table.balanceAfterRepaymentPaise, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$DebtsTableAnnotationComposer get debtId {
    final $$DebtsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.debtId,
        referencedTable: $db.debts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DebtsTableAnnotationComposer(
              $db: $db,
              $table: $db.debts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DebtRepaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DebtRepaymentsTable,
    DebtRepaymentEntry,
    $$DebtRepaymentsTableFilterComposer,
    $$DebtRepaymentsTableOrderingComposer,
    $$DebtRepaymentsTableAnnotationComposer,
    $$DebtRepaymentsTableCreateCompanionBuilder,
    $$DebtRepaymentsTableUpdateCompanionBuilder,
    (DebtRepaymentEntry, $$DebtRepaymentsTableReferences),
    DebtRepaymentEntry,
    PrefetchHooks Function({bool debtId})> {
  $$DebtRepaymentsTableTableManager(
      _$AppDatabase db, $DebtRepaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtRepaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtRepaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtRepaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> debtId = const Value.absent(),
            Value<String?> transactionId = const Value.absent(),
            Value<int> amountPaise = const Value.absent(),
            Value<DateTime> repaymentDate = const Value.absent(),
            Value<int> balanceAfterRepaymentPaise = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DebtRepaymentsCompanion(
            id: id,
            debtId: debtId,
            transactionId: transactionId,
            amountPaise: amountPaise,
            repaymentDate: repaymentDate,
            balanceAfterRepaymentPaise: balanceAfterRepaymentPaise,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String debtId,
            Value<String?> transactionId = const Value.absent(),
            required int amountPaise,
            required DateTime repaymentDate,
            required int balanceAfterRepaymentPaise,
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              DebtRepaymentsCompanion.insert(
            id: id,
            debtId: debtId,
            transactionId: transactionId,
            amountPaise: amountPaise,
            repaymentDate: repaymentDate,
            balanceAfterRepaymentPaise: balanceAfterRepaymentPaise,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$DebtRepaymentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({debtId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (debtId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.debtId,
                    referencedTable:
                        $$DebtRepaymentsTableReferences._debtIdTable(db),
                    referencedColumn:
                        $$DebtRepaymentsTableReferences._debtIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$DebtRepaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DebtRepaymentsTable,
    DebtRepaymentEntry,
    $$DebtRepaymentsTableFilterComposer,
    $$DebtRepaymentsTableOrderingComposer,
    $$DebtRepaymentsTableAnnotationComposer,
    $$DebtRepaymentsTableCreateCompanionBuilder,
    $$DebtRepaymentsTableUpdateCompanionBuilder,
    (DebtRepaymentEntry, $$DebtRepaymentsTableReferences),
    DebtRepaymentEntry,
    PrefetchHooks Function({bool debtId})>;
typedef $$SplitTransactionsTableCreateCompanionBuilder
    = SplitTransactionsCompanion Function({
  required String id,
  required int totalBillPaise,
  required String description,
  Value<String?> categoryId,
  Value<String?> paidFromAccountId,
  Value<String?> cardId,
  required int mySharePaise,
  required DateTime transactionTimestamp,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SplitTransactionsTableUpdateCompanionBuilder
    = SplitTransactionsCompanion Function({
  Value<String> id,
  Value<int> totalBillPaise,
  Value<String> description,
  Value<String?> categoryId,
  Value<String?> paidFromAccountId,
  Value<String?> cardId,
  Value<int> mySharePaise,
  Value<DateTime> transactionTimestamp,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$SplitTransactionsTableReferences extends BaseReferences<
    _$AppDatabase, $SplitTransactionsTable, SplitTransactionEntry> {
  $$SplitTransactionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias($_aliasNameGenerator(
          db.splitTransactions.categoryId, db.categories.id));

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AccountsTable _paidFromAccountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias($_aliasNameGenerator(
          db.splitTransactions.paidFromAccountId, db.accounts.id));

  $$AccountsTableProcessedTableManager? get paidFromAccountId {
    final $_column = $_itemColumn<String>('paid_from_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paidFromAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CardsTable _cardIdTable(_$AppDatabase db) => db.cards.createAlias(
      $_aliasNameGenerator(db.splitTransactions.cardId, db.cards.id));

  $$CardsTableProcessedTableManager? get cardId {
    final $_column = $_itemColumn<String>('card_id');
    if ($_column == null) return null;
    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SplitTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $SplitTransactionsTable> {
  $$SplitTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalBillPaise => $composableBuilder(
      column: $table.totalBillPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mySharePaise => $composableBuilder(
      column: $table.mySharePaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get transactionTimestamp => $composableBuilder(
      column: $table.transactionTimestamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountsTableFilterComposer get paidFromAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paidFromAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CardsTableFilterComposer get cardId {
    final $$CardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableFilterComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SplitTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SplitTransactionsTable> {
  $$SplitTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalBillPaise => $composableBuilder(
      column: $table.totalBillPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mySharePaise => $composableBuilder(
      column: $table.mySharePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get transactionTimestamp => $composableBuilder(
      column: $table.transactionTimestamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountsTableOrderingComposer get paidFromAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paidFromAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CardsTableOrderingComposer get cardId {
    final $$CardsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableOrderingComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SplitTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SplitTransactionsTable> {
  $$SplitTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get totalBillPaise => $composableBuilder(
      column: $table.totalBillPaise, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<int> get mySharePaise => $composableBuilder(
      column: $table.mySharePaise, builder: (column) => column);

  GeneratedColumn<DateTime> get transactionTimestamp => $composableBuilder(
      column: $table.transactionTimestamp, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountsTableAnnotationComposer get paidFromAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paidFromAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CardsTableAnnotationComposer get cardId {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableAnnotationComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SplitTransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SplitTransactionsTable,
    SplitTransactionEntry,
    $$SplitTransactionsTableFilterComposer,
    $$SplitTransactionsTableOrderingComposer,
    $$SplitTransactionsTableAnnotationComposer,
    $$SplitTransactionsTableCreateCompanionBuilder,
    $$SplitTransactionsTableUpdateCompanionBuilder,
    (SplitTransactionEntry, $$SplitTransactionsTableReferences),
    SplitTransactionEntry,
    PrefetchHooks Function(
        {bool categoryId, bool paidFromAccountId, bool cardId})> {
  $$SplitTransactionsTableTableManager(
      _$AppDatabase db, $SplitTransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SplitTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SplitTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SplitTransactionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> totalBillPaise = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String?> categoryId = const Value.absent(),
            Value<String?> paidFromAccountId = const Value.absent(),
            Value<String?> cardId = const Value.absent(),
            Value<int> mySharePaise = const Value.absent(),
            Value<DateTime> transactionTimestamp = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SplitTransactionsCompanion(
            id: id,
            totalBillPaise: totalBillPaise,
            description: description,
            categoryId: categoryId,
            paidFromAccountId: paidFromAccountId,
            cardId: cardId,
            mySharePaise: mySharePaise,
            transactionTimestamp: transactionTimestamp,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int totalBillPaise,
            required String description,
            Value<String?> categoryId = const Value.absent(),
            Value<String?> paidFromAccountId = const Value.absent(),
            Value<String?> cardId = const Value.absent(),
            required int mySharePaise,
            required DateTime transactionTimestamp,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SplitTransactionsCompanion.insert(
            id: id,
            totalBillPaise: totalBillPaise,
            description: description,
            categoryId: categoryId,
            paidFromAccountId: paidFromAccountId,
            cardId: cardId,
            mySharePaise: mySharePaise,
            transactionTimestamp: transactionTimestamp,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SplitTransactionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {categoryId = false, paidFromAccountId = false, cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$SplitTransactionsTableReferences._categoryIdTable(db),
                    referencedColumn: $$SplitTransactionsTableReferences
                        ._categoryIdTable(db)
                        .id,
                  ) as T;
                }
                if (paidFromAccountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.paidFromAccountId,
                    referencedTable: $$SplitTransactionsTableReferences
                        ._paidFromAccountIdTable(db),
                    referencedColumn: $$SplitTransactionsTableReferences
                        ._paidFromAccountIdTable(db)
                        .id,
                  ) as T;
                }
                if (cardId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cardId,
                    referencedTable:
                        $$SplitTransactionsTableReferences._cardIdTable(db),
                    referencedColumn:
                        $$SplitTransactionsTableReferences._cardIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SplitTransactionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SplitTransactionsTable,
    SplitTransactionEntry,
    $$SplitTransactionsTableFilterComposer,
    $$SplitTransactionsTableOrderingComposer,
    $$SplitTransactionsTableAnnotationComposer,
    $$SplitTransactionsTableCreateCompanionBuilder,
    $$SplitTransactionsTableUpdateCompanionBuilder,
    (SplitTransactionEntry, $$SplitTransactionsTableReferences),
    SplitTransactionEntry,
    PrefetchHooks Function(
        {bool categoryId, bool paidFromAccountId, bool cardId})>;
typedef $$TransactionsTableCreateCompanionBuilder = TransactionsCompanion
    Function({
  required String id,
  required String type,
  required int amountPaise,
  Value<String?> fromAccountId,
  Value<String?> toAccountId,
  Value<String?> cardId,
  Value<String?> categoryId,
  Value<String?> personId,
  Value<String?> splitGroupId,
  Value<int?> totalBillPaise,
  required DateTime transactionTimestamp,
  Value<String?> note,
  Value<bool> isExcludedFromBudget,
  Value<bool> isCleared,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$TransactionsTableUpdateCompanionBuilder = TransactionsCompanion
    Function({
  Value<String> id,
  Value<String> type,
  Value<int> amountPaise,
  Value<String?> fromAccountId,
  Value<String?> toAccountId,
  Value<String?> cardId,
  Value<String?> categoryId,
  Value<String?> personId,
  Value<String?> splitGroupId,
  Value<int?> totalBillPaise,
  Value<DateTime> transactionTimestamp,
  Value<String?> note,
  Value<bool> isExcludedFromBudget,
  Value<bool> isCleared,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$TransactionsTableReferences extends BaseReferences<_$AppDatabase,
    $TransactionsTable, TransactionEntry> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTable _fromAccountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias(
          $_aliasNameGenerator(db.transactions.fromAccountId, db.accounts.id));

  $$AccountsTableProcessedTableManager? get fromAccountId {
    final $_column = $_itemColumn<String>('from_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fromAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $AccountsTable _toAccountIdTable(_$AppDatabase db) =>
      db.accounts.createAlias(
          $_aliasNameGenerator(db.transactions.toAccountId, db.accounts.id));

  $$AccountsTableProcessedTableManager? get toAccountId {
    final $_column = $_itemColumn<String>('to_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableManager($_db, $_db.accounts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_toAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CardsTable _cardIdTable(_$AppDatabase db) => db.cards
      .createAlias($_aliasNameGenerator(db.transactions.cardId, db.cards.id));

  $$CardsTableProcessedTableManager? get cardId {
    final $_column = $_itemColumn<String>('card_id');
    if ($_column == null) return null;
    final manager = $$CardsTableTableManager($_db, $_db.cards)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias(
          $_aliasNameGenerator(db.transactions.categoryId, db.categories.id));

  $$CategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesTableTableManager($_db, $_db.categories)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PersonsTable _personIdTable(_$AppDatabase db) =>
      db.persons.createAlias(
          $_aliasNameGenerator(db.transactions.personId, db.persons.id));

  $$PersonsTableProcessedTableManager? get personId {
    final $_column = $_itemColumn<String>('person_id');
    if ($_column == null) return null;
    final manager = $$PersonsTableTableManager($_db, $_db.persons)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get splitGroupId => $composableBuilder(
      column: $table.splitGroupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalBillPaise => $composableBuilder(
      column: $table.totalBillPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get transactionTimestamp => $composableBuilder(
      column: $table.transactionTimestamp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isExcludedFromBudget => $composableBuilder(
      column: $table.isExcludedFromBudget,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCleared => $composableBuilder(
      column: $table.isCleared, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$AccountsTableFilterComposer get fromAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fromAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountsTableFilterComposer get toAccountId {
    final $$AccountsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.toAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableFilterComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CardsTableFilterComposer get cardId {
    final $$CardsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableFilterComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableFilterComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PersonsTableFilterComposer get personId {
    final $$PersonsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.personId,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableFilterComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get splitGroupId => $composableBuilder(
      column: $table.splitGroupId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalBillPaise => $composableBuilder(
      column: $table.totalBillPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get transactionTimestamp => $composableBuilder(
      column: $table.transactionTimestamp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isExcludedFromBudget => $composableBuilder(
      column: $table.isExcludedFromBudget,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCleared => $composableBuilder(
      column: $table.isCleared, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$AccountsTableOrderingComposer get fromAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fromAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountsTableOrderingComposer get toAccountId {
    final $$AccountsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.toAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableOrderingComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CardsTableOrderingComposer get cardId {
    final $$CardsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableOrderingComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableOrderingComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PersonsTableOrderingComposer get personId {
    final $$PersonsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.personId,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableOrderingComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amountPaise => $composableBuilder(
      column: $table.amountPaise, builder: (column) => column);

  GeneratedColumn<String> get splitGroupId => $composableBuilder(
      column: $table.splitGroupId, builder: (column) => column);

  GeneratedColumn<int> get totalBillPaise => $composableBuilder(
      column: $table.totalBillPaise, builder: (column) => column);

  GeneratedColumn<DateTime> get transactionTimestamp => $composableBuilder(
      column: $table.transactionTimestamp, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isExcludedFromBudget => $composableBuilder(
      column: $table.isExcludedFromBudget, builder: (column) => column);

  GeneratedColumn<bool> get isCleared =>
      $composableBuilder(column: $table.isCleared, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AccountsTableAnnotationComposer get fromAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fromAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$AccountsTableAnnotationComposer get toAccountId {
    final $$AccountsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.toAccountId,
        referencedTable: $db.accounts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AccountsTableAnnotationComposer(
              $db: $db,
              $table: $db.accounts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CardsTableAnnotationComposer get cardId {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cardId,
        referencedTable: $db.cards,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CardsTableAnnotationComposer(
              $db: $db,
              $table: $db.cards,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categories,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableAnnotationComposer(
              $db: $db,
              $table: $db.categories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PersonsTableAnnotationComposer get personId {
    final $$PersonsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.personId,
        referencedTable: $db.persons,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableAnnotationComposer(
              $db: $db,
              $table: $db.persons,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionsTable,
    TransactionEntry,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (TransactionEntry, $$TransactionsTableReferences),
    TransactionEntry,
    PrefetchHooks Function(
        {bool fromAccountId,
        bool toAccountId,
        bool cardId,
        bool categoryId,
        bool personId})> {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> amountPaise = const Value.absent(),
            Value<String?> fromAccountId = const Value.absent(),
            Value<String?> toAccountId = const Value.absent(),
            Value<String?> cardId = const Value.absent(),
            Value<String?> categoryId = const Value.absent(),
            Value<String?> personId = const Value.absent(),
            Value<String?> splitGroupId = const Value.absent(),
            Value<int?> totalBillPaise = const Value.absent(),
            Value<DateTime> transactionTimestamp = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> isExcludedFromBudget = const Value.absent(),
            Value<bool> isCleared = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionsCompanion(
            id: id,
            type: type,
            amountPaise: amountPaise,
            fromAccountId: fromAccountId,
            toAccountId: toAccountId,
            cardId: cardId,
            categoryId: categoryId,
            personId: personId,
            splitGroupId: splitGroupId,
            totalBillPaise: totalBillPaise,
            transactionTimestamp: transactionTimestamp,
            note: note,
            isExcludedFromBudget: isExcludedFromBudget,
            isCleared: isCleared,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String type,
            required int amountPaise,
            Value<String?> fromAccountId = const Value.absent(),
            Value<String?> toAccountId = const Value.absent(),
            Value<String?> cardId = const Value.absent(),
            Value<String?> categoryId = const Value.absent(),
            Value<String?> personId = const Value.absent(),
            Value<String?> splitGroupId = const Value.absent(),
            Value<int?> totalBillPaise = const Value.absent(),
            required DateTime transactionTimestamp,
            Value<String?> note = const Value.absent(),
            Value<bool> isExcludedFromBudget = const Value.absent(),
            Value<bool> isCleared = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionsCompanion.insert(
            id: id,
            type: type,
            amountPaise: amountPaise,
            fromAccountId: fromAccountId,
            toAccountId: toAccountId,
            cardId: cardId,
            categoryId: categoryId,
            personId: personId,
            splitGroupId: splitGroupId,
            totalBillPaise: totalBillPaise,
            transactionTimestamp: transactionTimestamp,
            note: note,
            isExcludedFromBudget: isExcludedFromBudget,
            isCleared: isCleared,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TransactionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {fromAccountId = false,
              toAccountId = false,
              cardId = false,
              categoryId = false,
              personId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (fromAccountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.fromAccountId,
                    referencedTable:
                        $$TransactionsTableReferences._fromAccountIdTable(db),
                    referencedColumn: $$TransactionsTableReferences
                        ._fromAccountIdTable(db)
                        .id,
                  ) as T;
                }
                if (toAccountId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.toAccountId,
                    referencedTable:
                        $$TransactionsTableReferences._toAccountIdTable(db),
                    referencedColumn:
                        $$TransactionsTableReferences._toAccountIdTable(db).id,
                  ) as T;
                }
                if (cardId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cardId,
                    referencedTable:
                        $$TransactionsTableReferences._cardIdTable(db),
                    referencedColumn:
                        $$TransactionsTableReferences._cardIdTable(db).id,
                  ) as T;
                }
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$TransactionsTableReferences._categoryIdTable(db),
                    referencedColumn:
                        $$TransactionsTableReferences._categoryIdTable(db).id,
                  ) as T;
                }
                if (personId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.personId,
                    referencedTable:
                        $$TransactionsTableReferences._personIdTable(db),
                    referencedColumn:
                        $$TransactionsTableReferences._personIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TransactionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionsTable,
    TransactionEntry,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (TransactionEntry, $$TransactionsTableReferences),
    TransactionEntry,
    PrefetchHooks Function(
        {bool fromAccountId,
        bool toAccountId,
        bool cardId,
        bool categoryId,
        bool personId})>;
typedef $$DailyBudgetConfigTableTableCreateCompanionBuilder
    = DailyBudgetConfigTableCompanion Function({
  required String id,
  required int dailyAllocationPaise,
  Value<bool> enableCarryForward,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$DailyBudgetConfigTableTableUpdateCompanionBuilder
    = DailyBudgetConfigTableCompanion Function({
  Value<String> id,
  Value<int> dailyAllocationPaise,
  Value<bool> enableCarryForward,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$DailyBudgetConfigTableTableFilterComposer
    extends Composer<_$AppDatabase, $DailyBudgetConfigTableTable> {
  $$DailyBudgetConfigTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dailyAllocationPaise => $composableBuilder(
      column: $table.dailyAllocationPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enableCarryForward => $composableBuilder(
      column: $table.enableCarryForward,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$DailyBudgetConfigTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyBudgetConfigTableTable> {
  $$DailyBudgetConfigTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dailyAllocationPaise => $composableBuilder(
      column: $table.dailyAllocationPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enableCarryForward => $composableBuilder(
      column: $table.enableCarryForward,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$DailyBudgetConfigTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyBudgetConfigTableTable> {
  $$DailyBudgetConfigTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dailyAllocationPaise => $composableBuilder(
      column: $table.dailyAllocationPaise, builder: (column) => column);

  GeneratedColumn<bool> get enableCarryForward => $composableBuilder(
      column: $table.enableCarryForward, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyBudgetConfigTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyBudgetConfigTableTable,
    DailyBudgetConfigEntry,
    $$DailyBudgetConfigTableTableFilterComposer,
    $$DailyBudgetConfigTableTableOrderingComposer,
    $$DailyBudgetConfigTableTableAnnotationComposer,
    $$DailyBudgetConfigTableTableCreateCompanionBuilder,
    $$DailyBudgetConfigTableTableUpdateCompanionBuilder,
    (
      DailyBudgetConfigEntry,
      BaseReferences<_$AppDatabase, $DailyBudgetConfigTableTable,
          DailyBudgetConfigEntry>
    ),
    DailyBudgetConfigEntry,
    PrefetchHooks Function()> {
  $$DailyBudgetConfigTableTableTableManager(
      _$AppDatabase db, $DailyBudgetConfigTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyBudgetConfigTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyBudgetConfigTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyBudgetConfigTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> dailyAllocationPaise = const Value.absent(),
            Value<bool> enableCarryForward = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyBudgetConfigTableCompanion(
            id: id,
            dailyAllocationPaise: dailyAllocationPaise,
            enableCarryForward: enableCarryForward,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int dailyAllocationPaise,
            Value<bool> enableCarryForward = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyBudgetConfigTableCompanion.insert(
            id: id,
            dailyAllocationPaise: dailyAllocationPaise,
            enableCarryForward: enableCarryForward,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailyBudgetConfigTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $DailyBudgetConfigTableTable,
        DailyBudgetConfigEntry,
        $$DailyBudgetConfigTableTableFilterComposer,
        $$DailyBudgetConfigTableTableOrderingComposer,
        $$DailyBudgetConfigTableTableAnnotationComposer,
        $$DailyBudgetConfigTableTableCreateCompanionBuilder,
        $$DailyBudgetConfigTableTableUpdateCompanionBuilder,
        (
          DailyBudgetConfigEntry,
          BaseReferences<_$AppDatabase, $DailyBudgetConfigTableTable,
              DailyBudgetConfigEntry>
        ),
        DailyBudgetConfigEntry,
        PrefetchHooks Function()>;
typedef $$DailyBudgetSnapshotsTableCreateCompanionBuilder
    = DailyBudgetSnapshotsCompanion Function({
  Value<int> dateEpochDay,
  required int allocatedPaise,
  required int spentPaise,
  required int carriedForwardPaise,
  required int netAvailablePaise,
  required DateTime updatedAt,
});
typedef $$DailyBudgetSnapshotsTableUpdateCompanionBuilder
    = DailyBudgetSnapshotsCompanion Function({
  Value<int> dateEpochDay,
  Value<int> allocatedPaise,
  Value<int> spentPaise,
  Value<int> carriedForwardPaise,
  Value<int> netAvailablePaise,
  Value<DateTime> updatedAt,
});

class $$DailyBudgetSnapshotsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyBudgetSnapshotsTable> {
  $$DailyBudgetSnapshotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get dateEpochDay => $composableBuilder(
      column: $table.dateEpochDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get allocatedPaise => $composableBuilder(
      column: $table.allocatedPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get spentPaise => $composableBuilder(
      column: $table.spentPaise, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get carriedForwardPaise => $composableBuilder(
      column: $table.carriedForwardPaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get netAvailablePaise => $composableBuilder(
      column: $table.netAvailablePaise,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$DailyBudgetSnapshotsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyBudgetSnapshotsTable> {
  $$DailyBudgetSnapshotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get dateEpochDay => $composableBuilder(
      column: $table.dateEpochDay,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get allocatedPaise => $composableBuilder(
      column: $table.allocatedPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get spentPaise => $composableBuilder(
      column: $table.spentPaise, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get carriedForwardPaise => $composableBuilder(
      column: $table.carriedForwardPaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get netAvailablePaise => $composableBuilder(
      column: $table.netAvailablePaise,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$DailyBudgetSnapshotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyBudgetSnapshotsTable> {
  $$DailyBudgetSnapshotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get dateEpochDay => $composableBuilder(
      column: $table.dateEpochDay, builder: (column) => column);

  GeneratedColumn<int> get allocatedPaise => $composableBuilder(
      column: $table.allocatedPaise, builder: (column) => column);

  GeneratedColumn<int> get spentPaise => $composableBuilder(
      column: $table.spentPaise, builder: (column) => column);

  GeneratedColumn<int> get carriedForwardPaise => $composableBuilder(
      column: $table.carriedForwardPaise, builder: (column) => column);

  GeneratedColumn<int> get netAvailablePaise => $composableBuilder(
      column: $table.netAvailablePaise, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyBudgetSnapshotsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyBudgetSnapshotsTable,
    DailyBudgetSnapshotEntry,
    $$DailyBudgetSnapshotsTableFilterComposer,
    $$DailyBudgetSnapshotsTableOrderingComposer,
    $$DailyBudgetSnapshotsTableAnnotationComposer,
    $$DailyBudgetSnapshotsTableCreateCompanionBuilder,
    $$DailyBudgetSnapshotsTableUpdateCompanionBuilder,
    (
      DailyBudgetSnapshotEntry,
      BaseReferences<_$AppDatabase, $DailyBudgetSnapshotsTable,
          DailyBudgetSnapshotEntry>
    ),
    DailyBudgetSnapshotEntry,
    PrefetchHooks Function()> {
  $$DailyBudgetSnapshotsTableTableManager(
      _$AppDatabase db, $DailyBudgetSnapshotsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyBudgetSnapshotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyBudgetSnapshotsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyBudgetSnapshotsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> dateEpochDay = const Value.absent(),
            Value<int> allocatedPaise = const Value.absent(),
            Value<int> spentPaise = const Value.absent(),
            Value<int> carriedForwardPaise = const Value.absent(),
            Value<int> netAvailablePaise = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              DailyBudgetSnapshotsCompanion(
            dateEpochDay: dateEpochDay,
            allocatedPaise: allocatedPaise,
            spentPaise: spentPaise,
            carriedForwardPaise: carriedForwardPaise,
            netAvailablePaise: netAvailablePaise,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> dateEpochDay = const Value.absent(),
            required int allocatedPaise,
            required int spentPaise,
            required int carriedForwardPaise,
            required int netAvailablePaise,
            required DateTime updatedAt,
          }) =>
              DailyBudgetSnapshotsCompanion.insert(
            dateEpochDay: dateEpochDay,
            allocatedPaise: allocatedPaise,
            spentPaise: spentPaise,
            carriedForwardPaise: carriedForwardPaise,
            netAvailablePaise: netAvailablePaise,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailyBudgetSnapshotsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $DailyBudgetSnapshotsTable,
        DailyBudgetSnapshotEntry,
        $$DailyBudgetSnapshotsTableFilterComposer,
        $$DailyBudgetSnapshotsTableOrderingComposer,
        $$DailyBudgetSnapshotsTableAnnotationComposer,
        $$DailyBudgetSnapshotsTableCreateCompanionBuilder,
        $$DailyBudgetSnapshotsTableUpdateCompanionBuilder,
        (
          DailyBudgetSnapshotEntry,
          BaseReferences<_$AppDatabase, $DailyBudgetSnapshotsTable,
              DailyBudgetSnapshotEntry>
        ),
        DailyBudgetSnapshotEntry,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db, _db.accounts);
  $$CardsTableTableManager get cards =>
      $$CardsTableTableManager(_db, _db.cards);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$PersonsTableTableManager get persons =>
      $$PersonsTableTableManager(_db, _db.persons);
  $$DebtsTableTableManager get debts =>
      $$DebtsTableTableManager(_db, _db.debts);
  $$DebtRepaymentsTableTableManager get debtRepayments =>
      $$DebtRepaymentsTableTableManager(_db, _db.debtRepayments);
  $$SplitTransactionsTableTableManager get splitTransactions =>
      $$SplitTransactionsTableTableManager(_db, _db.splitTransactions);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$DailyBudgetConfigTableTableTableManager get dailyBudgetConfigTable =>
      $$DailyBudgetConfigTableTableTableManager(
          _db, _db.dailyBudgetConfigTable);
  $$DailyBudgetSnapshotsTableTableManager get dailyBudgetSnapshots =>
      $$DailyBudgetSnapshotsTableTableManager(_db, _db.dailyBudgetSnapshots);
}
