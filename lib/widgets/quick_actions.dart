import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// 四个快捷入口：图片处理 / PDF工具 / OCR识别 / 更多工具
/// 每项：白色圆角图标容器 56x56 + 下方标签
class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  static const _items = <_QuickItem>[
    _QuickItem(icon: Icons.image_outlined, label: '图片处理'),
    _QuickItem(icon: Icons.description_outlined, label: 'PDF工具'),
    _QuickItem(icon: Icons.crop_free_outlined, label: 'OCR识别'),
    _QuickItem(icon: Icons.grid_view_outlined, label: '更多工具'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items.map((e) => _QuickAction(item: e)).toList(),
      ),
    );
  }
}

class _QuickItem {
  const _QuickItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.item});
  final _QuickItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border, width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(item.icon, color: AppColors.primary, size: 26),
            ),
            const SizedBox(height: 8),
            Text(item.label, style: AppTextStyles.quickActionLabel),
          ],
        ),
      ),
    );
  }
}
