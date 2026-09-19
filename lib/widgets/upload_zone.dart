import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Dashed upload zone with an icon, title, format hint, and optional
/// "已选择 1 张图片" pill. Whole zone is tappable.
/// Mirrors src/components/UploadZone.tsx.
class UploadZone extends StatelessWidget {
  const UploadZone({
    super.key,
    required this.title,
    required this.formats,
    this.hasFile = false,
    this.onTap,
  });

  final String title;
  final String formats;
  final bool hasFile;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            horizontal: 24, vertical: 36), // px-6 py-9
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.muted.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: AppColors.fromHex('#a6c0ab'),
              width: 1,
              style: BorderStyle.solid), // dashed approximated
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Decorative leaf blobs
            Positioned(
              top: -10,
              right: -10,
              child: Transform.rotate(
                angle: 20 * 3.14159265 / 180,
                child: Icon(
                  LucideIcons.leaf,
                  size: 60,
                  color: AppColors.primary.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              bottom: -14,
              left: -10,
              child: Transform.rotate(
                angle: -15 * 3.14159265 / 180,
                child: Icon(
                  LucideIcons.leaf,
                  size: 70,
                  color: AppColors.primary.withValues(alpha: 0.08),
                ),
              ),
            ),
            // Center column
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon box
                Container(
                  width: 56,
                  height: 56, // h-14 w-14
                  decoration: BoxDecoration(
                    color: AppColors.fromHex('#e4efe7'),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    LucideIcons.imagePlus,
                    size: 24,
                    color: AppColors.fromHex('#1f4b39'),
                  ),
                ),
                const SizedBox(height: 12), // mt-3
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTheme.display(
                    size: 15,
                    weight: FontWeight.w600,
                    color: AppColors.foreground,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formats,
                  textAlign: TextAlign.center,
                  style: AppTheme.sans(
                    size: 12,
                    color: AppColors.mutedForeground,
                  ),
                ),
                if (hasFile) ...[
                  const SizedBox(height: 12), // mt-3
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      '已选择 1 张图片',
                      style: AppTheme.sans(
                        size: 11,
                        weight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
