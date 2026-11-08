import 'package:flutter/foundation.dart';

enum TransactionType {
  income,
  expense,
  splitExpense,
  transfer,
  debtLend,
  debtBorrow,
  debtRepayment,
  creditCardPayment,
}

@immutable
class TransactionModel {
  final String id;
  final TransactionType type;
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

  const TransactionModel({
    required this.id,
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
    this.isExcludedFromBudget = false,
    this.isCleared = true,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isInflow =>
      type == TransactionType.income ||
      type == TransactionType.debtBorrow ||
      (type == TransactionType.debtRepayment && fromAccountId != null);
}
