import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Section header with title + optional action link.
/// Mirrors src/components/SectionHeader.tsx.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.action,
    this.onAction,
    this.icon,
    this.iconColor,
    this.titleColor,
  });

  final String title;
  final String? action;
  final VoidCallback? onAction;
  final IconData? icon;
  final Color? iconColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 17, color: iconColor ?? AppColors.primary),
            const SizedBox(width: 6),
          ],
          Expanded(
            child: Text(
              title,
              style: AppTheme.display(
                size: 17,
                weight: FontWeight.w600,
                color: titleColor ?? AppColors.foreground,
              ),
            ),
          ),
          if (action != null)
            GestureDetector(
              onTap: onAction,
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    action!,
                    style: AppTheme.sans(size: 12, weight: FontWeight.w500, color: AppColors.mutedForeground),
                  ),
                  const SizedBox(width: 2),
                  const Icon(LucideIcons.chevronRight, size: 14, color: AppColors.mutedForeground),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// A variant section title with a small vertical sage bar on the left,
/// used on the Profile page ("今日任务", "更多服务").
class BarSectionTitle extends StatelessWidget {
  const BarSectionTitle({
    super.key,
    required this.title,
    this.trailing,
    this.titleSize = 13.5,
  });

  final String title;
  final Widget? trailing;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 14,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: AppTheme.sans(size: titleSize, weight: FontWeight.w600, color: AppColors.foreground),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}
