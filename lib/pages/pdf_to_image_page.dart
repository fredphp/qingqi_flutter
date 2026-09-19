import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_icons.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/action_button.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/top_bar.dart';

class PdfToImagePage extends StatefulWidget {
  const PdfToImagePage({super.key});

  @override
  State<PdfToImagePage> createState() => _PdfToImagePageState();
}

class _PdfToImagePageState extends State<PdfToImagePage> {
  bool _hasPdf = false;
  String _outputFmt = 'jpg';
  String _quality = 'hd'; // 72dpi=std, 150dpi=hd (default), 300dpi=uhd
  String _pageRange = 'all'; // all / first / custom
  final TextEditingController _customRangeCtrl = TextEditingController();

  @override
  void dispose() {
    _customRangeCtrl.dispose();
    super.dispose();
  }

  static const _fmts = <_ChipOption>[
    _ChipOption('jpg', 'JPG'),
    _ChipOption('png', 'PNG'),
    _ChipOption('webp', 'WEBP'),
  ];

  static const _qualities = <_ChipOption>[
    _ChipOption('std', '标准 (72dpi)'),
    _ChipOption('hd', '高清 (150dpi)'),
    _ChipOption('uhd', '超清 (300dpi)'),
  ];

  static const _ranges = <_ChipOption>[
    _ChipOption('all', '全部页面'),
    _ChipOption('first', '仅首页'),
    _ChipOption('custom', '自定义'),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: 'PDF 转图片', showBack: true, backTo: '/tools'),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildHero(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildPdfUploadBox(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildSettingsCard(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildPagePreviewCard(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildTipsCard(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                  child: ActionButton(
                    label: _hasPdf ? '开始转换图片' : '请先上传 PDF',
                    variant: _hasPdf
                        ? ActionButtonVariant.primary
                        : ActionButtonVariant.ghost,
                    radius: ActionButtonRadius.full,
                    disabled: !_hasPdf,
                    onTap: _hasPdf
                        ? () => AppRoutes.go(context, AppRoutes.processing)
                        : null,
                  ),
                ),
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
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
      decoration: BoxDecoration(gradient: AppGradients.forestHero()),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0x24FFFFFF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0x38FFFFFF)),
            ),
            alignment: Alignment.center,
            child: Icon(AppIcons.resolve('FileTextIcon'),
                size: 26, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'PDF 转图片',
                  style: AppTheme.display(
                    size: 19,
                    weight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '每页高清导出 · 批量下载 · 无需安装',
                  style: AppTheme.sans(
                    size: 11.5,
                    color: const Color(0xB3FFFFFF),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: ['高清输出', '全部页面', '多种格式']
                      .map((t) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0x26FFFFFF),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                t,
                                style: AppTheme.sans(
                                  size: 10,
                                  weight: FontWeight.w500,
                                  color: const Color(0xE0FFFFFF),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Custom PDF upload box ──
  Widget _buildPdfUploadBox() {
    return PressableScale(
      onTap: () => setState(() => _hasPdf = true),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 36),
        decoration: BoxDecoration(
          color: AppColors.muted.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.fromHex('#a6c0ab'),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: _hasPdf
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Icon(
                AppIcons.resolve('FileTextIcon'),
                size: 24,
                color: _hasPdf ? Colors.white : AppColors.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _hasPdf ? '报告_2024Q4.pdf' : '点击上传 PDF 文件',
              style: AppTheme.sans(
                size: 13,
                weight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _hasPdf ? '共 12 页 · 4.2 MB' : '支持最大 50MB',
              style: AppTheme.sans(
                  size: 11, color: AppColors.mutedForeground),
            ),
          ],
        ),
      ),
    );
  }

  // ── Settings card ──
  Widget _buildSettingsCard() {
    return Container(
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
            children: [
              Icon(AppIcons.resolve('GalleryHorizontalEndIcon'),
                  size: 14, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '导出设置',
                style: AppTheme.sans(
                  size: 13.5,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // 图片格式
          _settingLabel('图片格式'),
          const SizedBox(height: 8),
          Row(
            children: [
              for (int i = 0; i < _fmts.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(
                  child: _primaryChip(
                    _fmts[i],
                    active: _outputFmt == _fmts[i].id,
                    onTap: () => setState(() => _outputFmt = _fmts[i].id),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          // 图片清晰度
          _settingLabel('图片清晰度'),
          const SizedBox(height: 8),
          Row(
            children: [
              for (int i = 0; i < _qualities.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(
                  child: _primaryChip(
                    _qualities[i],
                    active: _quality == _qualities[i].id,
                    onTap: () => setState(() => _quality = _qualities[i].id),
                    fontSize: 11,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 14),
          // 导出页面
          _settingLabel('导出页面'),
          const SizedBox(height: 8),
          Row(
            children: [
              for (int i = 0; i < _ranges.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(
                  child: _goldChip(
                    _ranges[i],
                    active: _pageRange == _ranges[i].id,
                    onTap: () => setState(() => _pageRange = _ranges[i].id),
                    fontSize: 11,
                  ),
                ),
              ],
            ],
          ),
          // Custom range input (expand when custom)
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _pageRange == 'custom'
                ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F4EE),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.22)),
                      ),
                      child: TextField(
                        controller: _customRangeCtrl,
                        style: AppTheme.sans(
                          size: 13,
                          weight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        decoration: InputDecoration(
                          hintText: '如 1-5,8,10-12',
                          hintStyle: AppTheme.sans(
                              size: 13,
                              color: AppColors.placeholderGray),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _settingLabel(String text) {
    return Text(
      text,
      style: AppTheme.sans(
        size: 12,
        weight: FontWeight.w600,
        color: AppColors.mutedForeground,
      ),
    );
  }

  Widget _primaryChip(
    _ChipOption opt, {
    required bool active,
    required VoidCallback onTap,
    double fontSize = 12,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active ? AppColors.primary : AppColors.border,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          opt.label,
          textAlign: TextAlign.center,
          style: AppTheme.sans(
            size: fontSize,
            weight: FontWeight.w600,
            color: active ? Colors.white : AppColors.foreground,
          ),
        ),
      ),
    );
  }

  Widget _goldChip(
    _ChipOption opt, {
    required bool active,
    required VoidCallback onTap,
    double fontSize = 12,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: active
              ? AppColors.accent.withValues(alpha: 0.18)
              : AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active ? AppColors.accent : AppColors.border,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          opt.label,
          textAlign: TextAlign.center,
          style: AppTheme.sans(
            size: fontSize,
            weight: FontWeight.w600,
            color: active ? AppColors.goldBrown2 : AppColors.foreground,
          ),
        ),
      ),
    );
  }

  // ── Page preview card ──
  Widget _buildPagePreviewCard() {
    return Container(
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
            children: [
              Icon(AppIcons.resolve('FilesIcon'),
                  size: 14, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '页面预览',
                style: AppTheme.sans(
                  size: 13.5,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 88,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                if (i < 4) {
                  return _buildPageThumb(i + 1);
                }
                return _buildMoreThumb();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageThumb(int page) {
    return Container(
      width: 64,
      height: 88,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFF1EDE1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.15), width: 1.5),
      ),
      child: Stack(
        children: [
          // "Text lines" decoration
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 3,
                    width: 22,
                    color: AppColors.primary.withValues(alpha: 0.40)),
                const SizedBox(height: 6),
                for (int i = 0; i < 5; i++) ...[
                  Container(
                      height: 2,
                      width: double.infinity,
                      color: AppColors.primary.withValues(alpha: 0.13)),
                  const SizedBox(height: 4),
                ],
              ],
            ),
          ),
          // Page badge bottom-left
          Positioned(
            left: 4,
            bottom: 4,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'P$page',
                style: AppTheme.sans(
                  size: 9,
                  weight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreThumb() {
    return Container(
      width: 64,
      height: 88,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.18), width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        '+8页',
        style: AppTheme.sans(
          size: 11,
          weight: FontWeight.w600,
          color: AppColors.midSage,
        ),
      ),
    );
  }

  // ── Tips card ──
  Widget _buildTipsCard() {
    final tips = [
      '支持扫描件 PDF，每页高清导出',
      '可选择导出全部页面或指定范围',
      '图片打包为 ZIP，一键下载',
    ];
    return Container(
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
            children: [
              const Icon(LucideIcons.info,
                  size: 15, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '使用提示',
                style: AppTheme.sans(
                  size: 13.5,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < tips.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(LucideIcons.checkCircle,
                    size: 13, color: AppColors.success),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    tips[i],
                    style: AppTheme.sans(
                      size: 11.5,
                      color: AppColors.mutedForeground,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            if (i != tips.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _ChipOption {
  final String id;
  final String label;
  const _ChipOption(this.id, this.label);
}
