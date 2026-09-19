import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_icons.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Card showing the user's invite code with a copy button (gold gradient).
/// Mirrors src/components/InviteCodeCard.tsx.
class InviteCodeCard extends StatelessWidget {
  const InviteCodeCard({
    super.key,
    required this.code,
    required this.copied,
    this.onCopy,
  });

  final String code;
  final bool copied;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.fromHex('#fdf8ec'),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: AppColors.fromHex('#c9a96a'),
            width: 1,
            style: BorderStyle.solid), // dashed approximated with solid
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '我的邀请码',
                  style: AppTheme.sans(
                    size: 11,
                    color: AppColors.mutedForeground,
                  ),
                ),
                const SizedBox(height: 4), // mt-1
                Text(
                  code,
                  style: AppTheme.display(
                    size: 22,
                    weight: FontWeight.w600,
                    color: AppColors.fromHex('#8a6d34'),
                    letterSpacing: 0.14 * 22, // letterSpacing 0.14em
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12), // gap-3
          PressableScale(
            onTap: onCopy,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: AppGradients.gold,
                borderRadius: BorderRadius.circular(999),
                boxShadow: AppShadows.soft,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    AppIcons.resolve(copied ? 'CheckIcon' : 'CopyIcon'),
                    size: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 6), // gap-1.5
                  Text(
                    copied ? '已复制' : '复制',
                    style: AppTheme.sans(
                      size: 12,
                      weight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
