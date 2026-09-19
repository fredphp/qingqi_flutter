import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';
import '../data/mock_data.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/action_button.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/color_swatch_picker.dart';
import '../widgets/file_info_card.dart';
import '../widgets/info_spec_card.dart';
import '../widgets/spec_selector.dart';
import '../widgets/top_bar.dart';
import '../widgets/upload_zone.dart';

class IdPhotoPage extends StatefulWidget {
  const IdPhotoPage({super.key});

  @override
  State<IdPhotoPage> createState() => _IdPhotoPageState();
}

class _IdPhotoPageState extends State<IdPhotoPage> {
  bool _hasFile = false;
  String _specId = 'one-inch';
  String _colorId = 'white';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: 'AI证件照', showBack: true, backTo: '/tools'),
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
                          title: '上传您的照片',
                          formats: '支持 JPG · PNG · HEIC',
                          hasFile: false,
                          onTap: () => setState(() => _hasFile = true),
                        ),
                ),
                // Spec + Color card
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildSpecColorCard(),
                ),
                // InfoSpecCard
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: InfoSpecCard(
                    title: '规格说明',
                    items: MockData.idPhotoSpecInfo,
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
                    label: _hasFile ? '立即生成证件照' : '请先上传照片',
                    variant: _hasFile
                        ? ActionButtonVariant.primary
                        : ActionButtonVariant.ghost,
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
      decoration: const BoxDecoration(gradient: AppGradients.idPhotoHero),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _IdPhotoHeroGlowPainter())),
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
                child: const Icon(LucideIcons.userSquare,
                    size: 26, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'AI 证件照制作',
                      style: AppTheme.display(
                        size: 19,
                        weight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '一键生成标准证件照',
                      style: AppTheme.sans(
                        size: 11.5,
                        color: const Color(0xB8FFFFFF),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: ['智能抠图', '多种规格', '标准背景']
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

  // ── Spec + Color card ──
  Widget _buildSpecColorCard() {
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
          Text(
            '选择证件照规格',
            style: AppTheme.sans(
              size: 12.5,
              weight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 10),
          SpecSelector(
            specs: MockData.specs,
            activeId: _specId,
            onChanged: (id) => setState(() => _specId = id),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 14),
            height: 1,
            color: const Color(0xFFF0ECE0),
          ),
          Text(
            '选择背景颜色',
            style: AppTheme.sans(
              size: 12.5,
              weight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 12),
          ColorSwatchPicker(
            colors: MockData.bgColors,
            activeId: _colorId,
            onChanged: (id) => setState(() => _colorId = id),
          ),
        ],
      ),
    );
  }

  // ── Tips card ──
  Widget _buildTipsCard() {
    final tips = [
      '面部清晰，正面免冠拍摄效果最佳',
      '背景简洁纯色，有助于抠图精准',
      '支持 JPG、PNG，建议分辨率 600px 以上',
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
                '拍摄建议',
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

class _IdPhotoHeroGlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // teal-mint glow at 78% / 18%
    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.18),
      size.width * 0.52,
      Paint()
        ..shader = RadialGradient(
          colors: [const Color(0x47B4DCD2), Colors.transparent],
        ).createShader(Rect.fromCircle(
            center: Offset(size.width * 0.78, size.height * 0.18),
            radius: size.width * 0.52)),
    );
    // white glow at 12% / 85%
    canvas.drawCircle(
      Offset(size.width * 0.12, size.height * 0.85),
      size.width * 0.4,
      Paint()
        ..shader = RadialGradient(
          colors: [const Color(0x0FFFFFFF), Colors.transparent],
        ).createShader(Rect.fromCircle(
            center: Offset(size.width * 0.12, size.height * 0.85),
            radius: size.width * 0.4)),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
