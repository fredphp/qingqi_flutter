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

/// 关于我们 page — route `/about`.
/// Mirrors src/pages/About.tsx.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '关于我们', showBack: true, backTo: '/profile'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 32),
              children: [
                _buildHero(),
                _buildMilestones(),
                _buildMission(),
                _buildValues(),
                _buildInfoLinks(),
                _buildFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Hero ──
  Widget _buildHero() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppGradients.aboutHero,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25), width: 1.5),
            ),
            alignment: Alignment.center,
            child: const Text('🌿', style: TextStyle(fontSize: 30, height: 1)),
          ),
          const SizedBox(height: 12),
          Text(
            '轻启 AI',
            style: AppTheme.display(
              size: 22,
              weight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '让每个人都能轻松驾驭 AI 工具\n以自然美学，为效率赋予温度',
            textAlign: TextAlign.center,
            style: AppTheme.sans(
              size: 12.5,
              color: Colors.white.withValues(alpha: 0.72),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(LucideIcons.sparkles,
                    size: 11, color: Colors.white.withValues(alpha: 0.70)),
                const SizedBox(width: 6),
                Text(
                  'Version 1.0.0',
                  style: AppTheme.sans(
                    size: 11,
                    color: Colors.white.withValues(alpha: 0.70),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Milestones row ──
  Widget _buildMilestones() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          for (int i = 0; i < MockData.aboutMilestones.length; i++) ...[
            if (i > 0) const SizedBox(width: 12),
            Expanded(child: _buildMilestoneCell(MockData.aboutMilestones[i])),
          ],
        ],
      ),
    );
  }

  Widget _buildMilestoneCell(AboutMilestone m) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F6F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x141F4B39)), // rgba(31,75,57,0.08)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(m.emoji, style: const TextStyle(fontSize: 18, height: 1)),
          const SizedBox(height: 4),
          Text(
            m.value,
            style: AppTheme.display(
              size: 13,
              weight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            m.label,
            style: AppTheme.sans(size: 9.5, color: AppColors.mutedForeground),
          ),
        ],
      ),
    );
  }

  // ── Mission section ──
  Widget _buildMission() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(24),
          boxShadow: AppShadows.soft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(LucideIcons.leaf, size: 15, color: AppColors.midSage),
                const SizedBox(width: 8),
                Text(
                  '我们的使命',
                  style: AppTheme.sans(
                    size: 13,
                    weight: FontWeight.w600,
                    color: AppColors.midSage,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '我们相信，AI 应该像自然一样触手可及。轻启 AI 由一群热爱设计与技术的人创立，致力于将复杂的 AI 能力，以最简洁、最温暖的方式，带给每一位用户。',
              style: AppTheme.sans(
                  size: 13, color: const Color(0xFF4A5A50), height: 1.6),
            ),
            const SizedBox(height: 12),
            Text(
              '从一张证件照到一份重要文件，我们希望每个日常需求都能在轻启找到最优解。',
              style: AppTheme.sans(
                  size: 13, color: const Color(0xFF4A5A50), height: 1.6),
            ),
          ],
        ),
      ),
    );
  }

  // ── Core values ──
  Widget _buildValues() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              '核心价值观',
              style: AppTheme.sans(
                size: 13,
                weight: FontWeight.w600,
                color: AppColors.midSage,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (int i = 0; i < MockData.aboutValues.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                _buildValueCard(MockData.aboutValues[i]),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(AboutValue v) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F6F2),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(v.emoji, style: const TextStyle(fontSize: 17, height: 1)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  v.title,
                  style: AppTheme.sans(
                    size: 13,
                    weight: FontWeight.w600,
                    color: AppColors.foreground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  v.desc,
                  style: AppTheme.sans(size: 11.5, color: AppColors.mutedForeground),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── More info links ──
  Widget _buildInfoLinks() {
    final links = MockData.aboutInfoLinks;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              '更多信息',
              style: AppTheme.sans(
                size: 13,
                weight: FontWeight.w600,
                color: AppColors.midSage,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(24),
              boxShadow: AppShadows.soft,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (int i = 0; i < links.length; i++) ...[
                  _buildLinkRow(links[i]),
                  if (i < links.length - 1)
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

  Widget _buildLinkRow(Map<String, String> link) {
    return PressableScale(
      scale: 0.99,
      onTap: () {},
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
              child: Text(link['emoji']!,
                  style: const TextStyle(fontSize: 15, height: 1)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                link['label']!,
                style: AppTheme.sans(
                    size: 13, weight: FontWeight.w500, color: AppColors.foreground),
              ),
            ),
            const Icon(LucideIcons.chevronRight,
                size: 14, color: AppColors.placeholderGray),
          ],
        ),
      ),
    );
  }

  // ── Footer ──
  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.favorite, size: 11, color: AppColors.dangerText),
              const SizedBox(width: 4),
              Text(
                'Made with love by Qingqi Team',
                style: AppTheme.sans(size: 11.5, color: AppColors.placeholderGray),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.favorite, size: 11, color: AppColors.dangerText),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '© 2024 轻启AI · 保留所有权利',
            style: AppTheme.sans(size: 10.5, color: const Color(0xFFC4CFC6)),
          ),
        ],
      ),
    );
  }
}
