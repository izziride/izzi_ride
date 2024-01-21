import 'package:flutter/services.dart';
class NumberFormatter extends TextInputFormatter {
  final int maxLength;

  NumberFormatter({this.maxLength = 14});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final unformatted = text.replaceAll(RegExp(r'[^0-9]'), '');

    String formatted = '';
    var index = 0;

    for (var i = 0; i < unformatted.length; i++) {
      if (i == 0) {
        formatted += '(';
      } else if (i == 3) {
        formatted += ') ';
      } else if (i == 6) {
        formatted += ' - ';
      }

      formatted += unformatted[i];

      if (i >= 9) {
        break;
      }

      index = formatted.length;
    }

    if (formatted.length >= maxLength) {
      formatted = formatted.substring(0, maxLength);
      index = maxLength;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: index),
    );
  }
}