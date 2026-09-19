import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Compact VIP promo card with forest gradient background, gold crown overlay,
/// title/subtitle, and a gold CTA button.
/// Mirrors src/components/VipCard.tsx.
class VipCard extends StatelessWidget {
  const VipCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.action,
    this.onOpen,
    this.compact = false,
  });

  final String title;
  final String subtitle;
  final String action;
  final VoidCallback? onOpen;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final padding = compact ? 16.0 : 20.0;
    final bigCrownSize = compact ? 72.0 : 96.0;
    return Container(
      padding: EdgeInsets.all(padding),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: AppGradients.forest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: AppColors.accent.withValues(alpha: 0.42), width: 1),
        boxShadow: AppShadows.custom,
      ),
      child: Stack(
        children: [
          // Radial overlay (gold glow at top-right)
          Positioned(
            top: 0,
            right: 0,
            child: CustomPaint(
              size: Size(bigCrownSize * 1.6, bigCrownSize * 1.6),
              painter: _RadialGlowPainter(
                color: AppColors.accent.withValues(alpha: 0.34),
                radius: bigCrownSize * 0.8,
              ),
            ),
          ),
          // Big crown watermark
          Positioned(
            top: -12,
            right: -8,
            child: Icon(
              LucideIcons.crown,
              size: bigCrownSize,
              color: AppColors.accent.withValues(alpha: 0.22),
            ),
          ),
          // Foreground content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.crown,
                      size: 18, color: AppColors.goldLight),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: AppTheme.display(
                      size: 16,
                      weight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4), // mt-1
              Text(
                subtitle,
                style: AppTheme.sans(
                  size: 12.5,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
              const SizedBox(height: 14), // mt-3.5
              PressableScale(
                onTap: onOpen,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: AppGradients.gold,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: AppShadows.soft,
                  ),
                  child: Text(
                    action,
                    style: AppTheme.sans(
                      size: 12.5,
                      weight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RadialGlowPainter extends CustomPainter {
  _RadialGlowPainter({required this.color, required this.radius});
  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    // Anchor the glow at (88%, 12%) within this painted box.
    final center = Offset(size.width * 0.88, size.height * 0.12);
    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, color.withValues(alpha: 0.0)],
        stops: const [0.0, 0.52],
      ).createShader(rect);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _RadialGlowPainter old) =>
      old.color != color || old.radius != radius;
}
