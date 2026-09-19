import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
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

class ImageWatermarkPage extends StatefulWidget {
  const ImageWatermarkPage({super.key});

  @override
  State<ImageWatermarkPage> createState() => _ImageWatermarkPageState();
}

class _ImageWatermarkPageState extends State<ImageWatermarkPage> {
  bool _hasFile = false;
  final TextEditingController _watermarkCtrl =
      TextEditingController(text: '© 轻启AI');
  String _position = 'bot-right';
  double _opacity = 35;
  double _fontSize = 18;
  double _rotation = -30;
  bool _tile = false;

  static const _presetTexts = ['© 轻启AI', '保密文件', '仅供参考', '禁止传播'];

  static const _positions = <_Pos>[
    _Pos('top-left', '↖'),
    _Pos('top-mid', '↑'),
    _Pos('top-right', '↗'),
    _Pos('mid-left', '←'),
    _Pos('center', '✕'),
    _Pos('mid-right', '→'),
    _Pos('bot-left', '↙'),
    _Pos('bot-mid', '↓'),
    _Pos('bot-right', '↘'),
  ];

  static const _previewUrl =
      'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=400&q=80';

  @override
  void dispose() {
    _watermarkCtrl.dispose();
    super.dispose();
  }

  Alignment _alignFromPosition(String pos) {
    switch (pos) {
      case 'top-left':
        return Alignment.topLeft;
      case 'top-mid':
        return Alignment.topCenter;
      case 'top-right':
        return Alignment.topRight;
      case 'mid-left':
        return Alignment.centerLeft;
      case 'center':
        return Alignment.center;
      case 'mid-right':
        return Alignment.centerRight;
      case 'bot-left':
        return Alignment.bottomLeft;
      case 'bot-mid':
        return Alignment.bottomCenter;
      case 'bot-right':
        return Alignment.bottomRight;
      default:
        return Alignment.bottomRight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '图片加水印', showBack: true, backTo: '/tools'),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildHero(),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildTextCard(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildStyleCard(),
                ),
                // Position picker card — collapses when tile=true
                AnimatedSize(
                  duration: const Duration(milliseconds: 240),
                  curve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  child: _tile
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: _buildPositionCard(),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildPreviewPill(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildTipsCard(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                  child: ActionButton(
                    label: _hasFile ? '添加水印并导出' : '请先上传图片',
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
      decoration: const BoxDecoration(gradient: AppGradients.watermarkHero),
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
            child: Icon(AppIcons.resolve('PaletteIcon'),
                size: 26, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '图片加水印',
                  style: AppTheme.display(
                    size: 19,
                    weight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '自定义文字 · 调整位置与透明度',
                  style: AppTheme.sans(
                    size: 11.5,
                    color: const Color(0xB3FFFFFF),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: ['文字水印', '自由定位', '批量处理']
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

  // ── Watermark text card ──
  Widget _buildTextCard() {
    const watermarkColor = Color(0xFF4A2E1F);
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
              Icon(AppIcons.resolve('TypeIcon'),
                  size: 14, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '水印文字',
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F4EE),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: watermarkColor.withValues(alpha: 0.22)),
            ),
            child: TextField(
              controller: _watermarkCtrl,
              maxLength: 30,
              onChanged: (_) => setState(() {}),
              style: AppTheme.sans(
                size: 13.5,
                weight: FontWeight.w600,
                color: watermarkColor,
              ),
              decoration: InputDecoration(
                hintText: '输入水印文字...',
                hintStyle: AppTheme.sans(
                    size: 13.5, color: AppColors.placeholderGray),
                border: InputBorder.none,
                counterText: '',
                isDense: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _presetTexts.map((t) {
              final active = _watermarkCtrl.text == t;
              return GestureDetector(
                onTap: () => setState(() => _watermarkCtrl.text = t),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: active
                        ? watermarkColor.withValues(alpha: 0.18)
                        : watermarkColor.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: active
                          ? watermarkColor.withValues(alpha: 0.35)
                          : watermarkColor.withValues(alpha: 0.14),
                    ),
                  ),
                  child: Text(
                    t,
                    style: AppTheme.sans(
                      size: 11.5,
                      weight: FontWeight.w500,
                      color: watermarkColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ── Style settings card ──
  Widget _buildStyleCard() {
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
              Icon(AppIcons.resolve('PaletteIcon'),
                  size: 14, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '样式设置',
                style: AppTheme.sans(
                  size: 13.5,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _SliderRow(
            label: '字体大小',
            value: _fontSize,
            min: 10,
            max: 48,
            unit: 'px',
            onChanged: (v) => setState(() => _fontSize = v),
          ),
          const SizedBox(height: 14),
          _SliderRow(
            label: '透明度',
            value: _opacity,
            min: 10,
            max: 100,
            unit: '%',
            onChanged: (v) => setState(() => _opacity = v),
          ),
          const SizedBox(height: 14),
          _SliderRow(
            label: '旋转角度',
            value: _rotation,
            min: -90,
            max: 0,
            unit: '°',
            onChanged: (v) => setState(() => _rotation = v),
          ),
          const SizedBox(height: 16),
          // Tile toggle row
          _buildTileToggle(),
        ],
      ),
    );
  }

  Widget _buildTileToggle() {
    return Row(
      children: [
        Icon(AppIcons.resolve('RotateCwIcon'),
            size: 14, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          '平铺水印',
          style: AppTheme.sans(
            size: 12.5,
            weight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '铺满整张图片',
            style: AppTheme.sans(size: 10.5, color: AppColors.mutedForeground),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => _tile = !_tile),
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 44,
            height: 24,
            decoration: BoxDecoration(
              color: _tile
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  left: _tile ? 22 : 2,
                  top: 2,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: AppShadows.soft,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Position picker card ──
  Widget _buildPositionCard() {
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
              Icon(AppIcons.resolve('MoveIcon'),
                  size: 14, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '水印位置',
                style: AppTheme.sans(
                  size: 13.5,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
            children: _positions.map((p) {
              final active = p.id == _position;
              return GestureDetector(
                onTap: () => setState(() => _position = p.id),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary : AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: active ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    p.symbol,
                    style: AppTheme.sans(
                      size: 16,
                      weight: FontWeight.w600,
                      color: active ? Colors.white : AppColors.foreground,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ── Live preview pill ──
  Widget _buildPreviewPill() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.20),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          // Preview image with watermark overlay
          SizedBox(
            width: 150,
            height: 90,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned.fill(
                    child: NetImage(_previewUrl,
                        width: 150, height: 90, fit: BoxFit.cover),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: _alignFromPosition(_position),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Transform.rotate(
                          angle: _rotation * 3.14159265 / 180,
                          child: Text(
                            _watermarkCtrl.text,
                            style: TextStyle(
                              fontSize: _fontSize.toDouble(),
                              color: Colors.white
                                  .withValues(alpha: _opacity / 100),
                              fontWeight: FontWeight.w600,
                              shadows: const [
                                Shadow(
                                  color: Colors.black54,
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '效果预览',
                  style: AppTheme.sans(
                    size: 11,
                    weight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '实际效果以导出为准',
                  style: AppTheme.sans(
                      size: 10, color: AppColors.mutedForeground),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Tips card ──
  Widget _buildTipsCard() {
    final tips = [
      '水印文字支持中英文、Emoji',
      '可调整字体大小与透明度保持美观',
      '批量处理时所有图片使用相同设置',
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

// ── Slider row widget ──
class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.unit,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final String unit;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final displayValue = value.round().toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTheme.sans(
                size: 12,
                weight: FontWeight.w600,
                color: AppColors.mutedForeground,
              ),
            ),
            const Spacer(),
            Text(
              '$displayValue$unit',
              style: AppTheme.sans(
                size: 12.5,
                weight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            final trackW = constraints.maxWidth;
            final ratio =
                ((value - min) / (max - min)).clamp(0.0, 1.0);
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (d) {
                final r = (d.localPosition.dx / trackW).clamp(0.0, 1.0);
                onChanged(min + r * (max - min));
              },
              onPanUpdate: (d) {
                final r = (d.localPosition.dx / trackW).clamp(0.0, 1.0);
                onChanged(min + r * (max - min));
              },
              child: SizedBox(
                height: 24,
                width: trackW,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.centerLeft,
                  children: [
                    // bg track
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 8,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    // gradient fill
                    Positioned(
                      left: 0,
                      top: 8,
                      width: trackW * ratio,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF1F4B39),
                              Color(0xFF4A7D3F)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    // thumb
                    Positioned(
                      left: (trackW * ratio) - 10,
                      top: 2,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.primary, width: 1.5),
                          boxShadow: AppShadows.soft,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _Pos {
  final String id;
  final String symbol;
  const _Pos(this.id, this.symbol);
}
