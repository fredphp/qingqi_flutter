import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Asset stat grid (coin / coupon / rights / orders) shown on the Profile page.
/// Mirrors src/components/AssetStatGrid.tsx.
class AssetStatGrid extends StatelessWidget {
  const AssetStatGrid({
    super.key,
    required this.stats,
    this.onTap,
  });

  final List<AssetStat> stats;
  final void Function(AssetStat stat)? onTap;

  static const Map<String, _Tint> _tints = {
    'coin': _Tint(bg: Color(0x21C9A96A), icon: Color(0xFFC9A96A)), // rgba(201,169,106,0.13)
    'coupon': _Tint(bg: Color(0x171F4B39), icon: Color(0xFF1F4B39)), // rgba(31,75,57,0.09)
    'rights': _Tint(bg: Color(0x21C9A96A), icon: Color(0xFFD4A84B)), // rgba(201,169,106,0.13)
    'orders': _Tint(bg: Color(0x171F4B39), icon: Color(0xFF1F4B39)), // rgba(31,75,57,0.09)
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (int i = 0; i < stats.length; i++) ...[
              if (i > 0)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 1,
                  color: AppColors.dividerMuted, // #ece7db
                ),
              Expanded(child: _StatCell(stat: stats[i], onTap: () => onTap?.call(stats[i]))),
            ],
          ],
        ),
      ),
    );
  }
}

class _Tint {
  const _Tint({required this.bg, required this.icon});
  final Color bg;
  final Color icon;
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.stat, required this.onTap});
  final AssetStat stat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tint = AssetStatGrid._tints[stat.id] ??
        const _Tint(bg: Color(0x171F4B39), icon: Color(0xFF1F4B39));
    return PressableScale(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tint.bg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(AppIcons.resolve(stat.icon), size: 18, color: tint.icon),
            ),
            const SizedBox(height: 6),
            Text(
              stat.value,
              style: AppTheme.display(
                size: 16,
                weight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              stat.label,
              style: AppTheme.sans(size: 10.5, color: AppColors.mutedForeground),
            ),
          ],
        ),
      ),
    );
  }
}
