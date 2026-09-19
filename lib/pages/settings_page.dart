import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/top_bar.dart';

/// 设置 page — route `/settings`.
/// Mirrors src/pages/Settings.tsx.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final Map<String, bool> _toggleStates = {
    for (final t in MockData.settingToggles) t.id: t.defaultOn,
  };
  bool _cleared = false;

  void _handleToggle(String id) {
    setState(() {
      _toggleStates[id] = !(_toggleStates[id] ?? false);
    });
  }

  void _handleNavRow(String id) {
    if (id == 'cache') {
      setState(() => _cleared = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _cleared = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '设置', showBack: true, backTo: '/profile'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 32),
              children: [
                _buildAccountCard(),
                _buildToggleSection(),
                _buildNavSection(),
                _buildDangerZone(),
                _buildVersion(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Account card ──
  Widget _buildAccountCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.promo,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
            ),
            alignment: Alignment.center,
            child: const Text('🌿', style: TextStyle(fontSize: 22, height: 1)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '轻启用户 · UID 8821943',
                  style: AppTheme.sans(
                    size: 14,
                    weight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '账号已安全绑定手机号',
                  style: AppTheme.sans(
                    size: 11.5,
                    color: Colors.white.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
          Icon(LucideIcons.chevronRight,
              size: 16, color: Colors.white.withValues(alpha: 0.60)),
        ],
      ),
    );
  }

  // ── Section heading ──
  Widget _buildSectionHeading(String text, {Color color = AppColors.midSage}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: AppTheme.sans(
          size: 13,
          weight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  // ── Toggle section ──
  Widget _buildToggleSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeading('偏好设置'),
          Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(24),
              boxShadow: AppShadows.soft,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (int i = 0; i < MockData.settingToggles.length; i++) ...[
                  _buildToggleRow(MockData.settingToggles[i]),
                  if (i < MockData.settingToggles.length - 1)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 1,
                      color: const Color(0xFFF1EDE1),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleRow(SettingToggle t) {
    final on = _toggleStates[t.id] ?? false;
    return PressableScale(
      scale: 0.99,
      onTap: () => _handleToggle(t.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F6F2),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(t.emoji, style: const TextStyle(fontSize: 16, height: 1)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.label,
                    style: AppTheme.sans(
                        size: 13, weight: FontWeight.w500, color: AppColors.foreground),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    t.desc,
                    style: AppTheme.sans(size: 11, color: AppColors.placeholderGray),
                  ),
                ],
              ),
            ),
            Icon(
              on ? LucideIcons.toggleRight : LucideIcons.toggleLeft,
              size: 28,
              color: on ? AppColors.primary : const Color(0xFFC4CFC6),
            ),
          ],
        ),
      ),
    );
  }

  // ── Nav section ──
  Widget _buildNavSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeading('更多选项'),
          Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(24),
              boxShadow: AppShadows.soft,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (int i = 0; i < MockData.settingLinks.length; i++) ...[
                  _buildNavRow(MockData.settingLinks[i]),
                  if (i < MockData.settingLinks.length - 1)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 1,
                      color: const Color(0xFFF1EDE1),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavRow(SettingLink item) {
    // Cache row shows "缓存已清理！" instead of the trailing text for 2s.
    final isCache = item.id == 'cache';
    final desc = isCache && _cleared ? '缓存已清理！' : item.trailing;
    final isBadgeRow = isCache;
    return PressableScale(
      scale: 0.99,
      onTap: () => _handleNavRow(item.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F6F2),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(item.emoji, style: const TextStyle(fontSize: 16, height: 1)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.label,
                    style: AppTheme.sans(
                        size: 13, weight: FontWeight.w500, color: AppColors.foreground),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    desc,
                    style: AppTheme.sans(size: 11, color: AppColors.placeholderGray),
                  ),
                ],
              ),
            ),
            if (isBadgeRow)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF0F0),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '清理',
                  style: AppTheme.sans(
                    size: 11,
                    weight: FontWeight.w500,
                    color: AppColors.dangerText,
                  ),
                ),
              )
            else ...[
              Text(
                item.trailing,
                style: AppTheme.sans(size: 11.5, color: AppColors.placeholderGray),
              ),
              const SizedBox(width: 4),
              const Icon(LucideIcons.chevronRight,
                  size: 14, color: AppColors.placeholderGray),
            ],
          ],
        ),
      ),
    );
  }

  // ── Danger zone ──
  Widget _buildDangerZone() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionHeading('账号操作', color: AppColors.dangerText),
          Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(24),
              boxShadow: AppShadows.soft,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                _buildDangerRow(
                  icon: LucideIcons.logOut,
                  label: '退出登录',
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 1,
                  color: const Color(0xFFF1EDE1),
                ),
                _buildDangerRow(
                  icon: LucideIcons.trash2,
                  label: '注销账号',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDangerRow({required IconData icon, required String label}) {
    return PressableScale(
      scale: 0.99,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF5F0),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 16, color: AppColors.dangerText),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTheme.sans(
                  size: 13, weight: FontWeight.w500, color: AppColors.dangerText),
            ),
            const Spacer(),
            const Icon(LucideIcons.chevronRight,
                size: 14, color: Color(0xFFC4CFC6)),
          ],
        ),
      ),
    );
  }

  // ── Version ──
  Widget _buildVersion() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: Text(
          '轻启AI · 版本 1.0.0',
          style: AppTheme.sans(size: 11, color: const Color(0xFFC4CFC6)),
        ),
      ),
    );
  }
}
