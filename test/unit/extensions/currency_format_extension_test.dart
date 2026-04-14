import 'package:flutter_test/flutter_test.dart';

import 'package:saa_mobile/core/extensions/currency_format_extension.dart';

void main() {
  group('CurrencyFormatExtension', () {
    group('formatCurrency with locale vi', () {
      test('formats 7000000 as 7.000.000 VNĐ', () {
        expect(7000000.formatCurrency('vi'), '7.000.000 VNĐ');
      });

      test('formats 15000000 as 15.000.000 VNĐ', () {
        expect(15000000.formatCurrency('vi'), '15.000.000 VNĐ');
      });

      test('formats 5000000 as 5.000.000 VNĐ', () {
        expect(5000000.formatCurrency('vi'), '5.000.000 VNĐ');
      });

      test('formats 0 as 0 VNĐ', () {
        expect(0.formatCurrency('vi'), '0 VNĐ');
      });

      test('formats 10000000 as 10.000.000 VNĐ', () {
        expect(10000000.formatCurrency('vi'), '10.000.000 VNĐ');
      });
    });

    group('formatCurrency with locale en', () {
      test('formats 7000000 as 7,000,000 VND', () {
        expect(7000000.formatCurrency('en'), '7,000,000 VND');
      });

      test('formats 15000000 as 15,000,000 VND', () {
        expect(15000000.formatCurrency('en'), '15,000,000 VND');
      });

      test('formats 0 as 0 VND', () {
        expect(0.formatCurrency('en'), '0 VND');
      });
    });

    group('formatCurrency defaults to vi for unknown locale', () {
      test('unknown locale uses vi format', () {
        expect(7000000.formatCurrency('ja'), '7.000.000 VNĐ');
      });
    });
  });
}
