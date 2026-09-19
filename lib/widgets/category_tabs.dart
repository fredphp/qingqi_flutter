import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';

/// Horizontal scrollable pill tabs used on the Tools page.
/// Mirrors src/components/CategoryTabs.tsx.
class CategoryTabs extends StatelessWidget {
  const CategoryTabs({
    super.key,
    required this.categories,
    required this.active,
    this.onChanged,
  });

  final List<Category> categories;
  final String active;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final c = categories[i];
          final isActive = c.id == active;
          return _PillTab(
            label: c.label,
            emoji: c.emoji,
            active: isActive,
            onTap: () => onChanged?.call(c.id),
          );
        },
      ),
    );
  }
}

class _PillTab extends StatelessWidget {
  const _PillTab({
    required this.label,
    required this.emoji,
    required this.active,
    required this.onTap,
  });

  final String label;
  final String emoji;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: active
              ? AppColors.primary
              : const Color(0x8CFFFFFF), // rgba(255,255,255,0.55)
          borderRadius: BorderRadius.circular(999),
          border: active
              ? null
              : Border.all(color: const Color(0x1F1F4B39)), // rgba(31,75,57,0.12)
          boxShadow: active
              ? [
                  const BoxShadow(
                    color: Color(0x471F4B39), // rgba(31,75,57,0.28)
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (emoji.isNotEmpty) ...[
              Text(emoji, style: const TextStyle(fontSize: 12, height: 1)),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: AppTheme.sans(
                size: 12.5,
                weight: FontWeight.w600,
                color: active ? Colors.white : AppColors.midSage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
