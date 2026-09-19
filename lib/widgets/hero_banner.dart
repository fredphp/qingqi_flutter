import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_theme.dart';

/// Hero banner shown at the top of the Home page (dark forest gradient
/// with a glass "AI" badge, pill, title/subtitle, and an embedded child
/// slot — typically a [SearchField] of the `glass` variant).
/// Mirrors src/components/HeroBanner.tsx.
class HeroBanner extends StatelessWidget {
  const HeroBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.child,
  });

  final String title;
  final String subtitle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 64),
      decoration: const BoxDecoration(
        gradient: AppGradients.forest,
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // ---- decorative radial blobs ----
          Positioned(
            right: -40,
            top: -10,
            child: _RadialBlob(
              size: 200,
              color: AppColors.accent.withValues(alpha: 0.22),
            ),
          ),
          Positioned(
            left: -30,
            bottom: 40,
            child: _RadialBlob(
              size: 200,
              color: AppColors.secondary.withValues(alpha: 0.20),
            ),
          ),

          // ---- foreground content ----
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // top row: AI glass badge
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        transform: GradientRotation(140 * 3.14159265 / 180),
                        colors: [
                          Color(0x80FFFFFF), // rgba(255,255,255,0.5)
                          Color(0x24FFFFFF), // rgba(255,255,255,0.14)
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0x6BFFFFFF)),
                    ),
                    child: Text(
                      'AI',
                      style: AppTheme.display(
                        size: 15,
                        weight: FontWeight.w600,
                        color: const Color(0xE6FFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0x1AFFFFFF), // rgba(255,255,255,0.1)
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0x40FFFFFF)), // rgba(255,255,255,0.25)
                ),
                child: Text(
                  '轻启AI · 自然科技',
                  style: AppTheme.sans(
                    size: 11,
                    weight: FontWeight.w500,
                    color: const Color(0xD9FFFFFF), // rgba(255,255,255,0.85)
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: AppTheme.display(
                  size: 26,
                  weight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 240),
                child: Text(
                  subtitle,
                  style: AppTheme.sans(
                    size: 13,
                    color: const Color(0xBFFFFFFF), // rgba(255,255,255,0.75)
                    height: 1.5,
                  ),
                ),
              ),
              if (child != null) ...[
                const SizedBox(height: 16),
                child!,
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _RadialBlob extends StatelessWidget {
  const _RadialBlob({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}
