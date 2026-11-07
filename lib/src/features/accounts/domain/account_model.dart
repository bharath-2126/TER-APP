import 'package:flutter/foundation.dart';

enum AccountType {
  bank,
  cash,
  wallet,
}

@immutable
class AccountModel {
  final String id;
  final String name;
  final AccountType type;
  final int openingBalancePaise;
  final int currentBalancePaise;
  final String currencyCode;
  final String? icon;
  final String? colorHex;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AccountModel({
    required this.id,
    required this.name,
    required this.type,
    required this.openingBalancePaise,
    required this.currentBalancePaise,
    this.currencyCode = 'INR',
    this.icon,
    this.colorHex,
    this.isArchived = false,
    required this.createdAt,
    required this.updatedAt,
  });

  AccountModel copyWith({
    String? name,
    AccountType? type,
    int? currentBalancePaise,
    String? icon,
    String? colorHex,
    bool? isArchived,
    DateTime? updatedAt,
  }) {
    return AccountModel(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      openingBalancePaise: openingBalancePaise,
      currentBalancePaise: currentBalancePaise ?? this.currentBalancePaise,
      currencyCode: currencyCode,
      icon: icon ?? this.icon,
      colorHex: colorHex ?? this.colorHex,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
