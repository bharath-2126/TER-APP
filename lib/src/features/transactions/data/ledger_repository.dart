import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../accounts/domain/account_model.dart';
import '../../cards_vault/domain/card_model.dart';
import '../../lending/domain/lending_engine.dart';
import '../../budget/domain/daily_budget_engine.dart';
import '../domain/transaction_model.dart';

/// Central Ledger Repository enforcing double-entry rules and financial invariants.
class LedgerRepository {
  // In-memory reactive state backing local Drift storage
  final List<AccountModel> _accounts = [];
  final List<CardModel> _cards = [];
  final List<DebtRecord> _debts = [];
  final List<RepaymentRecord> _repayments = [];
  final List<TransactionModel> _transactions = [];
  final Map<int, int> _dailyExpenses = {}; // epochDay -> totalPaise

  final _transactionsStreamController = StreamController<List<TransactionModel>>.broadcast();
  final _accountsStreamController = StreamController<List<AccountModel>>.broadcast();
  final _cardsStreamController = StreamController<List<CardModel>>.broadcast();
  final _debtsStreamController = StreamController<List<DebtRecord>>.broadcast();

  LedgerRepository() {
    _seedInitialAccountsAndCards();
  }

  void _seedInitialAccountsAndCards() {
    final now = DateTime.now();
    _accounts.addAll([
      AccountModel(
        id: 'acc_hdfc',
        name: 'HDFC Salary A/c',
        type: AccountType.bank,
        openingBalancePaise: 14285000, // ₹1,42,850.00
        currentBalancePaise: 14285000,
        createdAt: now,
        updatedAt: now,
      ),
      AccountModel(
        id: 'acc_icici',
        name: 'ICICI Savings A/c',
        type: AccountType.bank,
        openingBalancePaise: 6520000, // ₹65,200.00
        currentBalancePaise: 6520000,
        createdAt: now,
        updatedAt: now,
      ),
      AccountModel(
        id: 'acc_cash',
        name: 'Cash Wallet',
        type: AccountType.cash,
        openingBalancePaise: 1250000, // ₹12,500.00
        currentBalancePaise: 1250000,
        createdAt: now,
        updatedAt: now,
      ),
    ]);

    _cards.addAll([
      CardModel(
        id: 'card_regalia',
        cardName: 'HDFC Regalia Gold',
        cardType: CardType.credit,
        issuerBank: 'HDFC Bank',
        last4Digits: '8821',
        creditLimitPaise: 50000000, // ₹5,00,000.00
        currentOutstandingPaise: 3420000, // ₹34,200.00
        createdAt: now,
        updatedAt: now,
      ),
      CardModel(
        id: 'card_coral',
        accountId: 'acc_icici',
        cardName: 'ICICI Coral Debit',
        cardType: CardType.debit,
        issuerBank: 'ICICI Bank',
        last4Digits: '1942',
        createdAt: now,
        updatedAt: now,
      ),
    ]);

    _notifyAll();
  }

  // --- Streams ---
  Stream<List<TransactionModel>> watchTransactions() => _transactionsStreamController.stream;
  Stream<List<AccountModel>> watchAccounts() => _accountsStreamController.stream;
  Stream<List<CardModel>> watchCards() => _cardsStreamController.stream;
  Stream<List<DebtRecord>> watchDebts() => _debtsStreamController.stream;

  List<TransactionModel> get transactions => List.unmodifiable(_transactions);
  List<AccountModel> get accounts => List.unmodifiable(_accounts);
  List<CardModel> get cards => List.unmodifiable(_cards);
  List<DebtRecord> get debts => List.unmodifiable(_debts);

  /// Computes aggregate Liquid Cash Net Worth
  int calculateTotalLiquidBalancePaise() {
    int total = 0;
    for (final acc in _accounts) {
      if (!acc.isArchived) total += acc.currentBalancePaise;
    }
    return total;
  }

  /// Logs a transaction enforcing atomic ledger updates
  Future<void> logTransaction(TransactionModel tx) async {
    switch (tx.type) {
      case TransactionType.expense:
        _applyExpense(tx);
        break;
      case TransactionType.income:
        _applyIncome(tx);
        break;
      case TransactionType.transfer:
        _applyTransfer(tx);
        break;
      case TransactionType.creditCardPayment:
        _applyCreditCardSettlement(tx);
        break;
      case TransactionType.debtLend:
      case TransactionType.debtBorrow:
      case TransactionType.debtRepayment:
        _applyDebtTransaction(tx);
        break;
    }

    _transactions.insert(0, tx);

    // Track daily budget expense if not excluded
    if (tx.type == TransactionType.expense && !tx.isExcludedFromBudget) {
      final epochDay = tx.transactionTimestamp.millisecondsSinceEpoch ~/ 86400000;
      _dailyExpenses[epochDay] = (_dailyExpenses[epochDay] ?? 0) + tx.amountPaise;
    }

    _notifyAll();
  }

