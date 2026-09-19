import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_data.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/top_bar.dart';

/// History / 历史记录 page — route `/history`.
/// Mirrors src/pages/History.tsx.
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String _searchText = '';
  final Set<String> _clearedGroups = <String>{};

  static const _groupOrder = <String>['今天', '昨天', '本周', '更早'];

  List<HistoryItem> get _filtered {
    final q = _searchText.trim().toLowerCase();
    return MockData.historyItems.where((h) {
      if (_clearedGroups.contains(h.group)) return false;
      if (q.isEmpty) return true;
      return h.toolName.toLowerCase().contains(q) ||
          h.action.toLowerCase().contains(q) ||
          h.detail.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    // Build grouped buckets
    final Map<String, List<HistoryItem>> groups = {};
    for (final g in _groupOrder) {
      groups[g] = filtered.where((h) => h.group == g).toList();
    }
    // Groups to show (non-empty after filter/clear)
    final visibleGroups =
        _groupOrder.where((g) => groups[g]!.isNotEmpty).toList();

    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '历史记录', showBack: true, backTo: '/profile'),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: _SearchBar(
                      value: _searchText,
                      onChanged: (v) => setState(() => _searchText = v),
                      placeholder: '搜索使用记录…',
                    ),
                  ),
                  if (filtered.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 56),
                      child: _buildEmpty(),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: Column(
                        children: [
                          for (final g in visibleGroups) ...[
                            _GroupBlock(
                              name: g,
                              items: groups[g]!,
                              onClearGroup: () => setState(
                                  () => _clearedGroups.add(g)),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ],
                      ),
                    ),
                  // Stats footer
                  if (filtered.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: _buildStatsFooter(filtered.length),
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    final hasSearch = _searchText.trim().isNotEmpty;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('📋', style: TextStyle(fontSize: 36, height: 1)),
        const SizedBox(height: 12),
        Text(
          hasSearch ? '没有匹配的记录' : '暂无使用记录',
          style: AppTheme.sans(
              size: 13.5, color: AppColors.placeholderGray, height: 1.4),
        ),
      ],
    );
  }

  Widget _buildStatsFooter(int count) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.tintWarmWhite, // #f8f6ef
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.history, size: 13, color: AppColors.placeholderGray),
          const SizedBox(width: 8),
          Text(
            '共使用了 $count 次 AI 工具',
            style: AppTheme.sans(size: 12, color: AppColors.placeholderGray),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Private widgets
// ─────────────────────────────────────────────────────────────────────────────

class _SearchBar extends StatefulWidget {
  const _SearchBar({
    required this.value,
    required this.onChanged,
    required this.placeholder,
  });

  final String value;
  final ValueChanged<String> onChanged;
  final String placeholder;

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant _SearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      final sel = _controller.selection;
      _controller.text = widget.value;
      if (_controller.text.length >= sel.start) {
        _controller.selection = sel;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F6F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.10)),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.search, size: 15, color: AppColors.mutedForeground),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              style: AppTheme.sans(size: 13, color: const Color(0xFF2A3A30)),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.placeholder,
                hintStyle: AppTheme.sans(
                    size: 13, color: AppColors.placeholderGray),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupBlock extends StatelessWidget {
  const _GroupBlock({
    required this.name,
    required this.items,
    required this.onClearGroup,
  });

  final String name;
  final List<HistoryItem> items;
  final VoidCallback onClearGroup;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Group header
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              const Icon(LucideIcons.calendar,
                  size: 12, color: AppColors.placeholderGray),
              const SizedBox(width: 4),
              Text(
                name,
                style: AppTheme.sans(
                  size: 12,
                  weight: FontWeight.w600,
                  color: AppColors.mutedForeground,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onClearGroup,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(LucideIcons.trash2,
                        size: 10, color: AppColors.dangerText),
                    SizedBox(width: 3),
                    Text(
                      '清除',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.dangerText,
                        fontFamily: 'Inter',
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Items container
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
                _HistoryRow(item: items[i]),
                if (i < items.length - 1)
                  const HDivider(color: Color(0xFFF1EDE1), thickness: 1),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.item});
  final HistoryItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRoutes.go(context, item.route),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: item.tint,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(item.emoji,
                  style: const TextStyle(fontSize: 18, height: 1)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.toolName,
                    style: AppTheme.sans(
                      size: 13,
                      weight: FontWeight.w600,
                      color: AppColors.foreground,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.action,
                    style: AppTheme.sans(
                        size: 11.5, color: AppColors.mutedForeground),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.detail,
                    style: AppTheme.sans(
                        size: 10.5, color: AppColors.placeholderGray),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(LucideIcons.clock,
                        size: 10, color: AppColors.timeGray),
                    const SizedBox(width: 3),
                    Text(
                      item.date,
                      style: AppTheme.sans(
                          size: 10, color: AppColors.timeGray),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Icon(LucideIcons.chevronRight,
                    size: 13, color: AppColors.timeGray),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
