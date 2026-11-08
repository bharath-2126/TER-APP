import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_every_rupee/src/features/transactions/data/ledger_repository.dart';
import 'package:tracker_every_rupee/src/features/transactions/domain/transaction_model.dart';
import 'package:tracker_every_rupee/src/features/cards_vault/domain/card_model.dart';

void main() {
  group('LedgerRepository Double-Entry & Settlement Tests', () {
    late LedgerRepository repo;

    setUp(() {
      repo = LedgerRepository();
    });

    tearDown(() {
      repo.dispose();
    });

    test('Initial seeded balance calculation is accurate', () {
      // Seed: HDFC (185550) + ICICI (65000) + Cash (15000) = 265550.00 (₹2,65,550.00)
      expect(repo.calculateTotalLiquidBalancePaise(), 26555000);
    });

    test('Logging an expense deducts correctly from bank balance', () async {
      final initialBalance = repo.calculateTotalLiquidBalancePaise();
      final tx = TransactionModel(
        id: 'tx_exp_1',
        type: TransactionType.expense,
        amountPaise: 50000, // ₹500
        fromAccountId: 'acc_hdfc',
        transactionTimestamp: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await repo.logTransaction(tx);
      expect(repo.calculateTotalLiquidBalancePaise(), initialBalance - 50000);
    });

    test('Logging a credit card expense increases outstanding balance without touching bank balance', () async {
      final initialBankBalance = repo.calculateTotalLiquidBalancePaise();
      final initialOutstanding = repo.cards.firstWhere((c) => c.id == 'card_regalia').currentOutstandingPaise;

      final tx = TransactionModel(
        id: 'tx_cc_1',
        type: TransactionType.expense,
        amountPaise: 120000, // ₹1,200
        cardId: 'card_regalia',
        transactionTimestamp: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await repo.logTransaction(tx);

      // Bank cash balance remains untouched
      expect(repo.calculateTotalLiquidBalancePaise(), initialBankBalance);

      // Credit card outstanding increased
      final updatedCard = repo.cards.firstWhere((c) => c.id == 'card_regalia');
      expect(updatedCard.currentOutstandingPaise, initialOutstanding + 120000);
    });

    test('Credit Card Bill Settlement settles card without creating duplicate expenses', () async {
      final initialBankBalance = repo.calculateTotalLiquidBalancePaise();
      final card = repo.cards.firstWhere((c) => c.id == 'card_regalia');
      final initialOutstanding = card.currentOutstandingPaise;

      // Pay ₹10,000 towards the credit card bill from HDFC
      final tx = TransactionModel(
        id: 'tx_settle_1',
        type: TransactionType.creditCardPayment,
        amountPaise: 1000000, // ₹10,000
        fromAccountId: 'acc_hdfc',
        cardId: 'card_regalia',
        transactionTimestamp: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await repo.logTransaction(tx);

      // 1. Bank balance reduced by ₹10,000
      expect(repo.calculateTotalLiquidBalancePaise(), initialBankBalance - 1000000);

      // 2. Card outstanding reduced by ₹10,000
      final updatedCard = repo.cards.firstWhere((c) => c.id == 'card_regalia');
      expect(updatedCard.currentOutstandingPaise, initialOutstanding - 1000000);
    });

    test('Account Transfer has zero net impact on total wealth', () async {
      final initialWealth = repo.calculateTotalLiquidBalancePaise();

      final tx = TransactionModel(
        id: 'tx_transfer_1',
        type: TransactionType.transfer,
        amountPaise: 2000000, // ₹20,000 from HDFC to ICICI
        fromAccountId: 'acc_hdfc',
        toAccountId: 'acc_icici',
        transactionTimestamp: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await repo.logTransaction(tx);

      // Total wealth is invariant
      expect(repo.calculateTotalLiquidBalancePaise(), initialWealth);
    });
  });
}
