import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';

/// Card showing an ID-photo spec info table (title + wrap of label/value pairs).
/// Mirrors src/components/InfoSpecCard.tsx.
class InfoSpecCard extends StatelessWidget {
  const InfoSpecCard({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<IdPhotoSpecInfo> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.display(
              size: 14,
              weight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 24, // gap-x-6
            runSpacing: 12, // gap-y-3
            children: items.map((it) {
              return ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 118),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      it.label,
                      style: AppTheme.sans(
                        size: 11,
                        color: AppColors.mutedForeground,
                      ),
                    ),
                    const SizedBox(height: 2), // mt-0.5
                    Text(
                      it.value,
                      style: AppTheme.sans(
                        size: 13,
                        weight: FontWeight.w500,
                        color: AppColors.foreground,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
