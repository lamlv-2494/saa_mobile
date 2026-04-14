extension CurrencyFormatExtension on int {
  String formatCurrency(String locale) {
    final absValue = abs();
    final digits = absValue.toString();
    final buffer = StringBuffer();
    final separator = locale == 'en' ? ',' : '.';
    final currency = locale == 'en' ? 'VND' : 'VNĐ';

    for (var i = 0; i < digits.length; i++) {
      final remaining = digits.length - i;
      if (i > 0 && remaining % 3 == 0) {
        buffer.write(separator);
      }
      buffer.write(digits[i]);
    }

    return '$buffer $currency';
  }
}
