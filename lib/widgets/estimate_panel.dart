import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';

/// Three-cell panel showing estimated size / saving / quality values.
/// Mirrors src/components/EstimatePanel.tsx.
class EstimatePanel extends StatelessWidget {
  const EstimatePanel({
    super.key,
    required this.sizeValue,
    required this.saveValue,
    required this.qualityValue,
  });

  final String sizeValue;
  final String saveValue;
  final String qualityValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Expanded(
            child: _Cell(
              value: sizeValue,
              label: '预计大小',
              bg: AppColors.fromHex('#eef2ec'),
              valueColor: AppColors.primary,
              valueSize: 16,
            ),
          ),
          const SizedBox(width: 12), // gap-3
          Expanded(
            child: _Cell(
              value: saveValue,
              label: '预计节省',
              bg: AppColors.fromHex('#f4ecd8'),
              valueColor: AppColors.fromHex('#8a6d34'),
              valueSize: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _Cell(
              value: qualityValue,
              label: '质量',
              bg: null,
              borderColor: AppColors.border,
              valueColor: AppColors.foreground,
              valueSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.value,
    required this.label,
    required this.bg,
    required this.valueColor,
    required this.valueSize,
    this.borderColor,
  });

  final String value;
  final String label;
  final Color? bg;
  final Color valueColor;
  final double valueSize;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12), // p-3
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: borderColor != null ? Border.all(color: borderColor!) : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTheme.display(
              size: valueSize,
              weight: FontWeight.w600,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTheme.sans(size: 11, color: AppColors.mutedForeground),
          ),
        ],
      ),
    );
  }
}
