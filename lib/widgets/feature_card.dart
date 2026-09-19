import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Featured tool card with image + overlay + CTA used on Home page.
/// Mirrors src/components/FeatureCard.tsx.
class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.card,
    this.badge = '',
    this.onUse,
  });

  final FeaturedCard card;
  final String badge;
  final VoidCallback? onUse;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onUse,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.soft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 128,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  NetImage(card.image, fit: BoxFit.cover),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0x0D173A2C), // rgba(23,58,44,0.05)
                            const Color(0x8C173A2C), // rgba(23,58,44,0.55)
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (badge.isNotEmpty)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0x33FFFFFF), // rgba(255,255,255,0.2)
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: const Color(0x4DFFFFFF)), // rgba(255,255,255,0.3)
                            ),
                            child: Text(
                              badge,
                              style: AppTheme.sans(
                                size: 10,
                                weight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    card.title,
                    style: AppTheme.display(
                      size: 15,
                      weight: FontWeight.w600,
                      color: AppColors.foreground,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.subtitle,
                    style: AppTheme.sans(
                      size: 12,
                      color: AppColors.mutedForeground,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.mintSoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '立即使用',
                          style: AppTheme.sans(
                            size: 12,
                            weight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          LucideIcons.chevronRight,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      ],
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
