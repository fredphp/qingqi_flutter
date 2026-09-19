import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Horizontal selector of spec options (e.g. ID photo sizes).
/// Mirrors src/components/SpecSelector.tsx.
class SpecSelector extends StatelessWidget {
  const SpecSelector({
    super.key,
    required this.specs,
    required this.activeId,
    this.onChanged,
  });

  final List<SpecOption> specs;
  final String activeId;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: specs.map((s) {
        final isActive = s.id == activeId;
        return Expanded(
          child: PressableScale(
            onTap: onChanged == null ? null : () => onChanged!(s.id),
            child: Container(
              margin: EdgeInsets.only(
                  right: s.id == specs.last.id ? 0 : 8), // gap-2
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 10), // px-2 py-2.5
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.fromHex('#e4efe7')
                    : AppColors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isActive
                      ? AppColors.fromHex('#1f4b39')
                      : AppColors.fromHex('#e8e2d5'),
                ),
              ),
              child: Text(
                s.label,
                style: AppTheme.sans(
                  size: 12.5,
                  weight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive
                      ? AppColors.fromHex('#1f4b39')
                      : AppColors.mutedForeground,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
