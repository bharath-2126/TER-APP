import 'package:flutter/foundation.dart';

enum DebtType {
  lent, // Money user gave to someone (Receivable)
  borrowed, // Money user received from someone (Payable)
}

enum DebtStatus {
  active,
  partiallyPaid,
  fullySettled,
}

@immutable
class PersonModel {
  final String id;
  final String name;
  final String? phone;
  final int outstandingBalancePaise; // Positive = they owe user (Receivable)
  final String avatarColor;

  const PersonModel({
    required this.id,
    required this.name,
    this.phone,
    required this.outstandingBalancePaise,
    this.avatarColor = '2563EB',
  });

  PersonModel copyWith({
    String? id,
    String? name,
    String? phone,
    int? outstandingBalancePaise,
    String? avatarColor,
  }) {
    return PersonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      outstandingBalancePaise: outstandingBalancePaise ?? this.outstandingBalancePaise,
      avatarColor: avatarColor ?? this.avatarColor,
    );
  }
}

@immutable
class DebtRecord {
  final String id;
  final String personId;
  final DebtType type;
  final int principalPaise;
  final int outstandingBalancePaise;
  final DateTime initialDate;
  final DateTime? dueDate;
  final DebtStatus status;
  final String? notes;
  final String? splitGroupId;

  const DebtRecord({
    required this.id,
    required this.personId,
    required this.type,
    required this.principalPaise,
    required this.outstandingBalancePaise,
    required this.initialDate,
    this.dueDate,
    required this.status,
    this.notes,
    this.splitGroupId,
  });

  /// Invariant check: Outstanding balance must never exceed principal
  bool get isValid => outstandingBalancePaise >= 0 && outstandingBalancePaise <= principalPaise;

  DebtRecord copyWithOutstanding({
    required int newOutstanding,
    required DebtStatus newStatus,
  }) {
    return DebtRecord(
      id: id,
      personId: personId,
      type: type,
      principalPaise: principalPaise,
      outstandingBalancePaise: newOutstanding,
      initialDate: initialDate,
      dueDate: dueDate,
      status: newStatus,
      notes: notes,
      splitGroupId: splitGroupId,
    );
  }
}

@immutable
class RepaymentRecord {
  final String id;
  final String debtId;
  final int amountPaise;
  final DateTime repaymentDate;
  final int balanceAfterRepaymentPaise;
  final String? notes;

  const RepaymentRecord({
    required this.id,
    required this.debtId,
    required this.amountPaise,
    required this.repaymentDate,
    required this.balanceAfterRepaymentPaise,
    this.notes,
  });
}

/// Pure domain calculation engine for Lending and Borrowing.
/// Ensures original records are NEVER mutated and all partial repayments are append-only.
abstract class LendingEngine {
  /// Calculates the new outstanding balance and status after a partial or full repayment.
  /// Throws an [ArgumentError] if repayment amount exceeds the outstanding balance.
  static ({int newOutstandingPaise, DebtStatus newStatus, RepaymentRecord repayment}) applyRepayment({
    required DebtRecord debt,
    required String repaymentId,
    required int repaymentAmountPaise,
    required DateTime repaymentDate,
    String? notes,
  }) {
    if (repaymentAmountPaise <= 0) {
      throw ArgumentError('Repayment amount must be positive');
    }
    if (repaymentAmountPaise > debt.outstandingBalancePaise) {
      throw ArgumentError(
        'Repayment amount (₹${repaymentAmountPaise / 100}) cannot exceed outstanding balance (₹${debt.outstandingBalancePaise / 100})',
      );
    }

    final newOutstanding = debt.outstandingBalancePaise - repaymentAmountPaise;
    final newStatus = newOutstanding == 0 ? DebtStatus.fullySettled : DebtStatus.partiallyPaid;

    final repayment = RepaymentRecord(
      id: repaymentId,
      debtId: debt.id,
      amountPaise: repaymentAmountPaise,
      repaymentDate: repaymentDate,
      balanceAfterRepaymentPaise: newOutstanding,
      notes: notes,
    );

    return (
      newOutstandingPaise: newOutstanding,
      newStatus: newStatus,
      repayment: repayment,
    );
  }

  /// Calculates aggregate receivables (lent) and payables (borrowed) across active debts
  static ({int totalLentOutstandingPaise, int totalBorrowedOutstandingPaise}) calculateAggregates(
    List<DebtRecord> debts,
  ) {
    int lentSum = 0;
    int borrowedSum = 0;

    for (final debt in debts) {
      if (debt.status == DebtStatus.fullySettled) continue;

      if (debt.type == DebtType.lent) {
        lentSum += debt.outstandingBalancePaise;
      } else {
        borrowedSum += debt.outstandingBalancePaise;
      }
    }

    return (
      totalLentOutstandingPaise: lentSum,
      totalBorrowedOutstandingPaise: borrowedSum,
    );
  }
}
