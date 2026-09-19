import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/top_bar.dart';

/// 下载记录 page — route `/downloads`.
/// Mirrors src/pages/Downloads.tsx.
class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  String _activeFilter = 'all';
  final Set<String> _removedIds = <String>{};

  static const _filters = <_Filter>[
    _Filter(id: 'all', label: '全部'),
    _Filter(id: 'image', label: '图片'),
    _Filter(id: 'pdf', label: 'PDF'),
  ];

  static const _dateGroups = ['今天', '昨天', '本周', '更早'];

  List<DownloadItem> get _displayed => MockData.downloads.where((d) {
        if (_removedIds.contains(d.id)) return false;
        if (_activeFilter != 'all' && d.type != _activeFilter) return false;
        return true;
      }).toList();

  @override
  Widget build(BuildContext context) {
    final displayed = _displayed;
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '下载记录', showBack: true, backTo: '/profile'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 32),
              children: [
                _buildStatsBanner(displayed.length),
                _buildFilterTabs(),
                if (displayed.isEmpty)
                  _buildEmptyState()
                else
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final g in _dateGroups) _buildGroup(g, displayed),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Stats banner ──
  Widget _buildStatsBanner(int count) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppGradients.promo,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
            ),
            alignment: Alignment.center,
            child: const Icon(LucideIcons.folderOpen,
                size: 20, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '已保存文件',
                  style: AppTheme.sans(
                    size: 11,
                    color: Colors.white.withValues(alpha: 0.70),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$count 个文件',
                      style: AppTheme.display(
                        size: 18,
                        weight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '共 5.9 MB',
                      style: AppTheme.sans(
                        size: 11,
                        weight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.70),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          PressableScale(
            onTap: () {},
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(999),
                border:
                    Border.all(color: Colors.white.withValues(alpha: 0.25)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.download, size: 11, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    '导出',
                    style: AppTheme.sans(
                      size: 11.5,
                      weight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Filter tabs ──
  Widget _buildFilterTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < _filters.length; i++) ...[
              if (i > 0) const SizedBox(width: 8),
              _buildFilterPill(_filters[i]),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilterPill(_Filter f) {
    final active = _activeFilter == f.id;
    return PressableScale(
      onTap: () => setState(() => _activeFilter = f.id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : const Color(0xFFF0F6F2),
          borderRadius: BorderRadius.circular(999),
          border: active
              ? null
              : Border.all(color: const Color(0x1A1F4B39)), // rgba(31,75,57,0.10)
        ),
        child: Text(
          f.label,
          style: AppTheme.sans(
            size: 12,
            weight: FontWeight.w500,
            color: active ? Colors.white : AppColors.midSage,
          ),
        ),
      ),
    );
  }

  // ── Grouped list ──
  Widget _buildGroup(String group, List<DownloadItem> displayed) {
    final items = displayed.where((d) => d.group == group).toList();
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              group,
              style: AppTheme.sans(
                size: 12,
                weight: FontWeight.w600,
                color: AppColors.mutedForeground,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(24),
              boxShadow: AppShadows.soft,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                for (int i = 0; i < items.length; i++) ...[
                  _buildItem(items[i]),
                  if (i < items.length - 1)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 1,
                      color: const Color(0xFFF1EDE1),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(DownloadItem item) {
    final isImage = item.type == 'image';
    final isPdf = item.type == 'pdf';
    final Color iconBg = isImage
        ? const Color(0xFFEEF6F0)
        : isPdf
            ? const Color(0xFFF8EEEE)
            : const Color(0xFFF0F0F0);
    final IconData iconData =
        isImage ? LucideIcons.image : LucideIcons.file;
    final Color iconColor = isImage
        ? AppColors.midSage
        : isPdf
            ? AppColors.dangerText
            : AppColors.mutedForeground;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Icon(iconData, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.sans(
                    size: 12.5,
                    weight: FontWeight.w600,
                    color: AppColors.foreground,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        item.size,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.sans(
                            size: 10, color: AppColors.placeholderGray),
                      ),
                    ),
                    Text(
                      ' · ',
                      style: AppTheme.sans(
                          size: 10, color: const Color(0xFFD0CCC4)),
                    ),
                    Flexible(
                      child: Text(
                        '来自 ${item.toolName}',
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.sans(
                            size: 10, color: AppColors.placeholderGray),
                      ),
                    ),
                    Text(
                      ' · ',
                      style: AppTheme.sans(
                          size: 10, color: const Color(0xFFD0CCC4)),
                    ),
                    Flexible(
                      child: Text(
                        item.date,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.sans(
                            size: 10, color: AppColors.placeholderGray),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _IconCircle(
                bg: const Color(0xFFEEF6F0),
                icon: LucideIcons.download,
                iconSize: 13,
                iconColor: AppColors.midSage,
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _IconCircle(
                bg: const Color(0xFFFDF0F0),
                icon: LucideIcons.trash2,
                iconSize: 12,
                iconColor: AppColors.dangerText,
                onTap: () => setState(() => _removedIds.add(item.id)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Empty state ──
  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('📁', style: TextStyle(fontSize: 36, height: 1)),
          const SizedBox(height: 12),
          Text(
            '暂无下载记录',
            style: AppTheme.sans(size: 14, color: AppColors.placeholderGray),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Private helpers
// ─────────────────────────────────────────────────────────────────────────────

class _Filter {
  const _Filter({required this.id, required this.label});
  final String id;
  final String label;
}

/// Small circular icon button used for per-row download / trash actions.
class _IconCircle extends StatelessWidget {
  const _IconCircle({
    required this.bg,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    required this.onTap,
  });

  final Color bg;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: iconSize, color: iconColor),
      ),
    );
  }
}
