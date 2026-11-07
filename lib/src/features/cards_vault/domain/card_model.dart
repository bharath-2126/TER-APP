import 'package:flutter/foundation.dart';

enum CardType {
  credit,
  debit,
  prepaid,
}

enum CardSkinType {
  preset,
  customImage,
}

@immutable
class CardModel {
  final String id;
  final String? accountId; // Linked bank account (for debit cards)
  final String cardName;
  final CardType cardType;
  final String issuerBank;
  final String last4Digits;
  final String? cardholderName;
  final int? billingCycleDay;
  final int? paymentDueDay;
  final int? creditLimitPaise;
  final int currentOutstandingPaise;
  final CardSkinType skinType;
  final String? skinAssetOrPath;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CardModel({
    required this.id,
    this.accountId,
    required this.cardName,
    required this.cardType,
    required this.issuerBank,
    required this.last4Digits,
    this.cardholderName,
    this.billingCycleDay,
    this.paymentDueDay,
    this.creditLimitPaise,
    this.currentOutstandingPaise = 0,
    this.skinType = CardSkinType.preset,
    this.skinAssetOrPath,
    this.isArchived = false,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Available credit remaining on credit cards
  int? get availableCreditPaise {
    if (creditLimitPaise == null) return null;
    return creditLimitPaise! - currentOutstandingPaise;
  }

  CardModel copyWith({
    String? cardName,
    int? currentOutstandingPaise,
    int? creditLimitPaise,
    CardSkinType? skinType,
    String? skinAssetOrPath,
    bool? isArchived,
    DateTime? updatedAt,
  }) {
    return CardModel(
      id: id,
      accountId: accountId,
      cardName: cardName ?? this.cardName,
      cardType: cardType,
      issuerBank: issuerBank,
      last4Digits: last4Digits,
      cardholderName: cardholderName,
      billingCycleDay: billingCycleDay,
      paymentDueDay: paymentDueDay,
      creditLimitPaise: creditLimitPaise ?? this.creditLimitPaise,
      currentOutstandingPaise: currentOutstandingPaise ?? this.currentOutstandingPaise,
      skinType: skinType ?? this.skinType,
      skinAssetOrPath: skinAssetOrPath ?? this.skinAssetOrPath,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
