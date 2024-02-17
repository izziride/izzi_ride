import 'package:flutter/material.dart';

class DottedFeeling extends CustomPainter {
  final Color color;
  final double dotSize;
  final double spacing;

  DottedFeeling({required this.color, required this.dotSize, required this.spacing});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final dotRadius = dotSize / 2;
    final dotSpacing = dotSize + spacing;
    final dotsCount = (size.width / dotSpacing).ceil();
    final lineWidth = dotSpacing * (dotsCount - 1) + dotSize;

    final startX = (size.width - lineWidth) / 2;
    final startY = size.height / 2;

    for (var i = 0; i < dotsCount; i++) {
      final dotCenter = Offset(startX + dotSpacing * i + dotRadius, startY);
      canvas.drawCircle(dotCenter, dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}