import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';

/// Wrapping grid of VIP benefit cards (icon + label + description).
/// Mirrors src/components/BenefitGrid.tsx.
///
/// Each cell grows to fill available width with a minimum of 140px and a
/// 12px gap between items (matches the CSS `flex-wrap` + `min-w-140` + `flex-1`
/// behaviour of the React source).
class BenefitGrid extends StatelessWidget {
  const BenefitGrid({super.key, required this.benefits, this.minWidth = 140, this.gap = 12});

  final List<VipBenefit> benefits;
  final double minWidth;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
        final cols = (maxW + gap) ~/ (minWidth + gap);
        final colCount = cols < 1 ? 1 : cols;
        final cellWidth = (maxW - gap * (colCount - 1)) / colCount;
        final rows = <Widget>[];
        for (int i = 0; i < benefits.length; i += colCount) {
          final slice = benefits.sublist(i, (i + colCount).clamp(0, benefits.length));
          rows.add(Padding(
            padding: EdgeInsets.only(top: i == 0 ? 0 : gap),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (int j = 0; j < slice.length; j++) ...[
                  if (j > 0) SizedBox(width: gap),
                  SizedBox(
                    width: cellWidth,
                    child: _BenefitCell(benefit: slice[j]),
                  ),
                ],
              ],
            ),
          ));
        }
        return Column(children: rows);
      },
    );
  }
}

class _BenefitCell extends StatelessWidget {
  const _BenefitCell({required this.benefit});
  final VipBenefit benefit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.goldSoft,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              AppIcons.resolve(benefit.icon),
              size: 18,
              color: AppColors.goldDark,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  benefit.label,
                  style: AppTheme.sans(
                    size: 13,
                    weight: FontWeight.w600,
                    color: AppColors.foreground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  benefit.description,
                  style: AppTheme.sans(size: 11, color: AppColors.mutedForeground),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
