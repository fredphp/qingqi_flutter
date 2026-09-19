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
import '../widgets/common.dart';
import '../widgets/top_bar.dart';

class PdfMergePage extends StatefulWidget {
  const PdfMergePage({super.key});

  @override
  State<PdfMergePage> createState() => _PdfMergePageState();
}

class _PdfMergePageState extends State<PdfMergePage> {
  final List<MergeFile> _files = [];
  int _supplementCount = 0;
  static const int _maxFiles = 20;

  void _addFile() {
    if (_files.length >= _maxFiles) return;
    setState(() {
      if (_files.isEmpty) {
        _files.addAll(MockData.initialMergeFiles);
      } else {
        _supplementCount += 1;
        _files.add(MergeFile(
          name: '补充材料_$_supplementCount.pdf',
          pages: 3,
          size: '0.4 MB',
        ));
      }
    });
  }

  void _moveUp(int index) {
    if (index <= 0) return;
    setState(() {
      final f = _files.removeAt(index);
      _files.insert(index - 1, f);
    });
  }

  void _moveDown(int index) {
    if (index >= _files.length - 1) return;
    setState(() {
      final f = _files.removeAt(index);
      _files.insert(index + 1, f);
    });
  }

  void _remove(int index) {
    setState(() {
      _files.removeAt(index);
    });
  }

  int get _totalPages => _files.fold(0, (s, f) => s + f.pages);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: 'PDF 合并', showBack: true, backTo: '/tools'),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildHero(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildFileListCard(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildTipsCard(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
                  child: ActionButton(
                    label: _files.isEmpty
                        ? '请先添加 PDF 文件'
                        : _files.length == 1
                            ? '至少需要 2 个文件'
                            : '合并 ${_files.length} 份 PDF',
                    variant: _files.length >= 2
                        ? ActionButtonVariant.primary
                        : ActionButtonVariant.ghost,
                    radius: ActionButtonRadius.full,
                    disabled: _files.length < 2,
                    onTap: _files.length >= 2
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
      decoration: const BoxDecoration(gradient: AppGradients.pdfMergeHero),
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
                  'PDF 合并',
                  style: AppTheme.display(
                    size: 19,
                    weight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '多份文件一键合并 · 自由排序',
                  style: AppTheme.sans(
                    size: 11.5,
                    color: const Color(0xB3FFFFFF),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: ['拖拽排序', '最多20份', '保留格式']
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

  // ── File list card ──
  Widget _buildFileListCard() {
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
              Icon(AppIcons.resolve('FileTextIcon'),
                  size: 14, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                '已添加文件 (${_files.length}/20)',
                style: AppTheme.sans(
                  size: 13.5,
                  weight: FontWeight.w600,
                  color: AppColors.foreground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_files.isEmpty)
            _buildEmptyState()
          else
            for (int i = 0; i < _files.length; i++) ...[
              _buildFileRow(_files[i], i),
              if (i != _files.length - 1) const SizedBox(height: 10),
            ],
          if (_files.isNotEmpty) const SizedBox(height: 12),
          _buildAddButton(),
          if (_files.length >= 2) ...[
            const SizedBox(height: 12),
            _buildSummary(),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          // dashed approximated with solid
          color: AppColors.primary.withValues(alpha: 0.18),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(AppIcons.resolve('FileTextIcon'),
              size: 28,
              color: AppColors.primary.withValues(alpha: 0.3)),
          const SizedBox(height: 8),
          Text(
            '还未添加任何文件',
            style: AppTheme.sans(size: 12, color: AppColors.mutedForeground),
          ),
        ],
      ),
    );
  }

  Widget _buildFileRow(MergeFile file, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.10)),
      ),
      child: Row(
        children: [
          // Order badge
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${index + 1}',
              style: AppTheme.display(
                size: 12,
                weight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // File icon box (navy tint)
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF2A4060).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(AppIcons.resolve('FileTextIcon'),
                size: 18, color: const Color(0xFF2A4060)),
          ),
          const SizedBox(width: 10),
          // Filename + meta
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  file.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.sans(
                    size: 12.5,
                    weight: FontWeight.w600,
                    color: AppColors.foreground,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${file.pages}页 · ${file.size}',
                  style: AppTheme.sans(
                    size: 10.5,
                    color: AppColors.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Up/down reorder
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ReorderBtn(
                icon: AppIcons.resolve('ChevronUpIcon'),
                disabled: index == 0,
                onTap: () => _moveUp(index),
              ),
              const SizedBox(height: 4),
              _ReorderBtn(
                icon: AppIcons.resolve('ChevronDownIcon'),
                disabled: index == _files.length - 1,
                onTap: () => _moveDown(index),
              ),
            ],
          ),
          const SizedBox(width: 8),
          // Remove
          GestureDetector(
            onTap: () => _remove(index),
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.dangerStrong.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(AppIcons.resolve('XIcon'),
                  size: 12, color: AppColors.dangerStrong),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    final atCap = _files.length >= _maxFiles;
    return PressableScale(
      onTap: atCap ? null : _addFile,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(16),
          // dashed approximated with solid
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.35),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(AppIcons.resolve('PlusIcon'),
                size: 16, color: AppColors.primary),
            const SizedBox(width: 6),
            Text(
              '添加 PDF 文件',
              style: AppTheme.sans(
                size: 13,
                weight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.30)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '合并后共 ${_files.length} 个文件 · $_totalPages 页',
              style: AppTheme.sans(
                size: 11.5,
                color: AppColors.goldBrown2,
              ),
            ),
          ),
          Text(
            '预计输出',
            style: AppTheme.sans(
              size: 10.5,
              weight: FontWeight.w600,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  // ── Tips card ──
  Widget _buildTipsCard() {
    final tips = [
      '最多同时合并 20 份 PDF 文档',
      '拖拽排序按钮可调整文件先后顺序',
      '合并后保留原始书签与超链接',
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

class _ReorderBtn extends StatelessWidget {
  const _ReorderBtn({
    required this.icon,
    required this.disabled,
    required this.onTap,
  });
  final IconData icon;
  final bool disabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.3 : 1.0,
      child: GestureDetector(
        onTap: disabled ? null : onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 24,
          height: 22,
          alignment: Alignment.center,
          child: Icon(icon, size: 14, color: AppColors.primary),
        ),
      ),
    );
  }
}