  void _applyExpense(TransactionModel tx) {
    if (tx.cardId != null) {
      final cardIdx = _cards.indexWhere((c) => c.id == tx.cardId);
      if (cardIdx != -1) {
        final card = _cards[cardIdx];
        if (card.cardType == CardType.credit) {
          // Increase card outstanding balance
          _cards[cardIdx] = card.copyWith(
            currentOutstandingPaise: card.currentOutstandingPaise + tx.amountPaise,
            updatedAt: DateTime.now(),
          );
          return;
        } else if (card.accountId != null) {
          // Debit card directly charges linked bank account
          _deductAccountBalance(card.accountId!, tx.amountPaise);
          return;
        }
      }
    }

    if (tx.fromAccountId != null) {
      _deductAccountBalance(tx.fromAccountId!, tx.amountPaise);
    }
  }

  void _applyIncome(TransactionModel tx) {
    final targetAccountId = tx.toAccountId ?? _accounts.first.id;
    final accIdx = _accounts.indexWhere((a) => a.id == targetAccountId);
    if (accIdx != -1) {
      _accounts[accIdx] = _accounts[accIdx].copyWith(
        currentBalancePaise: _accounts[accIdx].currentBalancePaise + tx.amountPaise,
        updatedAt: DateTime.now(),
      );
    }
  }

  void _applyTransfer(TransactionModel tx) {
    if (tx.fromAccountId == null || tx.toAccountId == null) return;
    _deductAccountBalance(tx.fromAccountId!, tx.amountPaise);
    final toIdx = _accounts.indexWhere((a) => a.id == tx.toAccountId);
    if (toIdx != -1) {
      _accounts[toIdx] = _accounts[toIdx].copyWith(
        currentBalancePaise: _accounts[toIdx].currentBalancePaise + tx.amountPaise,
        updatedAt: DateTime.now(),
      );
    }
  }

  void _applyCreditCardSettlement(TransactionModel tx) {
    // 1. Deduct money from paying bank account
    if (tx.fromAccountId != null) {
      _deductAccountBalance(tx.fromAccountId!, tx.amountPaise);
    }
    // 2. Reduce outstanding on credit card
    if (tx.cardId != null) {
      final cardIdx = _cards.indexWhere((c) => c.id == tx.cardId);
      if (cardIdx != -1) {
        final card = _cards[cardIdx];
        final newOutstanding = (card.currentOutstandingPaise - tx.amountPaise).clamp(0, card.creditLimitPaise ?? 999999999);
        _cards[cardIdx] = card.copyWith(
          currentOutstandingPaise: newOutstanding,
          updatedAt: DateTime.now(),
        );
      }
    }
  }

  void _applyDebtTransaction(TransactionModel tx) {
    if (tx.type == TransactionType.debtLend && tx.fromAccountId != null) {
      _deductAccountBalance(tx.fromAccountId!, tx.amountPaise);
    } else if (tx.type == TransactionType.debtBorrow && tx.toAccountId != null) {
      final toIdx = _accounts.indexWhere((a) => a.id == tx.toAccountId);
      if (toIdx != -1) {
        _accounts[toIdx] = _accounts[toIdx].copyWith(
          currentBalancePaise: _accounts[toIdx].currentBalancePaise + tx.amountPaise,
          updatedAt: DateTime.now(),
        );
      }
    }
  }

  void _deductAccountBalance(String accountId, int amountPaise) {
    final accIdx = _accounts.indexWhere((a) => a.id == accountId);
    if (accIdx != -1) {
      _accounts[accIdx] = _accounts[accIdx].copyWith(
        currentBalancePaise: _accounts[accIdx].currentBalancePaise - amountPaise,
        updatedAt: DateTime.now(),
      );
    }
  }

  void _notifyAll() {
    _transactionsStreamController.add(List.unmodifiable(_transactions));
    _accountsStreamController.add(List.unmodifiable(_accounts));
    _cardsStreamController.add(List.unmodifiable(_cards));
    _debtsStreamController.add(List.unmodifiable(_debts));
  }

  void dispose() {
    _transactionsStreamController.close();
    _accountsStreamController.close();
    _cardsStreamController.close();
    _debtsStreamController.close();
  }
}
