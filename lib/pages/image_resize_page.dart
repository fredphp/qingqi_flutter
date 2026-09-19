import 'package:flutter/material.dart';
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
import '../widgets/file_info_card.dart';
import '../widgets/top_bar.dart';
import '../widgets/upload_zone.dart';

class ImageResizePage extends StatefulWidget {
  const ImageResizePage({super.key});

  @override
  State<ImageResizePage> createState() => _ImageResizePageState();
}

class _ImageResizePageState extends State<ImageResizePage> {
  bool _hasFile = false;
  String _activePreset = 'p1'; // 1:1 default
  bool _locked = true;
  final TextEditingController _widthCtrl =
      TextEditingController(text: '800');
  final TextEditingController _heightCtrl =
      TextEditingController(text: '800');

  @override
  void dispose() {
    _widthCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  static const _presets = <_Preset>[
    _Preset('p1', '1:1 方形', '800', '800'),
    _Preset('p2', '16:9 横版', '1280', '720'),
    _Preset('p3', '9:16 竖版', '720', '1280'),
    _Preset('p4', '4:3 标准', '1024', '768'),
    _Preset('p5', '自定义', '', ''),
  ];

  int _computeHeightFromWidth(int w, String presetId) {
    switch (presetId) {
      case 'p1':
        return w; // 1:1
      case 'p2':
        return (w * 9 / 16).round(); // 16:9
      case 'p3':
        return (w * 16 / 9).round(); // 9:16
      case 'p4':
        return (w * 3 / 4).round(); // 4:3
      default:
        return 0; // custom — no auto
    }
  }

  void _onPresetTap(String id) {
    setState(() {
      _activePreset = id;
      final p = _presets.firstWhere((e) => e.id == id);
      if (id != 'p5') {
        _widthCtrl.text = p.w;
        _heightCtrl.text = p.h;
        _locked = true;
      } else {
        _locked = false;
      }
    });
  }

  void _onWidthChanged(String v) {
    final w = int.tryParse(v) ?? 0;
    if (_locked && _activePreset != 'p5') {
      final h = _computeHeightFromWidth(w, _activePreset);
      _heightCtrl.text = h.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '图片尺寸调整', showBack: true, backTo: '/tools'),
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
                  child: _buildResizeCard(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildTipsCard(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                  child: ActionButton(
                    label: _hasFile ? '开始调整尺寸' : '请先上传图片',
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
      decoration: const BoxDecoration(gradient: AppGradients.resizeHero),
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
            child: Icon(AppIcons.resolve('RulerIcon'),
                size: 26, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '图片尺寸调整',
                  style: AppTheme.display(
                    size: 19,
                    weight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '精准裁剪 · 等比缩放 · 高清输出',
                  style: AppTheme.sans(
                    size: 11.5,
                    color: const Color(0xB3FFFFFF),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: ['自定义尺寸', '等比缩放', '批量处理']
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

  // ── Resize settings card ──
  Widget _buildResizeCard() {
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
              Icon(AppIcons.resolve('RulerIcon'),
                  size: 14, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '输出尺寸',
                style: AppTheme.sans(
                  size: 13.5,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Preset buttons (wrap)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _presets.map((p) {
              final active = p.id == _activePreset;
              return GestureDetector(
                onTap: () => _onPresetTap(p.id),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.primary
                        : AppColors.primary.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: active
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Text(
                    p.label,
                    style: AppTheme.sans(
                      size: 12,
                      weight: FontWeight.w500,
                      color: active ? Colors.white : AppColors.primary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          // W / lock / H row
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _buildDimInput(
                  label: '宽度 (px)',
                  controller: _widthCtrl,
                  onChanged: _onWidthChanged,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => setState(() => _locked = !_locked),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 36,
                  height: 36,
                  margin: const EdgeInsets.only(bottom: 1),
                  decoration: BoxDecoration(
                    color: _locked ? AppColors.primary : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    _locked
                        ? AppIcons.resolve('LockIcon')
                        : AppIcons.resolve('UnlockIcon'),
                    size: 14,
                    color: _locked ? Colors.white : AppColors.foreground,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDimInput(
                  label: '高度 (px)',
                  controller: _heightCtrl,
                  readOnly: _locked,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _locked
                ? '🔒 等比锁定：宽度变化时高度自动同步'
                : '🔓 自由模式：宽高独立设置',
            style: AppTheme.sans(
              size: 10.5,
              color: AppColors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDimInput({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.sans(size: 11.5, color: AppColors.mutedForeground),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: readOnly
                ? AppColors.primary.withValues(alpha: 0.06)
                : const Color(0xFFF7F4EE),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.22)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextField(
            controller: controller,
            readOnly: readOnly,
            keyboardType: TextInputType.number,
            onChanged: onChanged,
            style: AppTheme.sans(
              size: 13,
              weight: FontWeight.w600,
              color: AppColors.primary,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ],
    );
  }

  // ── Tips card ──
  Widget _buildTipsCard() {
    final tips = [
      '支持 JPG / PNG / WEBP / BMP 格式',
      '等比锁定模式自动计算另一边长度',
      '输出最大支持 8000 × 8000 像素',
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

class _Preset {
  final String id;
  final String label;
  final String w;
  final String h;
  const _Preset(this.id, this.label, this.w, this.h);
}
