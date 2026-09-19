import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Small coin-balance pill shown in the TopBar of the Home page.
/// Mirrors src/components/CoinBadge.tsx.
class CoinBadge extends StatelessWidget {
  const CoinBadge({
    super.key,
    required this.amount,
    this.onTap,
  });

  final String amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.goldSoft,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0x66C9A96A)), // accent/40
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(LucideIcons.coins, size: 14, color: AppColors.goldDark),
            const SizedBox(width: 6),
            Text(
              amount,
              style: AppTheme.display(
                size: 13,
                weight: FontWeight.w600,
                color: AppColors.goldBrown,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              LucideIcons.chevronRight,
              size: 13,
              color: AppColors.goldDark,
            ),
          ],
        ),
      ),
    );
  }
}
