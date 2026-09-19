import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Row of 4 quick-entry buttons used at the top of the Home page.
/// Mirrors src/components/QuickToolRow.tsx.
class QuickToolRow extends StatelessWidget {
  const QuickToolRow({
    super.key,
    required this.entries,
    this.onTap,
  });

  final List<QuickEntry> entries;
  final void Function(QuickEntry entry)? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < entries.length; i++) ...[
          if (i > 0) const SizedBox(width: 12),
          Expanded(
            child: _QuickButton(entry: entries[i], onTap: () => onTap?.call(entries[i])),
          ),
        ],
      ],
    );
  }
}

class _QuickButton extends StatelessWidget {
  const _QuickButton({required this.entry, required this.onTap});

  final QuickEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
              boxShadow: AppShadows.soft,
            ),
            child: Icon(
              AppIcons.resolve(entry.icon),
              size: 22,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            entry.label,
            style: AppTheme.sans(size: 12, weight: FontWeight.w500, color: AppColors.foreground),
          ),
        ],
      ),
    );
  }
}
