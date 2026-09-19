import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';
import '../data/mock_data.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/preview_tabs.dart';
import '../widgets/result_thumbnails.dart';
import '../widgets/share_options.dart';
import '../widgets/top_bar.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  static const _tabs = ['处理后', '原图对比'];
  static const _processedUrl =
      'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=700&q=75';
  static const _originalUrl =
      'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=700&q=90';

  int _activeTab = 0;
  int _activeThumb = 0;
  bool _downloaded = false;

  void _handleDownload() {
    setState(() => _downloaded = true);
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) setState(() => _downloaded = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '处理结果', showBack: true, backTo: '/'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                _buildSuccessBanner(),
                _buildPreviewTabs(),
                _buildPreview(),
                _buildStatsCard(),
                _buildHistoryCard(),
                _buildActions(),
                _buildShareCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── 1. Success banner ──
  Widget _buildSuccessBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: AppGradients.successBanner,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x384CAF7D)),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.checkCircle, size: 20, color: AppColors.success),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '处理成功！',
                  style: AppTheme.sans(
                    size: 13,
                    weight: FontWeight.w600,
                    color: AppColors.foreground,
                  ),
                ),
                Text(
                  '您的图片已完成 AI 智能压缩处理',
                  style: AppTheme.sans(size: 11, color: AppColors.midSage),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── 2. Preview tabs ──
  Widget _buildPreviewTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: PreviewTabs(
        tabs: _tabs.toList(),
        active: _activeTab,
        onChanged: (i) => setState(() => _activeTab = i),
      ),
    );
  }

  // ── 3. Image preview ──
  Widget _buildPreview() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFFF1EDE1),
      ),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: _activeTab == 0
            ? NetImage(_processedUrl, fit: BoxFit.cover)
            : Row(
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        NetImage(_originalUrl, fit: BoxFit.cover),
                        Positioned(
                          left: 8,
                          bottom: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0x8C000000),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              '原图',
                              style: AppTheme.sans(
                                size: 10,
                                weight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, color: const Color(0xCCFFFFFF)),
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        NetImage(_processedUrl, fit: BoxFit.cover),
                        Positioned(
                          right: 8,
                          bottom: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xA61F4B39),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              '压缩后',
                              style: AppTheme.sans(
                                size: 10,
                                weight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
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

  // ── 4. Stats card ──
  Widget _buildStatsCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '压缩统计',
                style: AppTheme.sans(
                  size: 13.5,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE4EFE7),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '节省 62%',
                  style: AppTheme.sans(
                    size: 10.5,
                    weight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Size comparison
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F4EF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '2.4 MB',
                        style: AppTheme.display(
                          size: 17,
                          weight: FontWeight.w700,
                          color: AppColors.destructive,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '原图大小',
                        style: AppTheme.sans(
                          size: 10.5,
                          color: AppColors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(LucideIcons.chevronRight,
                        size: 16, color: AppColors.success),
                    const SizedBox(height: 2),
                    Text(
                      '压缩',
                      style: AppTheme.sans(size: 9, color: AppColors.success),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '0.9 MB',
                        style: AppTheme.display(
                          size: 17,
                          weight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '压缩后大小',
                        style: AppTheme.sans(
                          size: 10.5,
                          color: AppColors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Stat bars
          _StatBar(label: '文件大小', value: 38, color: AppColors.primary),
          const SizedBox(height: 10),
          _StatBar(label: '图片质量', value: 92, color: AppColors.success),
          const SizedBox(height: 10),
          _StatBar(label: '分辨率保留', value: 100, color: AppColors.accent),
        ],
      ),
    );
  }

  // ── 5. History thumbnails card ──
  Widget _buildHistoryCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '处理历史',
            style: AppTheme.sans(
              size: 13.5,
              weight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 10),
          ResultThumbnails(
            thumbs: MockData.resultThumbs,
            activeIndex: _activeThumb,
            onChanged: (i) => setState(() => _activeThumb = i),
          ),
        ],
      ),
    );
  }

  // ── 6. Action buttons ──
  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        children: [
          // Big download / saved button
          PressableScale(
            onTap: _handleDownload,
            child: Container(
              height: 52,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: _downloaded
                    ? AppGradients.success
                    : AppGradients.primaryCta,
                borderRadius: BorderRadius.circular(999),
                boxShadow: AppShadows.soft,
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _downloaded
                        ? LucideIcons.checkCircle
                        : LucideIcons.download,
                    size: 19,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _downloaded ? '已保存到相册' : '下载压缩图片',
                    style: AppTheme.sans(
                      size: 15,
                      weight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _SmallButton(
                  icon: LucideIcons.refreshCw,
                  label: '继续压缩',
                  onTap: () => AppRoutes.go(context, AppRoutes.imageCompress),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SmallButton(
                  icon: LucideIcons.share,
                  label: '分享图片',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── 7. Share options card ──
  Widget _buildShareCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '分享方式',
            style: AppTheme.sans(
              size: 13.5,
              weight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 12),
          ShareOptions(
            methods: MockData.shareMethods,
            onTap: (_) {},
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// Stat bar (label + colored bar + value)
// ──────────────────────────────────────────────────────────────
class _StatBar extends StatelessWidget {
  const _StatBar({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: AppTheme.sans(size: 11.5, color: AppColors.mutedForeground),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: const Color(0xFFF1EDE1),
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: value / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 36,
          child: Text(
            '$value%',
            textAlign: TextAlign.right,
            style: AppTheme.sans(
              size: 11.5,
              weight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────
// Small pill button (border + bg #fefcf6, #4a7a63 text)
// ──────────────────────────────────────────────────────────────
class _SmallButton extends StatelessWidget {
  const _SmallButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFFFEFCF6),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0xFFE8E2D5)),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppColors.midSage),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTheme.sans(
                size: 13,
                weight: FontWeight.w500,
                color: AppColors.midSage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
