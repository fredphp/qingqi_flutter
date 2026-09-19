import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../data/mock_data.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/top_bar.dart';

/// Favorites / 收藏工具 page — route `/favorites`.
/// Mirrors src/pages/Favorites.tsx.
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String _activeCategory = '全部'; // 全部 | 图片处理 | PDF工具 | 生活工具 | 办公效率
  String _searchText = '';
  final Set<String> _removedIds = <String>{};

  static const _categories = <String>[
    '全部',
    '图片处理',
    'PDF工具',
    '生活工具',
    '办公效率',
  ];

  List<FavTool> get _displayed {
    final q = _searchText.trim().toLowerCase();
    return MockData.favTools.where((t) {
      if (_removedIds.contains(t.id)) return false;
      final matchCat =
          _activeCategory == '全部' || t.category.label == _activeCategory;
      final matchQuery =
          q.isEmpty || t.name.toLowerCase().contains(q);
      return matchCat && matchQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _displayed;
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '收藏工具', showBack: true, backTo: '/profile'),
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
                      placeholder: '搜索收藏的工具…',
                    ),
                  ),
                  // Category tabs
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    height: 34,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        final c = _categories[i];
                        final active = _activeCategory == c;
                        return GestureDetector(
                          onTap: () => setState(() => _activeCategory = c),
                          behavior: HitTestBehavior.opaque,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: active
                                  ? AppColors.primary
                                  : const Color(0xFFF0F6F2),
                              borderRadius: BorderRadius.circular(999),
                              border: active
                                  ? null
                                  : Border.all(
                                      color: AppColors.primary
                                          .withValues(alpha: 0.10),
                                    ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              c,
                              style: AppTheme.sans(
                                size: 12,
                                weight: FontWeight.w500,
                                color: active
                                    ? Colors.white
                                    : AppColors.midSage,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Count + sort row
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Row(
                      children: [
                        const Icon(LucideIcons.bookmark,
                            size: 13, color: AppColors.midSage),
                        const SizedBox(width: 4),
                        Text(
                          '${list.length} 个工具',
                          style: AppTheme.sans(
                              size: 12.5, color: AppColors.mutedForeground),
                        ),
                        const Spacer(),
                        const Icon(LucideIcons.zap,
                            size: 11, color: AppColors.accent),
                        const SizedBox(width: 4),
                        Text(
                          '按使用频率排序',
                          style: AppTheme.sans(
                              size: 11.5, color: AppColors.placeholderGray),
                        ),
                      ],
                    ),
                  ),
                  // Fav cards OR empty state
                  if (list.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 56),
                      child: _buildEmpty(),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: Column(
                        children: list
                            .map((t) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _FavCard(
                                    tool: t,
                                    onRemove: () => setState(
                                        () => _removedIds.add(t.id)),
                                  ),
                                ))
                            .toList(),
                      ),
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
        const Text('🌿', style: TextStyle(fontSize: 36, height: 1)),
        const SizedBox(height: 12),
        Text(
          hasSearch ? '没有匹配的工具' : '还没有收藏的工具',
          style: AppTheme.sans(
              size: 13.5, color: AppColors.placeholderGray, height: 1.4),
        ),
        const SizedBox(height: 16),
        PressableScale(
          onTap: () => AppRoutes.go(context, AppRoutes.tools),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '去发现工具',
              style: AppTheme.sans(
                size: 13,
                weight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
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

class _FavCard extends StatelessWidget {
  const _FavCard({required this.tool, required this.onRemove});
  final FavTool tool;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.soft,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top row
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: tool.tint,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(tool.emoji,
                      style: const TextStyle(fontSize: 22, height: 1)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              tool.name,
                              style: AppTheme.sans(
                                size: 13.5,
                                weight: FontWeight.w600,
                                color: AppColors.foreground,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F6F2),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              tool.category.label,
                              style: AppTheme.sans(
                                size: 9.5,
                                color: AppColors.midSage,
                                height: 1.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        tool.desc,
                        style: AppTheme.sans(
                            size: 11.5, color: AppColors.mutedForeground),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(LucideIcons.star,
                              size: 10, color: AppColors.accent),
                          const SizedBox(width: 3),
                          Text(
                            tool.usage,
                            style: AppTheme.sans(
                                size: 10.5,
                                color: AppColors.placeholderGray),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '·',
                            style: AppTheme.sans(
                                size: 10.5, color: AppColors.timeGray),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tool.savedAt,
                            style: AppTheme.sans(
                                size: 10.5, color: AppColors.timeGray),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Action row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFF1EDE1), width: 1),
              ),
            ),
            child: Row(
              children: [
                // Remove button
                GestureDetector(
                  onTap: onRemove,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(LucideIcons.trash2,
                          size: 12, color: AppColors.dangerText),
                      const SizedBox(width: 4),
                      Text(
                        '移除',
                        style: AppTheme.sans(
                            size: 12, color: AppColors.dangerText),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Use button
                PressableScale(
                  onTap: () => AppRoutes.go(context, tool.route),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: AppGradients.assistantBubble,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '立即使用',
                          style: AppTheme.sans(
                            size: 12,
                            weight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(LucideIcons.chevronRight,
                            size: 12, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
