import 'package:flutter/material.dart';
import 'dart:math' as math;

class LightBulbPainter extends CustomPainter {
  final bool isOn;
  LightBulbPainter({required this.isOn});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final center = Offset(size.width / 2, size.height / 2);

    _drawStars(canvas, size, paint);
    _drawWire(canvas, center, paint);
    _drawBulbTop(canvas, center, paint);
    _drawBulbBody(canvas, center, paint);
  }

  void _drawStars(Canvas canvas, Size size, Paint paint) {
    paint.color = isOn ? const Color(0xFFD4A574) : const Color(0xFF555555);
    paint.style = PaintingStyle.fill;

    final random = math.Random(42);
    for (int i = 0; i < 100; i++) {
      double x = random.nextDouble() * size.width;
      double y = random.nextDouble() * size.height;
      double distance =
          (Offset(x, y) - Offset(size.width / 2, size.height / 2)).distance;
      if (distance > 120) {
        canvas.drawCircle(Offset(x, y), 3, paint);
      }
    }
  }

  void _drawWire(Canvas canvas, Offset center, Paint paint) {
    paint.color = Colors.black;
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(center.dx, 0),
      Offset(center.dx, center.dy - 80),
      paint,
    );
  }

  void _drawBulbTop(Canvas canvas, Offset center, Paint paint) {
    paint.color = const Color(0xFF8B6B47);
    paint.style = PaintingStyle.fill;

    final topRect = RRect.fromRectAndCorners(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy - 65),
        width: 25,
        height: 30,
      ),
      topLeft: const Radius.circular(4),
      topRight: const Radius.circular(4),
    );

    canvas.drawRRect(topRect, paint);
  }

  void _drawBulbBody(Canvas canvas, Offset center, Paint paint) {
    final mainColor = isOn ? const Color(0xFFFFD700) : const Color(0xFF555555);
    final accentColor = isOn
        ? const Color(0xFFFFA500)
        : const Color(0xFF333333);

    paint.shader = RadialGradient(
      colors: [mainColor, accentColor],
      stops: const [0.0, 0.6],
    ).createShader(Rect.fromCircle(center: center, radius: 60));

    paint.style = PaintingStyle.fill;
    canvas.drawCircle(center, 60, paint);

    if (isOn) {
      paint.shader = RadialGradient(
        colors: [const Color(0x80FFFFFF), Colors.transparent],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: 30));
      canvas.drawCircle(center, 30, paint);
    }
  }

  @override
  bool shouldRepaint(covariant LightBulbPainter oldDelegate) =>
      oldDelegate.isOn != isOn;
}
