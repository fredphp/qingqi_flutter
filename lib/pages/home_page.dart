import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';

import '../data/mock_data.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/coin_badge.dart';
import '../widgets/common.dart';
import '../widgets/feature_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/quick_tool_row.dart';
import '../widgets/search_field.dart';
import '../widgets/section_header.dart';
import '../widgets/visual_card.dart';

/// Home / Index page — route `/`.
/// Mirrors src/pages/Index.tsx.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return AppScaffold(
      activeTab: 'home',
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Custom header ──
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: topInset + 28,
                bottom: 12,
              ),
              child: Row(
                children: [
                  // Brand
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF245A44), AppColors.primary],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppShadows.soft,
                    ),
                    child: const Icon(LucideIcons.leaf, size: 17, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '轻启AI',
                        style: AppTheme.display(
                          size: 16.5,
                          weight: FontWeight.w700,
                          color: AppColors.foreground,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '让工具更简单 · 让生活更轻松',
                        style: AppTheme.sans(
                          size: 10,
                          color: AppColors.mutedForeground,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Right actions
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Bell
                      _HeaderIconButton(
                        onTap: () {},
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(LucideIcons.bell,
                            size: 16, color: AppColors.mutedForeground),
                      ),
                      const SizedBox(width: 8),
                      CoinBadge(
                        amount: MockData.userProfile['coinBalance'] as String,
                        onTap: () => AppRoutes.go(context, AppRoutes.vip),
                      ),
                      const SizedBox(width: 8),
                      // Avatar
                      GestureDetector(
                        onTap: () => AppRoutes.go(context, AppRoutes.profile),
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.accent, width: 2),
                            boxShadow: AppShadows.soft,
                          ),
                          child: ClipOval(
                            child: NetImage(
                              MockData.userProfile['avatar'] as String,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Main (px-4 + gap-5) ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  // 2. Notice banner
                  _NoticeBanner(onTap: () => AppRoutes.go(context, AppRoutes.tools)),
                  const SizedBox(height: 20),

                  // 3. Hero banner with glass search
                  HeroBanner(
                    title: '你的 AI 生活助手',
                    subtitle: '一个 App，解决工作、学习、生活中的各种需求',
                    child: SearchField(
                      variant: 'glass',
                      placeholder: '今天想解决什么？',
                      onSearch: () => AppRoutes.go(context, AppRoutes.tools),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 4. Stats bar
                  const _StatsBar(),
                  const SizedBox(height: 20),

                  // 5. Quick tool row
                  QuickToolRow(
                    entries: MockData.quickEntries,
                    onTap: (e) => AppRoutes.go(context, e.route),
                  ),
                  const SizedBox(height: 20),

                  // 6. Trending row
                  _TrendingRow(
                    onTap: (route) => AppRoutes.go(context, route),
                  ),
                  const SizedBox(height: 20),

                  // 7. Featured section
                  SectionHeader(
                    title: '精选 AI · 让灵感落地',
                    action: '查看全部',
                    onAction: () => AppRoutes.go(context, AppRoutes.tools),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 230,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      itemCount: MockData.featuredCards.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, i) {
                        final card = MockData.featuredCards[i];
                        return SizedBox(
                          width: 236,
                          child: FeatureCard(
                            card: card,
                            badge: card.title == 'AI证件照' ? '热门' : 'NEW',
                            onUse: () => AppRoutes.go(context, card.route),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 8. AI Assistant promo
                  _AssistantPromo(
                    onTap: () => AppRoutes.go(context, AppRoutes.assistant),
                  ),
                  const SizedBox(height: 20),

                  // 9. Visual card
                  VisualCard(
                    title: MockData.shoppingAssistant['title'] as String,
                    subtitle: MockData.shoppingAssistant['subtitle'] as String,
                    tag: MockData.shoppingAssistant['tag'] as String,
                    imageUrl: MockData.shoppingAssistant['image'] as String,
                    onOpen: () {},
                  ),

                  // Bottom spacing to clear bottom nav
                  const SizedBox(height: 96),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Private widgets
// ─────────────────────────────────────────────────────────────────────────────

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.child,
    required this.onTap,
    required this.decoration,
  });

  final Widget child;
  final VoidCallback onTap;
  final Decoration decoration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: decoration,
        child: child,
      ),
    );
  }
}

/// Public notice banner with gradient background.
class _NoticeBanner extends StatelessWidget {
  const _NoticeBanner({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: AppGradients.noticeBanner,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '公',
                style: AppTheme.display(
                  size: 11,
                  weight: FontWeight.w700,
                  color: Colors.white,
                  height: 1,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '🌿 新工具上线：AI简历一键生成，点击体验 →',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.sans(size: 12, color: AppColors.foreground),
              ),
            ),
            const SizedBox(width: 6),
            const Icon(LucideIcons.chevronRight, size: 14, color: AppColors.mutedForeground),
          ],
        ),
      ),
    );
  }
}

