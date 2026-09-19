import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../router.dart';

/// Sticky app top bar with optional back / more buttons.
/// Mirrors src/components/TopBar.tsx.
class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    this.title = '',
    this.subtitle = '',
    this.showBack = false,
    this.showMore = false,
    this.backTo = AppRoutes.home,
    this.onMore,
    this.transparent = false,
  });

  final String title;
  final String subtitle;
  final bool showBack;
  final bool showMore;
  final String backTo;
  final VoidCallback? onMore;
  final bool transparent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: transparent
          ? null
          : BoxDecoration(
              color: AppColors.background.withValues(alpha: 0.85),
              border: const Border(
                bottom: BorderSide(color: Color(0x80E8E2D5), width: 1),
              ),
            ),
      child: Row(
        children: [
          if (showBack)
            _CircleButton(
              icon: LucideIcons.chevronLeft,
              onTap: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  AppRoutes.go(context, backTo);
                }
              },
            ),
          if (showBack) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title.isNotEmpty)
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.display(
                      size: 18,
                      weight: FontWeight.w600,
                      color: AppColors.foreground,
                    ),
                  ),
                if (subtitle.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.sans(size: 12, color: AppColors.mutedForeground),
                    ),
                  ),
              ],
            ),
          ),
          if (showMore)
            _CircleButton(icon: LucideIcons.moreHorizontal, onTap: onMore ?? () {}),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.card,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18, color: AppColors.foreground),
      ),
    );
  }
}
