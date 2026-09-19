import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../router.dart';

/// Floating bottom navigation bar with 5 tabs.
/// The center "AI助手" tab is an elevated gradient square button.
/// Mirrors src/components/BottomNav.tsx.
class BottomNav extends StatelessWidget {
  const BottomNav({super.key, this.active = 'home'});

  final String active;

  static const _defs = <_NavDef>[
    _NavDef(id: 'home', label: '首页', icon: LucideIcons.home, route: AppRoutes.home),
    _NavDef(id: 'tools', label: '工具', icon: LucideIcons.layoutGrid, route: AppRoutes.tools),
    _NavDef(id: 'assistant', label: 'AI助手', icon: LucideIcons.sparkles, route: AppRoutes.assistant),
    _NavDef(id: 'discover', label: '发现', icon: LucideIcons.compass, route: AppRoutes.discover),
    _NavDef(id: 'profile', label: '我的', icon: LucideIcons.user, route: AppRoutes.profile),
  ];

  void _handleTap(BuildContext context, _NavDef def) {
    final nav = Navigator.of(context);
    // Pop to root if possible then push, to mimic tab switching.
    if (def.route == AppRoutes.home) {
      nav.popUntil((r) => r.isFirst);
      return;
    }
    // Remove all routes above the target if it exists, else push.
    bool found = false;
    nav.popUntil((route) {
      if (route.settings.name == def.route) {
        found = true;
        return true;
      }
      return route.isFirst;
    });
    if (!found) {
      nav.pushNamed(def.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.95),
        border: const Border(top: BorderSide(color: Color(0xB3E8E2D5), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _defs.map((d) => _buildItem(context, d)).toList(),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, _NavDef def) {
    final isActive = active == def.id;
    final isCenter = def.id == 'assistant';

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _handleTap(context, def),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCenter)
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2D6B50), AppColors.primary],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x661F4B39),
                      blurRadius: 14,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(LucideIcons.sparkles,
                    size: 21, color: Color(0xEDFFFFFF)),
              )
            else
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primary.withValues(alpha: 0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(11),
                ),
                alignment: Alignment.center,
                child: Icon(def.icon,
                    size: 19,
                    color: isActive ? AppColors.primary : AppColors.inactiveNav),
              ),
            const SizedBox(height: 4),
            Text(
              def.label,
              style: AppTheme.sans(
                size: 10.5,
                weight: isActive || isCenter ? FontWeight.w600 : FontWeight.w500,
                color: isCenter
                    ? AppColors.midSage
                    : isActive
                        ? AppColors.primary
                        : AppColors.inactiveNav,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavDef {
  final String id;
  final String label;
  final IconData icon;
  final String route;
  const _NavDef({
    required this.id,
    required this.label,
    required this.icon,
    required this.route,
  });
}
