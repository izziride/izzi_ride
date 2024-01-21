import 'dart:ui';

Color stringToColor(String text) {
  final hashCode = text.hashCode & 0xFFFFFF;
  return Color(hashCode).withOpacity(1.0);
}