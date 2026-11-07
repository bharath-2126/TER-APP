import 'package:flutter_test/flutter_test.dart';
import 'package:tracker_every_rupee/src/core/formatting/currency_formatter.dart';

void main() {
  group('CurrencyFormatter Tests', () {
    test('Converts string input accurately into integer paise without float drift', () {
      expect(CurrencyFormatter.parseToPaise('124.50'), 12450);
      expect(CurrencyFormatter.parseToPaise('0.99'), 99);
      expect(CurrencyFormatter.parseToPaise('100'), 10000);
      expect(CurrencyFormatter.parseToPaise('100000.00'), 10000000);
    });

    test('Formats paise with Indian grouping (Lakh/Crore)', () {
      expect(
        CurrencyFormatter.formatPaise(10000000, symbol: '₹', locale: CurrencyLocale.inr),
        '₹1,00,000.00',
      );
      expect(
        CurrencyFormatter.formatPaise(2478700, symbol: '₹', locale: CurrencyLocale.inr),
        '₹24,787.00',
      );
    });

    test('Formats paise with Western grouping', () {
      expect(
        CurrencyFormatter.formatPaise(10000000, symbol: '\$', locale: CurrencyLocale.usd),
        '\$100,000.00',
      );
    });
  });
}
