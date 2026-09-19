import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Picker for ID-photo background colors: a row of round swatches with a
/// check icon and a label. Mirrors src/components/ColorSwatchPicker.tsx.
class ColorSwatchPicker extends StatelessWidget {
  const ColorSwatchPicker({
    super.key,
    required this.colors,
    required this.activeId,
    this.onChanged,
  });

  final List<BgColorOption> colors;
  final String activeId;
  final ValueChanged<String>? onChanged;

  static final Color _whiteSwatch = AppColors.fromHex('#f7f7f4');

  @override
  Widget build(BuildContext context) {
    return Row(
      children: colors.map((c) {
        final isActive = c.id == activeId;
        final isWhite = c.value == _whiteSwatch;
        return PressableScale(
          onTap: onChanged == null ? null : () => onChanged!(c.id),
          child: Container(
            margin: EdgeInsets.only(
                right: c.id == colors.last.id ? 0 : 14), // gap-3.5
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 36, // h-9 w-9
                  decoration: BoxDecoration(
                    color: c.value,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive
                          ? AppColors.fromHex('#1f4b39')
                          : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: isActive
                        ? [
                            const BoxShadow(
                              color: Color(0x241F4B39), // rgba(31,75,57,0.14)
                              blurRadius: 0,
                              spreadRadius: 3,
                              offset: Offset.zero,
                            ),
                          ]
                        : [
                            const BoxShadow(
                              color: Color(0x1F1F4B39), // rgba(31,75,57,0.12)
                              blurRadius: 3,
                              offset: Offset(0, 1),
                            ),
                          ],
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    AppIcons.resolve('CheckIcon'),
                    size: 15,
                    color: isWhite
                        ? AppColors.fromHex('#1f4b39')
                        : Colors.white,
                  ),
                ),
                const SizedBox(height: 4), // gap 4
                Text(
                  c.label,
                  style: AppTheme.sans(
                    size: 11,
                    weight: isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isActive
                        ? AppColors.fromHex('#1f4b39')
                        : AppColors.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
