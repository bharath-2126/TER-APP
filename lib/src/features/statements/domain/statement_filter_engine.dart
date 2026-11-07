import 'package:flutter/foundation.dart';

enum StatementTxType {
  all,
  income,
  expense,
  transfer,
  debtLend,
  debtBorrow,
  debtRepayment,
}

@immutable
class StatementFilterCriteria {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? personId;
  final String? categoryId;
  final String? accountId;
  final String? cardId;
  final StatementTxType type;
  final int? minAmountPaise;
  final int? maxAmountPaise;

  const StatementFilterCriteria({
    this.startDate,
    this.endDate,
    this.personId,
    this.categoryId,
    this.accountId,
    this.cardId,
    this.type = StatementTxType.all,
    this.minAmountPaise,
    this.maxAmountPaise,
  });

  bool get hasActiveFilters =>
      startDate != null ||
      endDate != null ||
      personId != null ||
      categoryId != null ||
      accountId != null ||
      cardId != null ||
      type != StatementTxType.all ||
      minAmountPaise != null ||
      maxAmountPaise != null;
}

@immutable
class StatementEntry {
  final String transactionId;
  final DateTime timestamp;
  final String title;
  final String? categoryName;
  final String? accountOrCardName;
  final String? personName;
  final String typeName;
  final int amountPaise;
  final bool isInflow;
  final int runningBalancePaise;

  const StatementEntry({
    required this.transactionId,
    required this.timestamp,
    required this.title,
    this.categoryName,
    this.accountOrCardName,
    this.personName,
    required this.typeName,
    required this.amountPaise,
    required this.isInflow,
    required this.runningBalancePaise,
  });
}

/// Pure domain engine to calculate running balances and generate RFC 4180 CSV representations.
abstract class StatementEngine {
  /// Converts statement entries into standard CSV format suitable for Excel, Google Sheets, or Numbers.
  static String generateCsv({
    required List<StatementEntry> entries,
    required int openingBalancePaise,
    required String currencySymbol,
  }) {
    final StringBuffer buffer = StringBuffer();

    // RFC 4180 header
    buffer.writeln('Date,Time,Transaction ID,Description,Type,Category,Account/Card,Person,Amount,Inflow/Outflow,Running Balance');

    for (final entry in entries) {
      final date = '${entry.timestamp.year}-${entry.timestamp.month.toString().padLeft(2, '0')}-${entry.timestamp.day.toString().padLeft(2, '0')}';
      final time = '${entry.timestamp.hour.toString().padLeft(2, '0')}:${entry.timestamp.minute.toString().padLeft(2, '0')}';
      final amount = (entry.amountPaise / 100).toStringAsFixed(2);
      final running = (entry.runningBalancePaise / 100).toStringAsFixed(2);
      final direction = entry.isInflow ? 'Inflow' : 'Outflow';

      final row = [
        date,
        time,
        _escapeCsv(entry.transactionId),
        _escapeCsv(entry.title),
        _escapeCsv(entry.typeName),
        _escapeCsv(entry.categoryName ?? '-'),
        _escapeCsv(entry.accountOrCardName ?? '-'),
        _escapeCsv(entry.personName ?? '-'),
        amount,
        direction,
        running,
      ];

      buffer.writeln(row.join(','));
    }

    return buffer.toString();
  }

  static String _escapeCsv(String field) {
    if (field.contains(',') || field.contains('"') || field.contains('\n')) {
      return '"${field.replaceAll('"', '""')}"';
    }
    return field;
  }
}
