import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';

/// Segmented pill tab switcher used inside preview/preview-style sheets.
/// Mirrors src/components/PreviewTabs.tsx.
class PreviewTabs extends StatelessWidget {
  const PreviewTabs({
    super.key,
    required this.tabs,
    required this.active,
    this.onChanged,
  });

  final List<String> tabs;
  final int active;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++) ...[
            if (i > 0) const SizedBox(width: 4),
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged?.call(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == active ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    tabs[i],
                    style: AppTheme.sans(
                      size: 13,
                      weight: i == active ? FontWeight.w600 : FontWeight.w500,
                      color: i == active ? Colors.white : AppColors.mutedForeground,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
