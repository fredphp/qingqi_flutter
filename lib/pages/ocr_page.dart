import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/lucide_icons.dart';
import '../data/mock_data.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_icons.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/action_button.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/file_info_card.dart';
import '../widgets/top_bar.dart';
import '../widgets/upload_zone.dart';

class OcrPage extends StatefulWidget {
  const OcrPage({super.key});

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  bool _hasFile = false;
  String _activeLang = '中英混合';
  String _activeMode = 'general';
  bool _recognized = false;
  bool _copied = false;

  static const List<String> _langs = ['中文', '英文', '中英混合', '日文', '韩文'];

  static const List<_OcrMode> _modes = [
    _OcrMode(id: 'general', name: '通用文字', desc: '段落、标题、正文'),
    _OcrMode(id: 'table', name: '表格模式', desc: '保留行列结构'),
    _OcrMode(id: 'hd', name: '高精度', desc: '手写/模糊图像'),
  ];

  void _onCopy() {
    Clipboard.setData(const ClipboardData(text: MockData.ocrMockResult));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: 'OCR 文字识别', showBack: true, backTo: '/tools'),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildHero(),
                // Upload card
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _hasFile
                      ? FileInfoCard(
                          file: MockData.imageCompressFile,
                          onRemove: () => setState(() {
                            _hasFile = false;
                            _recognized = false;
                          }),
                        )
                      : UploadZone(
                          title: '点击或拖拽上传图片/PDF',
                          formats: '支持 JPG · PNG · PDF · BMP',
                          hasFile: false,
                          onTap: () => setState(() => _hasFile = true),
                        ),
                ),
                // Recognition settings card
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildSettingsCard(),
                ),
                // Result card (only after recognized)
                if (_recognized)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: _buildResultCard(),
                  ),
                // Tips card
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildTipsCard(),
                ),
                // CTA
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                  child: ActionButton(
                    label: !_hasFile
                        ? '请先上传图片'
                        : _recognized
                            ? '重新识别'
                            : '开始识别文字',
                    variant: _hasFile
                        ? ActionButtonVariant.primary
                        : ActionButtonVariant.ghost,
                    radius: ActionButtonRadius.full,
                    disabled: !_hasFile,
                    onTap: _hasFile
                        ? () {
                            if (_recognized) {
                              setState(() => _recognized = false);
                            } else {
                              AppRoutes.go(context, AppRoutes.processing);
                              setState(() => _recognized = true);
                            }
                          }
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
      decoration: const BoxDecoration(gradient: AppGradients.ocrHero),
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
            child: Icon(AppIcons.resolve('ScanTextIcon'),
                size: 26, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'OCR 文字识别',
                  style: AppTheme.display(
                    size: 19,
                    weight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '图片文字一键提取 · 多语言支持',
                  style: AppTheme.sans(
                    size: 11.5,
                    color: const Color(0xB3FFFFFF),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: ['中英文', '表格识别', '扫描件']
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
              Icon(AppIcons.resolve('LanguagesIcon'),
                  size: 14, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '识别设置',
                style: AppTheme.sans(
                  size: 13.5,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // 文字语言
          Text(
            '文字语言',
            style: AppTheme.sans(
              size: 12.5,
              weight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 34,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _langs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final lang = _langs[i];
                final active = lang == _activeLang;
                return GestureDetector(
                  onTap: () => setState(() => _activeLang = lang),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: active ? const Color(0xFF4E3A72) : AppColors.card,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: active
                            ? const Color(0xFF4E3A72)
                            : AppColors.border,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        lang,
                        style: AppTheme.sans(
                          size: 11.5,
                          weight: FontWeight.w500,
                          color: active
                              ? Colors.white
                              : AppColors.mutedForeground,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          // 识别模式
          Text(
            '识别模式',
            style: AppTheme.sans(
              size: 12.5,
              weight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (int i = 0; i < _modes.length; i++) ...[
                Expanded(child: _buildModeChip(_modes[i])),
                if (i != _modes.length - 1) const SizedBox(width: 8),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModeChip(_OcrMode m) {
    final active = m.id == _activeMode;
    return GestureDetector(
      onTap: () => setState(() => _activeMode = m.id),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: active ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              m.name,
              style: AppTheme.sans(
                size: 12.5,
                weight: FontWeight.w600,
                color: active ? Colors.white : AppColors.foreground,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              m.desc,
              style: AppTheme.sans(
                size: 9.5,
                color: active
                    ? const Color(0xCCFFFFFF)
                    : AppColors.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Result card ──
  Widget _buildResultCard() {
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
              Icon(AppIcons.resolve('AlignLeftIcon'),
                  size: 14, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '识别结果',
                style: AppTheme.sans(
                  size: 13.5,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.12)),
            ),
            child: SelectableText(
              MockData.ocrMockResult,
              style: AppTheme.sans(
                size: 12.5,
                color: const Color(0xFF2A3A30),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          PressableScale(
            onTap: _onCopy,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _copied
                    ? AppColors.success.withValues(alpha: 0.15)
                    : AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _copied
                      ? AppColors.success.withValues(alpha: 0.40)
                      : AppColors.primary.withValues(alpha: 0.20),
                ),
              ),
              child: Center(
                child: Text(
                  _copied ? '✓ 已复制' : '复制',
                  style: AppTheme.sans(
                    size: 13,
                    weight: FontWeight.w600,
                    color: _copied ? AppColors.success : AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Tips card ──
  Widget _buildTipsCard() {
    final tips = [
      '支持印刷体、手写体、扫描文件',
      '表格模式自动保留行列结构',
      '识别结果支持一键复制或导出 TXT/DOCX',
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
              const Icon(LucideIcons.info, size: 15, color: AppColors.primary),
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

class _OcrMode {
  final String id;
  final String name;
  final String desc;
  const _OcrMode({required this.id, required this.name, required this.desc});
}
