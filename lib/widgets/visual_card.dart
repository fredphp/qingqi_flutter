import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// A wide promotional card with a left content area and a right image that
/// blends into the card via a left-edge gradient overlay.
/// Mirrors src/components/VisualCard.tsx.
class VisualCard extends StatelessWidget {
  const VisualCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.imageUrl,
    this.onOpen,
  });

  final String title;
  final String subtitle;
  final String tag;
  final String imageUrl;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left content
            Expanded(
              child: GestureDetector(
                onTap: onOpen,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(16), // p-4
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tag pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.fromHex('#f4ecd8'),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          tag,
                          style: AppTheme.sans(
                            size: 10,
                            weight: FontWeight.w600,
                            color: AppColors.fromHex('#8a6d34'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8), // mt-2
                      Text(
                        title,
                        style: AppTheme.display(
                          size: 16,
                          weight: FontWeight.w600,
                          color: AppColors.foreground,
                        ),
                      ),
                      const SizedBox(height: 4), // mt-1
                      Text(
                        subtitle,
                        style: AppTheme.sans(
                          size: 12,
                          height: 1.3, // leading-snug
                          color: AppColors.mutedForeground,
                        ),
                      ),
                      const SizedBox(height: 8), // mt-2
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '立即体验',
                            style: AppTheme.sans(
                              size: 12,
                              weight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(LucideIcons.arrowRight,
                              size: 14, color: AppColors.primary),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Right image
            SizedBox(
              width: 120,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  NetImage(imageUrl, fit: BoxFit.cover),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.card.withValues(alpha: 0.92),
                            AppColors.card.withValues(alpha: 0.0),
                          ],
                          stops: const [0.0, 0.6],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
