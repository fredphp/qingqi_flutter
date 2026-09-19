import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../data/mock_data.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/action_button.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/estimate_panel.dart';
import '../widgets/file_info_card.dart';
import '../widgets/quality_slider.dart';
import '../widgets/top_bar.dart';
import '../widgets/upload_zone.dart';

class ImageCompressPage extends StatefulWidget {
  const ImageCompressPage({super.key});

  @override
  State<ImageCompressPage> createState() => _ImageCompressPageState();
}

class _ImageCompressPageState extends State<ImageCompressPage> {
  bool _hasFile = false;
  int _quality = 80;

  @override
  Widget build(BuildContext context) {
    final estimateSize =
        _quality > 85 ? '1.8 MB' : _quality > 65 ? '0.9 MB' : '0.4 MB';
    final savePercent =
        _quality > 85 ? '28' : _quality > 65 ? '62' : '82';

    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '图片压缩', showBack: true, backTo: '/tools'),
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
                          onRemove: () => setState(() => _hasFile = false),
                        )
                      : UploadZone(
                          title: '点击或拖拽上传图片',
                          formats: '支持 JPG · PNG · WEBP · BMP',
                          hasFile: false,
                          onTap: () => setState(() => _hasFile = true),
                        ),
                ),
                // Quality slider card (dimmed until file is selected)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Opacity(
                    opacity: _hasFile ? 1.0 : 0.45,
                    child: AbsorbPointer(
                      absorbing: !_hasFile,
                      child: Container(
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
                                const Icon(LucideIcons.clock,
                                    size: 15, color: AppColors.primary),
                                const SizedBox(width: 8),
                                Text(
                                  '压缩质量',
                                  style: AppTheme.sans(
                                    size: 13.5,
                                    weight: FontWeight.w600,
                                    color: AppColors.foreground,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            QualitySlider(
                              value: _quality,
                              onChanged: (v) => setState(() => _quality = v),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Estimate panel
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Opacity(
                    opacity: _hasFile ? 1.0 : 0.45,
                    child: AbsorbPointer(
                      absorbing: !_hasFile,
                      child: EstimatePanel(
                        sizeValue: estimateSize,
                        saveValue: savePercent,
                        qualityValue: '$_quality%',
                      ),
                    ),
                  ),
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
                    label: '开始智能压缩',
                    variant: ActionButtonVariant.primary,
                    radius: ActionButtonRadius.full,
                    disabled: !_hasFile,
                    onTap: _hasFile
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
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _HeroGlowPainter())),
          Row(
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
                child: const Icon(LucideIcons.image, size: 26, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '图片智能压缩',
                      style: AppTheme.display(
                        size: 19,
                        weight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'AI 驱动 · 保真压缩 · 极速处理',
                      style: AppTheme.sans(
                        size: 11.5,
                        color: const Color(0xB3FFFFFF),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: ['最高减小90%', '无损品质', '批量处理']
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
        ],
      ),
    );
  }

  // ── Tips card ──
  Widget _buildTipsCard() {
    final tips = [
      '支持 JPG / PNG / WEBP / BMP 格式',
      '单次最大处理 20MB 图片',
      '质量 75–85% 通常兼顾清晰度和体积',
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

class _HeroGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // gold glow at 80% / 20%
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.2),
      size.width * 0.55,
      Paint()
        ..shader = RadialGradient(
          colors: [const Color(0x38C9A96A), Colors.transparent],
        ).createShader(Rect.fromCircle(
            center: Offset(size.width * 0.8, size.height * 0.2),
            radius: size.width * 0.55)),
    );
    // white glow at 10% / 90%
    canvas.drawCircle(
      Offset(size.width * 0.1, size.height * 0.9),
      size.width * 0.4,
      Paint()
        ..shader = RadialGradient(
          colors: [const Color(0x12FFFFFF), Colors.transparent],
        ).createShader(Rect.fromCircle(
            center: Offset(size.width * 0.1, size.height * 0.9),
            radius: size.width * 0.4)),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
