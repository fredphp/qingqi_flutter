import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';

/// Slider for selecting a compression quality percentage, with a colored
/// gradient track and a tooltip bubble above the thumb.
/// Mirrors src/components/QualitySlider.tsx.
class QualitySlider extends StatelessWidget {
  const QualitySlider({
    super.key,
    required this.value,
    this.onChanged,
  });

  final int value;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0, 100).toDouble();
    return Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '压缩质量',
                style: AppTheme.sans(
                  size: 13,
                  weight: FontWeight.w500,
                  color: AppColors.foreground,
                ),
              ),
              Text(
                '$value%',
                style: AppTheme.display(
                  size: 14,
                  weight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Slider area
          LayoutBuilder(
            builder: (context, constraints) {
              final trackWidth = constraints.maxWidth;
              final thumbX = (v / 100) * trackWidth;
              return SizedBox(
                height: 40,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Bubble tooltip
                    Positioned(
                      left: thumbX,
                      top: -6,
                      child: FractionalTranslation(
                        translation: const Offset(-0.5, 0),
                        child: _Bubble(value: value),
                      ),
                    ),
                    // Track (gradient)
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 17,
                      child: Container(
                        height: 6, // h-1.5
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: const [
                              Color(0xFFE05C4B),
                              Color(0xFFE8A847),
                              Color(0xFF4CAF7D),
                              Color(0xFFE8E2D5),
                              Color(0xFFE8E2D5),
                            ],
                            stops: [
                              0.0,
                              0.4,
                              v / 100,
                              v / 100,
                              1.0,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Thumb
                    Positioned(
                      left: thumbX,
                      top: 14,
                      child: FractionalTranslation(
                        translation: const Offset(-0.5, 0),
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF7D),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x334CAF7D),
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Drag detector
                    Positioned.fill(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTapDown: onChanged == null
                            ? null
                            : (d) {
                                final dx = d.localPosition.dx
                                    .clamp(0.0, trackWidth);
                                onChanged!((dx / trackWidth * 100)
                                    .round()
                                    .clamp(0, 100));
                              },
                        onPanUpdate: onChanged == null
                            ? null
                            : (d) {
                                final dx = d.localPosition.dx
                                    .clamp(0.0, trackWidth);
                                onChanged!((dx / trackWidth * 100)
                                    .round()
                                    .clamp(0, 100));
                              },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '更小体积',
                style: AppTheme.sans(
                    size: 11, color: AppColors.mutedForeground),
              ),
              Text(
                '更高画质',
                style: AppTheme.sans(
                    size: 11, color: AppColors.mutedForeground),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.value});
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF7D),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            '$value%',
            style: AppTheme.sans(
              size: 11,
              weight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        CustomPaint(
          size: const Size(8, 4),
          painter: const _TrianglePainter(color: Color(0xFF4CAF7D)),
        ),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  const _TrianglePainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _TrianglePainter old) => old.color != color;
}