/// Quick stats strip with three cells separated by thin vertical lines.
class _StatsBar extends StatelessWidget {
  const _StatsBar();

  @override
  Widget build(BuildContext context) {
    final stats = <_Stat>[
      _Stat(
        icon: LucideIcons.zap,
        value: '200万+',
        label: '服务用户',
      ),
      _Stat(
        icon: LucideIcons.sparkles,
        value: '50+',
        label: 'AI工具',
      ),
      _Stat(
        icon: LucideIcons.leaf,
        value: '免费',
        label: '永久使用',
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0x99FFFFFF), // rgba(255,255,255,0.6)
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xCCE8E2D5)), // rgba(232,226,213,0.8)
      ),
      child: Row(
        children: [
          for (int i = 0; i < stats.length; i++) ...[
            if (i > 0) ...[
              Container(
                width: 1,
                height: 24,
                color: AppColors.border,
                margin: const EdgeInsets.symmetric(horizontal: 6),
              ),
            ],
            Expanded(child: _StatCell(stat: stats[i])),
          ],
        ],
      ),
    );
  }
}

class _Stat {
  const _Stat({required this.icon, required this.value, required this.label});
  final IconData icon;
  final String value;
  final String label;
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.stat});
  final _Stat stat;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(stat.icon, size: 13, color: AppColors.primary),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              stat.value,
              style: AppTheme.display(
                size: 13,
                weight: FontWeight.w700,
                color: AppColors.primary,
                height: 1,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              stat.label,
              style: AppTheme.sans(size: 10, color: AppColors.mutedForeground, height: 1),
            ),
          ],
        ),
      ],
    );
  }
}

/// Horizontal scrollable list of trending-tool pills.
class _TrendingRow extends StatelessWidget {
  const _TrendingRow({required this.onTap});
  final void Function(String route) onTap;

  static const _pills = <_TrendPill>[
    _TrendPill(label: '图片压缩', route: '/image-compress'),
    _TrendPill(label: '证件照', route: '/id-photo'),
    _TrendPill(label: 'PDF转图', route: '/tools'),
    _TrendPill(label: 'OCR识别', route: '/tools'),
    _TrendPill(label: '图片格式', route: '/tools'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Trending label
        Container(
          padding: const EdgeInsets.only(right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(LucideIcons.trendingUp, size: 13, color: AppColors.accent),
              const SizedBox(width: 4),
              Text(
                '热门',
                style: AppTheme.sans(
                  size: 11.5,
                  weight: FontWeight.w600,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                for (int i = 0; i < _pills.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  _TrendPillButton(pill: _pills[i], onTap: () => onTap(_pills[i].route)),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TrendPill {
  const _TrendPill({required this.label, required this.route});
  final String label;
  final String route;
}

class _TrendPillButton extends StatelessWidget {
  const _TrendPillButton({required this.pill, required this.onTap});
  final _TrendPill pill;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(
          pill.label,
          style: AppTheme.sans(
            size: 11,
            weight: FontWeight.w500,
            color: AppColors.midSage,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}

/// AI Assistant promotional banner with forest gradient and gold accents.
class _AssistantPromo extends StatelessWidget {
  const _AssistantPromo({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppGradients.promo,
          borderRadius: BorderRadius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // radial gold glow at 90% 10%
            Positioned(
              right: 0,
              top: 0,
              child: IgnorePointer(
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      center: Alignment(0.8, -0.6),
                      colors: [
                        AppColors.accent.withValues(alpha: 0.32),
                        AppColors.accent.withValues(alpha: 0),
                      ],
                      stops: const [0.0, 0.55],
                    ),
                  ),
                ),
              ),
            ),
            // decorative white circle bottom-right
            Positioned(
              right: -24,
              bottom: -24,
              child: IgnorePointer(
                child: Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.04),
                  ),
                ),
              ),
            ),
            // Content
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.sparkles, size: 15, color: AppColors.goldLight),
                          const SizedBox(width: 6),
                          Text(
                            'AI 助手已就绪',
                            style: AppTheme.sans(
                              size: 11.5,
                              weight: FontWeight.w600,
                              color: AppColors.goldLight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '说出需求\nAI 帮你一步完成',
                        style: AppTheme.display(
                          size: 17,
                          weight: FontWeight.w600,
                          color: Colors.white,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '智能匹配工具，自动完成处理',
                        style: AppTheme.sans(
                          size: 11.5,
                          color: Colors.white.withValues(alpha: 0.65),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
                  ),
                  child: const Icon(LucideIcons.sparkles, size: 30, color: AppColors.goldLight),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
