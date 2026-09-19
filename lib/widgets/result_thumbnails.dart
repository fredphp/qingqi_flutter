import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import 'common.dart';

/// Horizontal scrollable list of result thumbnails with an active border.
/// Mirrors src/components/ResultThumbnails.tsx.
class ResultThumbnails extends StatelessWidget {
  const ResultThumbnails({
    super.key,
    required this.thumbs,
    required this.activeIndex,
    this.onChanged,
  });

  final List<ResultThumb> thumbs;
  final int activeIndex;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // 96 thumb + 4 pb-1
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 4),
        itemCount: thumbs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12), // gap-3
        itemBuilder: (context, i) {
          final isActive = i == activeIndex;
          return PressableScale(
            onTap: onChanged == null ? null : () => onChanged!(i),
            child: Container(
              width: 76,
              height: 96,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                boxShadow: AppShadows.soft,
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isActive
                      ? AppColors.fromHex('#c9a96a')
                      : AppColors.fromHex('#e8e2d5'),
                  width: 2,
                ),
              ),
              child: NetImage(thumbs[i].url,
                  fit: BoxFit.cover, width: 76, height: 96),
            ),
          );
        },
      ),
    );
  }
}
