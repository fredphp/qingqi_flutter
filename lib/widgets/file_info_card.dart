import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Card displaying a selected file's thumbnail + name + size/resolution pills
/// plus a "更换" (replace) button. Mirrors src/components/FileInfoCard.tsx.
class FileInfoCard extends StatelessWidget {
  const FileInfoCard({
    super.key,
    required this.file,
    this.onRemove,
  });

  final FileInfo file;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24), // rounded-3xl
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          // Thumbnail
          Container(
            width: 64,
            height: 64,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.muted,
            ),
            child: NetImage(file.thumbnail,
                fit: BoxFit.cover, width: 64, height: 64),
          ),
          const SizedBox(width: 14), // gap-3.5
          // Name + pills
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  file.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.sans(
                    size: 13.5,
                    weight: FontWeight.w600,
                    color: AppColors.foreground,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _Pill(file.size),
                    const SizedBox(width: 6),
                    _Pill(file.resolution),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          // Replace button
          GestureDetector(
            onTap: onRemove,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                '更换',
                style: AppTheme.sans(
                  size: 11,
                  weight: FontWeight.w500,
                  color: AppColors.mutedForeground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.muted,
        borderRadius: BorderRadius.circular(6), // rounded-md
      ),
      child: Text(
        text,
        style: AppTheme.sans(
          size: 11,
          color: AppColors.mutedForeground,
        ),
      ),
    );
  }
}
