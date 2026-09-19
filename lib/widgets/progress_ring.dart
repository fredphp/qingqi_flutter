import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Circular progress ring with a forest→mint→gold gradient arc.
/// Mirrors src/components/ProgressRing.tsx.
class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.value,
    this.size = 140,
    this.stroke = 9,
    this.child,
  });

  final int value; // 0..100
  final double size;
  final double stroke;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final double clamped = value.clamp(0, 100).toDouble();
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.square(size),
            painter: _RingPainter(value: clamped, stroke: stroke),
          ),
          if (child != null)
            child!
          else
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$value%',
                  style: AppTheme.display(
                    size: 28,
                    weight: FontWeight.w600,
                    color: AppColors.fromHex('#1f4b39'),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '处理进度',
                  style: AppTheme.sans(
                    size: 11,
                    color: AppColors.mutedForeground,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.value, required this.stroke});
  final double value;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - stroke) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background ring (full circle, #e8e2d5)
    final bgPaint = Paint()
      ..color = AppColors.fromHex('#e8e2d5')
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // Foreground arc (gradient, sweep based on value)
    final sweep = (value / 100) * 2 * math.pi;
    if (sweep <= 0) return;
    final startAngle = -math.pi / 2; // start at top

    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + 2 * math.pi,
      colors: const [
        Color(0xFF1F4B39),
        Color(0xFF7FA88A),
        Color(0xFFC9A96A),
      ],
      stops: const [0.0, 0.55, 1.0],
      transform: GradientRotation(startAngle),
    );
    final arcPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, startAngle, sweep, false, arcPaint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.value != value || old.stroke != stroke;
}
