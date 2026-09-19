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

class ImageConvertPage extends StatefulWidget {
  const ImageConvertPage({super.key});

  @override
  State<ImageConvertPage> createState() => _ImageConvertPageState();
}

class _ImageConvertPageState extends State<ImageConvertPage> {
  bool _hasFile = false;
  String _targetFmt = 'png'; // default PNG active

  String get _srcExt {
    final name = MockData.imageCompressFile.name;
    final dot = name.lastIndexOf('.');
    if (dot >= 0 && dot < name.length - 1) {
      return name.substring(dot + 1).toUpperCase();
    }
    return 'JPG';
  }

  static const _fmts = <_Fmt>[
    _Fmt('jpg', 'JPG', '通用 · 最小'),
    _Fmt('png', 'PNG', '透明 · 无损'),
    _Fmt('webp', 'WEBP', '网页优化'),
    _Fmt('bmp', 'BMP', '位图原格式'),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '图片格式转换', showBack: true, backTo: '/tools'),
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
                          formats: '支持 JPG · PNG · WEBP · BMP · GIF',
                          hasFile: false,
                          onTap: () => setState(() => _hasFile = true),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildFormatCard(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildTipsCard(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                  child: ActionButton(
                    label: _hasFile
                        ? '转换为 ${_targetFmt.toUpperCase()}'
                        : '请先上传图片',
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
      decoration: const BoxDecoration(gradient: AppGradients.convertHero),
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
            child: Icon(AppIcons.resolve('RefreshCwIcon'),
                size: 26, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '图片格式转换',
                  style: AppTheme.display(
                    size: 19,
                    weight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '多格式互转 · 无损品质 · 极速完成',
                  style: AppTheme.sans(
                    size: 11.5,
                    color: const Color(0xB3FFFFFF),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: ['JPG/PNG/WEBP', '批量转换', '原图画质']
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

  // ── Format card ──
  Widget _buildFormatCard() {
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
              Icon(AppIcons.resolve('RefreshCwIcon'),
                  size: 14, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '选择目标格式',
                style: AppTheme.sans(
                  size: 13.5,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Arrow indicator row
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Source pill + label below
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _pill(_srcExt, AppColors.primary),
                    const SizedBox(height: 4),
                    Text('源文件格式',
                        style: AppTheme.sans(
                            size: 10, color: AppColors.mutedForeground)),
                  ],
                ),
                const SizedBox(width: 12),
                const Text('→',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600)),
                const SizedBox(width: 12),
                Text('转换为',
                    style: AppTheme.sans(
                        size: 10, color: AppColors.mutedForeground)),
                const SizedBox(width: 12),
                // Target pill (with invisible label to match height)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _pill(_targetFmt.toUpperCase(), AppColors.accent),
                    const SizedBox(height: 4),
                    Text('源文件格式',
                        style: AppTheme.sans(
                            size: 10, color: Colors.transparent)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 4 format buttons
          Row(
            children: [
              for (int i = 0; i < _fmts.length; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(child: _buildFmtBtn(_fmts[i])),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill(String text, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: AppTheme.display(
          size: 13,
          weight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFmtBtn(_Fmt f) {
    final active = f.id == _targetFmt;
    return GestureDetector(
      onTap: () => setState(() => _targetFmt = f.id),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: active ? AppColors.primary : AppColors.border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              f.name,
              style: AppTheme.sans(
                size: 12.5,
                weight: FontWeight.w600,
                color: active ? Colors.white : AppColors.foreground,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              f.desc,
              style: AppTheme.sans(
                size: 9.5,
                color: active
                    ? Colors.white.withValues(alpha: 0.85)
                    : AppColors.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Tips card ──
  Widget _buildTipsCard() {
    final tips = [
      'PNG 支持透明背景，适合 Logo 素材',
      'WEBP 比 JPG 体积小 30%，适合网页',
      '转换过程不压缩，保留原始画质',
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
                '格式说明',
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

class _Fmt {
  final String id;
  final String name;
  final String desc;
  const _Fmt(this.id, this.name, this.desc);
}
