import 'dart:ui';

import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';

import '../data/mock_data.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/top_bar.dart';

/// Orders / 我的订单 page — route `/orders`.
/// Mirrors src/pages/Orders.tsx.
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String _activeTab = 'all'; // all | paid | completed | refunded

  static const _tabs = <_Tab>[
    _Tab(id: 'all', label: '全部'),
    _Tab(id: 'paid', label: '已支付'),
    _Tab(id: 'completed', label: '已完成'),
    _Tab(id: 'refunded', label: '退款'),
  ];

  List<OrderItem> get _filtered {
    if (_activeTab == 'all') return MockData.orders;
    return MockData.orders.where((o) => o.status == _activeTab).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '我的订单', showBack: true, backTo: '/profile'),
          // ── Sticky tab bar ──
          _buildTabs(),
          // ── Scrollable list ──
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: list.isEmpty
                  ? _buildEmpty()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Column(
                            children: list
                                .map((o) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12),
                                      child: _OrderCard(order: o),
                                    ))
                                .toList(),
                          ),
                        ),
                        // Stats strip
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildStatsStrip(),
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

  // ─────────────────────────────────────────────────────────────────────
  //  Sticky tabs
  // ─────────────────────────────────────────────────────────────────────
  Widget _buildTabs() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.background.withValues(alpha: 0.95),
          border: Border(
            bottom: BorderSide(
              color: AppColors.border.withValues(alpha: 0.30),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: _tabs.map(_tabButton).toList(),
        ),
      ),
    );
  }

  Widget _tabButton(_Tab t) {
    final active = _activeTab == t.id;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = t.id),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: active ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(
            t.label,
            style: AppTheme.sans(
              size: 12.5,
              weight: FontWeight.w500,
              color: active ? Colors.white : const Color(0xFF7A8B80),
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────
  //  Stats strip
  // ─────────────────────────────────────────────────────────────────────
  Widget _buildStatsStrip() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.tintWarmWhite, // #f8f6ef
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatCell(
            icon: Icon(LucideIcons.shoppingBag,
                size: 15, color: AppColors.midSage),
            value: '${MockData.orders.length}',
            label: '订单总数',
          ),
          const VDivider(height: 28, color: Color(0xFFE8E2D5)),
          _StatCell(
            icon: Icon(LucideIcons.package, size: 15, color: AppColors.accent),
            value: '¥ 99.6',
            label: '累计消费',
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────
  //  Empty state
  // ─────────────────────────────────────────────────────────────────────
  Widget _buildEmpty() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 72),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('📭', style: TextStyle(fontSize: 48, height: 1)),
          const SizedBox(height: 14),
          Text(
            '暂无订单记录',
            style: AppTheme.sans(
                size: 14, color: AppColors.placeholderGray, height: 1.4),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Models & private widgets
// ─────────────────────────────────────────────────────────────────────────────

class _Tab {
  const _Tab({required this.id, required this.label});
  final String id;
  final String label;
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.icon,
    required this.value,
    required this.label,
  });
  final Widget icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: AppTheme.display(
                size: 14,
                weight: FontWeight.w700,
                color: AppColors.primary,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTheme.sans(
                  size: 10.5, color: AppColors.mutedForeground, height: 1),
            ),
          ],
        ),
      ],
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});
  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              const Icon(LucideIcons.receipt,
                  size: 12, color: AppColors.placeholderGray),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  order.orderNo,
                  style: AppTheme.sans(
                      size: 11, color: AppColors.placeholderGray),
                ),
              ),
              _StatusPill(status: order.status),
            ],
          ),
          const SizedBox(height: 12),
          // Body row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F6F2),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(order.emoji,
                    style: const TextStyle(fontSize: 22, height: 1)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.title,
                      style: AppTheme.sans(
                        size: 13.5,
                        weight: FontWeight.w600,
                        color: AppColors.foreground,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      order.subtitle,
                      style: AppTheme.sans(
                          size: 11.5, color: AppColors.mutedForeground),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.amount,
                      style: AppTheme.display(
                        size: 15,
                        weight: FontWeight.w700,
                        color: AppColors.primary,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Footer
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.only(top: 12),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFF1EDE1), width: 1),
              ),
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.clock,
                    size: 11, color: AppColors.timeGray),
                const SizedBox(width: 4),
                Text(
                  order.date,
                  style: AppTheme.sans(
                      size: 11, color: AppColors.placeholderGray),
                ),
                const Spacer(),
                if (order.status == 'completed')
                  GestureDetector(
                    onTap: () => AppRoutes.go(context, AppRoutes.vip),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.sageSoft,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.rotateCcw,
                              size: 10, color: AppColors.midSage),
                          const SizedBox(width: 4),
                          Text(
                            '续费',
                            style: AppTheme.sans(
                              size: 11.5,
                              weight: FontWeight.w600,
                              color: AppColors.midSage,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (order.status == 'refunded')
                  Text(
                    '退款成功',
                    style: AppTheme.sans(
                        size: 11, color: AppColors.placeholderGray),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    String label;
    Color fg;
    Color bg;
    switch (status) {
      case 'paid':
        label = '已支付';
        fg = AppColors.paidBlue; // #2a6eb5
        bg = AppColors.tintBlue; // #eef4fc
        break;
      case 'processing':
        label = '处理中';
        fg = AppColors.accent; // #c9a96a
        bg = AppColors.tintOcrFav; // #fdf6e8
        break;
      case 'completed':
        label = '已完成';
        fg = AppColors.midSage; // #4a7a63
        bg = const Color(0xFFEEF6F0);
        break;
      case 'refunded':
      default:
        label = '已退款';
        fg = const Color(0xFF8A8A8A);
        bg = const Color(0xFFF0EEEA);
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppTheme.sans(
            size: 11, weight: FontWeight.w600, color: fg, height: 1.2),
      ),
    );
  }
}
