import 'package:intl/intl.dart';

enum CurrencyLocale {
  inr, // Indian Rupee (Lakh/Crore grouping)
  usd, // US Dollar (Thousands grouping)
}

/// Zero-floating-point currency formatting engine.
/// All internal computations use exact 64-bit integer paise.
abstract class CurrencyFormatter {
  static const int paisePerUnit = 100;

  /// Converts a major currency string (e.g. "124.50") into exact integer paise (12450)
  static int parseToPaise(String input) {
    final cleaned = input.replaceAll(RegExp(r'[^0-9.-]'), '').trim();
    if (cleaned.isEmpty) return 0;

    final isNegative = cleaned.startsWith('-');
    final absoluteStr = isNegative ? cleaned.substring(1) : cleaned;

    final parts = absoluteStr.split('.');
    final units = int.tryParse(parts[0]) ?? 0;
    int paise = 0;

    if (parts.length > 1) {
      final decimalPart = parts[1].padRight(2, '0').substring(0, 2);
      paise = int.tryParse(decimalPart) ?? 0;
    }

    final totalPaise = (units * paisePerUnit) + paise;
    return isNegative ? -totalPaise : totalPaise;
  }

  /// Formats exact integer paise into standard human-readable currency with prefix
  static String formatPaise(
    int paise, {
    String symbol = '₹',
    CurrencyLocale locale = CurrencyLocale.inr,
    bool showSign = false,
    bool showDecimals = true,
  }) {
    final isNegative = paise < 0;
    final absPaise = paise.abs();

    final majorUnits = absPaise ~/ paisePerUnit;
    final minorUnits = absPaise % paisePerUnit;

    String formattedMajor;
    if (locale == CurrencyLocale.inr) {
      // Indian numbering system: 1,00,000
      formattedMajor = _formatIndianGrouping(majorUnits);
    } else {
      // Western numbering system: 100,000
      formattedMajor = NumberFormat('#,##0').format(majorUnits);
    }

    final decimals = showDecimals ? '.${minorUnits.toString().padLeft(2, '0')}' : '';
    final signStr = isNegative ? '-' : (showSign ? '+' : '');

    return '$signStr$symbol$formattedMajor$decimals';
  }

  /// Indian Lakh/Crore grouping algorithm
  static String _formatIndianGrouping(int number) {
    final str = number.toString();
    if (str.length <= 3) return str;

    final lastThree = str.substring(str.length - 3);
    var remaining = str.substring(0, str.length - 3);

    final List<String> chunks = [];
    while (remaining.isNotEmpty) {
      if (remaining.length <= 2) {
        chunks.insert(0, remaining);
        break;
      } else {
        chunks.insert(0, remaining.substring(remaining.length - 2));
        remaining = remaining.substring(0, remaining.length - 2);
      }
    }

    return '${chunks.join(',')},$lastThree';
  }
}
