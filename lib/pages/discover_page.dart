import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../data/mock_data.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';

/// "发现" page — content discovery hub.
/// Mirrors src/pages/Discover.tsx.
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  String _activeTab = '推荐'; // default to first tab

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return AppScaffold(
      activeTab: 'discover',
      child: Column(
        children: [
          // ── Sticky header (above the scroll) ──
          _buildStickyHeader(topInset),
          // ── Scrollable sections ──
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 16, bottom: 96),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildFeaturedBanner(),
                  const SizedBox(height: 20),
                  _buildTopics(),
                  const SizedBox(height: 20),
                  _buildFeatures(),
                  const SizedBox(height: 20),
                  _buildHotRanking(),
                  const SizedBox(height: 20),
                  _buildArticles(),
                  const SizedBox(height: 20),
                  _buildStatsStrip(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────
  //  Sticky header
  // ──────────────────────────────────────────────────────────────────
  Widget _buildStickyHeader(double topInset) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: topInset > 40 ? topInset + 4 : 40.0,
        bottom: 12,
      ),
      decoration: const BoxDecoration(
        gradient: AppGradients.discoverHeader,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top row: title + 全部工具 button
          Row(
            children: [
              const Icon(LucideIcons.compass, size: 20, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '发现',
                style: AppTheme.display(
                  size: 18,
                  weight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              PressableScale(
                onTap: () => AppRoutes.go(context, AppRoutes.tools),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.sageSoft, // #eef2ec
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(LucideIcons.sparkles,
                          size: 13, color: AppColors.midSage),
                      const SizedBox(width: 4),
                      Text(
                        '全部工具',
                        style: AppTheme.sans(
                          size: 12,
                          weight: FontWeight.w500,
                          color: AppColors.midSage,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // DiscoverTab pills
          _buildDiscoverTab(),
        ],
      ),
    );
  }

  Widget _buildDiscoverTab() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          for (int i = 0; i < MockData.discoverTabs.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            _buildTabPill(MockData.discoverTabs[i]),
          ],
        ],
      ),
    );
  }

  Widget _buildTabPill(String label) {
    final isActive = _activeTab == label;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = label),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary
              : const Color(0xA6FFFFFF), // rgba(255,255,255,0.65)
          borderRadius: BorderRadius.circular(999),
          border: isActive
              ? null
              : Border.all(
                  color: const Color(0x1F1F4B39)), // rgba(31,75,57,0.12)
          boxShadow: isActive
              ? const [
                  BoxShadow(
                    color: Color(0x471F4B39), // rgba(31,75,57,0.28)
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: AppTheme.sans(
            size: 12.5,
            weight: FontWeight.w600,
            color: isActive ? Colors.white : AppColors.midSage,
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────
  //  Featured banner
  // ──────────────────────────────────────────────────────────────────
  Widget _buildFeaturedBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          gradient: AppGradients.discoverFeatured,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Stack(
          children: [
            // Radial overlay gold at 85%/15%
            Positioned.fill(
              child: CustomPaint(painter: _RadialGoldPainter()),
            ),
            // Foreground
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
                          const Icon(LucideIcons.flame,
                              size: 13, color: AppColors.goldLight),
                          const SizedBox(width: 6),
                          Text(
                            '本周精选',
                            style: AppTheme.sans(
                              size: 11,
                              weight: FontWeight.w600,
                              color: AppColors.goldLight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'AI 工具周报\nNo.28 · 新技能上线',
                        style: AppTheme.display(
                          size: 17,
                          weight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // CTA button → /tools
                      PressableScale(
                        onTap: () => AppRoutes.go(context, AppRoutes.tools),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0x2EFFFFFF), // rgba(255,255,255,0.18)
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                                color: const Color(0x4DFFFFFF)), // rgba(255,255,255,0.30)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '查看详情',
                                style: AppTheme.sans(
                                  size: 12,
                                  weight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(LucideIcons.chevronRight,
                                  size: 13, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Right emoji box
                Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0x1AFFFFFF), // rgba(255,255,255,0.10)
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color: const Color(
                            0x2EFFFFFF)), // rgba(255,255,255,0.18)
                  ),
                  child: const Text(
                    '📰',
                    style: TextStyle(fontSize: 30, height: 1.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────
  //  Topics — 工具专题
  // ──────────────────────────────────────────────────────────────────
  Widget _buildTopics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section header row
          Row(
            children: [
              const Icon(LucideIcons.bookOpen, size: 15, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                '工具专题',
                style: AppTheme.sans(
                  size: 14,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => AppRoutes.go(context, AppRoutes.tools),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '更多',
                      style: AppTheme.sans(
                          size: 12, color: AppColors.midSage),
                    ),
                    const SizedBox(width: 2),
                    const Icon(LucideIcons.chevronRight,
                        size: 13, color: AppColors.midSage),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Horizontal scroll of topic cards
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                for (int i = 0; i < MockData.discoverTopics.length; i++) ...[
                  if (i > 0) const SizedBox(width: 12),
                  _buildTopicCard(MockData.discoverTopics[i]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(DiscoverTopic topic) {
    return PressableScale(
      onTap: () => AppRoutes.go(context, topic.route),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          gradient: topic.gradient,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            // Ambient white glow at 80%/20%
            Positioned.fill(
              child: CustomPaint(painter: _RadialWhitePainter()),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  topic.emoji,
                  style: const TextStyle(fontSize: 30, height: 1.0),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0x33FFFFFF), // rgba(255,255,255,0.20)
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    topic.tag,
                    style: AppTheme.sans(
                      size: 10,
                      weight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  topic.title,
                  style: AppTheme.display(
                    size: 14,
                    weight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  topic.desc,
                  style: AppTheme.sans(
                    size: 11,
                    color: const Color(0xB3FFFFFF), // rgba(255,255,255,0.70)
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '立即体验',
                      style: AppTheme.sans(
                        size: 11,
                        weight: FontWeight.w600,
                        color: const Color(0xE6FFFFFF), // rgba(255,255,255,0.90)
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(LucideIcons.chevronRight,
                        size: 12, color: Color(0xCCFFFFFF)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────
  //  AI Features — AI 能力一览
  // ──────────────────────────────────────────────────────────────────
  Widget _buildFeatures() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.sparkles,
                  size: 15, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                'AI 能力一览',
                style: AppTheme.sans(
                  size: 14,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = (constraints.maxWidth - 10) / 2;
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final f in MockData.discoverFeatures)
                    SizedBox(
                      width: cardWidth,
                      child: _buildFeatureCard(f),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(DiscoverFeature f) {
    return PressableScale(
      onTap: () => AppRoutes.go(context, AppRoutes.tools),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: f.tint,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0x99FFFFFF), // rgba(255,255,255,0.60)
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                f.emoji,
                style: const TextStyle(fontSize: 18, height: 1.0),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    f.title,
                    style: AppTheme.sans(
                      size: 12.5,
                      weight: FontWeight.w600,
                      color: AppColors.foreground,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    f.desc,
                    style: AppTheme.sans(
                      size: 10.5,
                      color: AppColors.mutedForeground,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────
  //  Hot ranking — 热门工具榜
  // ──────────────────────────────────────────────────────────────────
  Widget _buildHotRanking() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(24),
          boxShadow: AppShadows.soft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                const Icon(LucideIcons.flame,
                    size: 15, color: AppColors.rankOne),
                const SizedBox(width: 6),
                Text(
                  '热门工具榜',
                  style: AppTheme.sans(
                    size: 14,
                    weight: FontWeight.w600,
                    color: AppColors.foreground,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => AppRoutes.go(context, AppRoutes.tools),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '全部',
                        style: AppTheme.sans(
                            size: 12, color: AppColors.midSage),
                      ),
                      const SizedBox(width: 2),
                      const Icon(LucideIcons.chevronRight,
                          size: 12, color: AppColors.midSage),
                    ],
                  ),
                ),
              ],
            ),
            // Rows
            for (int i = 0; i < MockData.hotRankItems.length; i++) ...[
              _buildHotRankRow(MockData.hotRankItems[i]),
              if (i < MockData.hotRankItems.length - 1)
                Container(
                  margin: const EdgeInsets.only(left: 64),
                  height: 1,
                  color: const Color(0xFFF1EDE1), // #f1ede1
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHotRankRow(HotRankItem item) {
    final rankColor = item.rank == 1
        ? const Color(0xFFE8603A)
        : item.rank == 2
            ? const Color(0xFFC9A96A)
            : item.rank == 3
                ? const Color(0xFF7A8B80)
                : const Color(0xFFC4CFC6);
    return PressableScale(
      scale: 0.99,
      onTap: () => AppRoutes.go(context, item.route),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 28,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '${item.rank}',
                  style: AppTheme.display(
                    size: 13,
                    weight: FontWeight.w700,
                    color: rankColor,
                    height: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F6F2), // #f0f6f2
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                item.emoji,
                style: const TextStyle(fontSize: 18, height: 1.0),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.name,
                    style: AppTheme.sans(
                      size: 13,
                      weight: FontWeight.w600,
                      color: AppColors.foreground,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.usage,
                    style: AppTheme.sans(
                      size: 11,
                      color: AppColors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(LucideIcons.trendingUp, size: 12, color: AppColors.accent),
            const SizedBox(width: 4),
            const Icon(LucideIcons.chevronRight,
                size: 14, color: Color(0xFFB8C4BC)),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────
  //  Articles — 技巧文章
  // ──────────────────────────────────────────────────────────────────
  Widget _buildArticles() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section header row
          Row(
            children: [
              const Icon(LucideIcons.bookOpen,
                  size: 15, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                '技巧文章',
                style: AppTheme.sans(
                  size: 14,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
              const Spacer(),
              const Icon(LucideIcons.star,
                  size: 11, color: AppColors.placeholderGray),
              const SizedBox(width: 2),
              Text(
                '精选内容',
                style: AppTheme.sans(
                    size: 12, color: AppColors.placeholderGray),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(24),
              boxShadow: AppShadows.soft,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < MockData.articleCards.length; i++) ...[
                  _buildArticleCard(MockData.articleCards[i]),
                  if (i < MockData.articleCards.length - 1)
                    Container(
                      height: 1,
                      color: const Color(0xFFF1EDE1), // #f1ede1
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(ArticleCard a) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  a.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.sans(
                    size: 13,
                    weight: FontWeight.w600,
                    color: AppColors.foreground,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.sageSoft, // #eef2ec
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        a.category,
                        style: AppTheme.sans(
                          size: 10,
                          weight: FontWeight.w500,
                          color: AppColors.midSage, // #4a7a63
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '阅读 ${a.readTime}',
                      style: AppTheme.sans(
                        size: 10.5,
                        color: AppColors.placeholderGray, // #a0a8a2
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          NetImage(
            a.image,
            width: 80,
            height: 64,
            fit: BoxFit.cover,
            borderRadius: 16,
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────
  //  Stats strip
  // ──────────────────────────────────────────────────────────────────
  Widget _buildStatsStrip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppGradients.discoverStats,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            for (int i = 0; i < 3; i++) ...[
              if (i > 0) ...[
                const SizedBox(width: 8),
                Container(
                  width: 1,
                  height: 32,
                  color: AppColors.border, // #e8e2d5
                ),
                const SizedBox(width: 8),
              ],
              Expanded(child: _buildStatsCell(i)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCell(int i) {
    final data = const [
      (LucideIcons.zap, AppColors.primary, '200万+', '服务用户'),
      (LucideIcons.sparkles, AppColors.accent, '50+', 'AI工具'),
      (LucideIcons.star, AppColors.rankThree, '4.9分', '用户评分'),
    ][i];
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(data.$1, size: 15, color: data.$2),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.$3,
              style: AppTheme.display(
                size: 14,
                weight: FontWeight.w700,
                color: AppColors.primary,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              data.$4,
              style: AppTheme.sans(
                size: 10,
                color: AppColors.mutedForeground,
                height: 1.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────
//  Custom painters for radial overlays
// ──────────────────────────────────────────────────────────────────
class _RadialGoldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.85, size.height * 0.15);
    final radius = size.width * 0.55;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0x59C9A96A), // rgba(201,169,106,0.35)
          const Color(0x00C9A96A),
        ],
        stops: const [0.0, 0.55],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RadialWhitePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.80, size.height * 0.20);
    final radius = size.width * 0.6;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0x1FFFFFFF), // rgba(255,255,255,0.12)
          Colors.transparent,
        ],
        stops: const [0.0, 0.60],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
