import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// 底部导航栏（中央按钮突出）
/// 首页 / 工具 / AI助手（中央突出） / 发现 / 我的
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    this.activeIndex = 2,
    this.onTap,
  });

  final int activeIndex;
  final ValueChanged<int>? onTap;

  static const _items = <_NavItem>[
    _NavItem(icon: Icons.home_rounded, activeIcon: Icons.home_rounded, label: '首页'),
    _NavItem(icon: Icons.widgets_outlined, activeIcon: Icons.widgets_rounded, label: '工具'),
    _NavItem(icon: Icons.auto_awesome_outlined, activeIcon: Icons.auto_awesome_rounded, label: 'AI助手'),
    _NavItem(icon: Icons.explore_outlined, activeIcon: Icons.explore_rounded, label: '发现'),
    _NavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: '我的'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final active = i == activeIndex;
              // 中央项特殊渲染
              if (i == 2) {
                return _CenterItem(
                  item: item,
                  active: active,
                  onTap: () => onTap?.call(i),
                );
              }
              return _SideItem(
                item: item,
                active: active,
                onTap: () => onTap?.call(i),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
  final IconData icon;
  final IconData activeIcon;
  final String label;
}

class _SideItem extends StatelessWidget {
  const _SideItem({
    required this.item,
    required this.active,
    required this.onTap,
  });
  final _NavItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              active ? item.activeIcon : item.icon,
              size: 22,
              color: active ? AppColors.primary : AppColors.textTertiary,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: active
                  ? AppTextStyles.navLabelActive
                  : AppTextStyles.navLabelInactive,
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterItem extends StatelessWidget {
  const _CenterItem({
    required this.item,
    required this.active,
    required this.onTap,
  });
  final _NavItem item;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const StadiumBorder(),
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                item.activeIcon,
                size: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              style: AppTextStyles.navLabelActive,
            ),
          ],
        ),
      ),
    );
  }
}
