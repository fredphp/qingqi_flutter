import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/category_tabs.dart';
import '../widgets/search_field.dart';
import '../widgets/tool_card.dart';

/// Tools / 工具中心 page — route `/tools`.
/// Mirrors src/pages/Tools.tsx.
class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  String _active = 'all';
  String _query = '';

  List<Tool> get _filteredList {
    final activeCat = MockData.categories.firstWhere(
      (c) => c.id == _active,
      orElse: () => MockData.categories.first,
    );
    final q = _query.trim().toLowerCase();
    return MockData.tools.where((t) {
      final matchCat = _active == 'all' || t.category.label == activeCat.label;
      final matchQuery = q.isEmpty ||
          t.name.toLowerCase().contains(q) ||
          t.description.toLowerCase().contains(q);
      return matchCat && matchQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    final list = _filteredList;
    return AppScaffold(
      activeTab: 'tools',
      child: Column(
        children: [
          // ── Header (gradient, non-scrolling) ──
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: topInset + 40,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              gradient: AppGradients.toolsHeader,
            ),
            child: Stack(
              children: [
                // Decorative leaf blobs
                Positioned(
                  top: -14,
                  right: 6,
                  child: _LeafBlob(opacity: 0.13, rotation: -28),
                ),
                Positioned(
                  top: 20,
                  right: 52,
                  child: Transform.scale(
                    scale: 0.6,
                    child: Transform.rotate(
                      angle: 55 * 3.14159265 / 180,
                      child: _LeafBlob(opacity: 0.09, rotation: 0),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -12,
                  left: -10,
                  child: Transform.scale(
                    scale: 0.75,
                    child: Transform.rotate(
                      angle: -38 * 3.14159265 / 180,
                      child: _LeafBlob(opacity: 0.11, rotation: 0),
                    ),
                  ),
                ),
                // Foreground content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title block
                    Text(
                      '工具中心',
                      style: AppTheme.display(
                        size: 24,
                        weight: FontWeight.w700,
                        color: AppColors.foreground,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '多种实用工具，满足你的日常需求',
                      style: AppTheme.sans(size: 12.5, color: AppColors.midSage),
                    ),
                    const SizedBox(height: 16),
                    // Stats strip (with backdrop blur to match React's backdrop-blur(10))
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0x94FFFFFF), // rgba(255,255,255,0.58)
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: const Color(0xB3FFFFFF)), // rgba(255,255,255,0.7)
                          ),
                          child: Row(
                            children: [
                              for (int i = 0; i < 3; i++) ...[
                                if (i > 0) ...[
                                  Container(
                                    width: 1,
                                    height: 28,
                                    color: AppColors.primary.withValues(alpha: 0.14),
                                    margin: const EdgeInsets.symmetric(horizontal: 8),
                                  ),
                                ],
                                Expanded(child: _StatPill(_statValues[i])),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Search field
                    SearchField(
                      variant: 'pill',
                      placeholder: '搜索工具名称',
                      value: _query,
                      onChanged: (v) => setState(() => _query = v),
                      onSearch: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Sticky category tabs ──
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xF2FAF7F1), // rgba(250,247,241,0.95)
              border: Border(
                bottom: BorderSide(
                  color: const Color(0x8CE8E2D5), // rgba(232,226,213,0.55)
                  width: 1,
                ),
              ),
            ),
            child: CategoryTabs(
              categories: MockData.categories,
              active: _active,
              onChanged: (id) => setState(() => _active = id),
            ),
          ),

          // ── Scrollable results ──
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Results count + clear search
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: '共 ',
                            style: AppTheme.sans(
                              size: 11.5,
                              color: AppColors.mutedForeground,
                            ),
                            children: [
                              TextSpan(
                                text: '${list.length}',
                                style: AppTheme.sans(
                                  size: 11.5,
                                  weight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                              const TextSpan(text: ' 个工具'),
                            ],
                          ),
                        ),
                        const Spacer(),
                        if (_query.trim().isNotEmpty)
                          GestureDetector(
                            onTap: () => setState(() => _query = ''),
                            behavior: HitTestBehavior.opaque,
                            child: Text(
                              '清除搜索',
                              style: AppTheme.sans(
                                size: 11,
                                weight: FontWeight.w500,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Grid OR empty state
                  if (list.isEmpty)
                    const _EmptyState()
                  else
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 2, 12, 16),
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.82,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: list
                            .map((t) => ToolCard(
                                  tool: t,
                                  onTap: () => AppRoutes.go(context, t.route),
                                ))
                            .toList(),
                      ),
                    ),
                  // Bottom spacing to clear bottom nav
                  const SizedBox(height: 96),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Static data
// ─────────────────────────────────────────────────────────────────────────────

List<_StatValue> get _statValues => [
      _StatValue(value: '${MockData.tools.length}+', label: '工具数量'),
      const _StatValue(value: '100万+', label: '累计用户'),
      const _StatValue(value: '免费', label: '永久使用'),
    ];

class _StatValue {
  const _StatValue({required this.value, required this.label});
  final String value;
  final String label;
}

// ─────────────────────────────────────────────────────────────────────────────
//  Private widgets
// ─────────────────────────────────────────────────────────────────────────────

class _StatPill extends StatelessWidget {
  const _StatPill(this.stat);
  final _StatValue stat;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          stat.value,
          style: AppTheme.display(
            size: 15,
            weight: FontWeight.w700,
            color: AppColors.primary,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          stat.label,
          style: AppTheme.sans(size: 10.5, color: AppColors.midSage, height: 1),
        ),
      ],
    );
  }
}

/// Decorative rotated leaf blob (approximates the React SVG leaf shape with
/// a rounded ellipse in primary green with a sage inner ellipse).
class _LeafBlob extends StatelessWidget {
  const _LeafBlob({required this.opacity, this.rotation = -28});
  final double opacity;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Transform.rotate(
        angle: rotation * 3.14159265 / 180,
        child: SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer ellipse #1f4b39
              Container(
                width: 64,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: opacity),
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              // Inner ellipse #4caf7d at 0.45 fillOpacity
              Container(
                width: 32,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: opacity * 0.45),
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Empty-state shown when the filtered tool list is empty.
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🌿', style: TextStyle(fontSize: 36, height: 1)),
          const SizedBox(height: 12),
          Text(
            '没有找到相关工具',
            style: AppTheme.sans(size: 13, color: AppColors.mutedForeground, height: 1.4),
          ),
          const SizedBox(height: 6),
          Text(
            '试试其他关键词吧',
            style: AppTheme.sans(size: 11.5, color: AppColors.mutedForeground, height: 1.4),
          ),
        ],
      ),
    );
  }
}
