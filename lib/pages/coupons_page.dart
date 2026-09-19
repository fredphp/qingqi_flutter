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

/// Coupons / 我的优惠 page — route `/coupons`.
/// Mirrors src/pages/Coupons.tsx.
class CouponsPage extends StatefulWidget {
  const CouponsPage({super.key});

  @override
  State<CouponsPage> createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  String _activeTab = 'available'; // available | used | expired
  String? _copiedId;

  // Map coupon status → tab id
  static const _statusToTab = <String, String>{
    'available': 'available',
    'used': 'used',
    'expired': 'expired',
  };

  static const _tabs = <_CouponTab>[
    _CouponTab(id: 'available', label: '可使用'),
    _CouponTab(id: 'used', label: '已使用'),
    _CouponTab(id: 'expired', label: '已过期'),
  ];

  int get _availableCount =>
      MockData.coupons.where((c) => c.status == 'available').length;

  List<Coupon> get _filtered {
    return MockData.coupons
        .where((c) => _statusToTab[c.status] == _activeTab)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '我的优惠', showBack: true, backTo: '/profile'),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Banner
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: AppGradients.promo,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '当前可用',
                                style: AppTheme.sans(
                                  size: 11,
                                  weight: FontWeight.w600,
                                  color: Colors.white.withValues(alpha: 0.70),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '$_availableCount',
                                    style: AppTheme.display(
                                      size: 22,
                                      weight: FontWeight.w700,
                                      color: Colors.white,
                                      height: 1.1,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      '张优惠券',
                                      style: AppTheme.sans(
                                        size: 13,
                                        weight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.20),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text('🎟️',
                              style: TextStyle(fontSize: 22, height: 1)),
                        ),
                      ],
                    ),
                  ),
                  // Tabs
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F6F2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: _tabs
                          .map((t) => Expanded(child: _tabButton(t)))
                          .toList(),
                    ),
                  ),
                  // Coupon cards OR empty state
                  if (list.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48),
                      child: _buildEmpty(),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: Column(
                        children: list
                            .map((c) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: _CouponCard(
                                    coupon: c,
                                    copied: _copiedId == c.id,
                                    onCopy: () {
                                      setState(() => _copiedId = c.id);
                                    },
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  // Get coupon entry (only on available tab)
                  if (_activeTab == 'available') _buildInviteEntry(),
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
  //  Tabs
  // ─────────────────────────────────────────────────────────────────────
  Widget _tabButton(_CouponTab t) {
    final active = _activeTab == t.id;
    final isAvailable = t.id == 'available';
    final countColor =
        active ? AppColors.accent : AppColors.placeholderGray;
    final label = isAvailable
        ? '${t.label} ($_availableCount)'
        : t.label;
    // For the available tab we render label + count with different colors via
    // Text.rich.
    return GestureDetector(
      onTap: () => setState(() => _activeTab = t.id),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          boxShadow: active
              ? const [
                  BoxShadow(
                    color: Color(0x14000000), // rgba(0,0,0,0.08)
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ]
              : const [],
        ),
        alignment: Alignment.center,
        child: isAvailable
            ? Text.rich(
                TextSpan(
                  text: '${t.label} (',
                  style: AppTheme.sans(
                    size: 12.5,
                    weight: FontWeight.w500,
                    color: active ? AppColors.primary : AppColors.mutedForeground,
                  ),
                  children: [
                    TextSpan(
                      text: '$_availableCount',
                      style: AppTheme.sans(
                        size: 12.5,
                        weight: FontWeight.w600,
                        color: countColor,
                      ),
                    ),
                    const TextSpan(text: ')'),
                  ],
                ),
              )
            : Text(
                label,
                style: AppTheme.sans(
                  size: 12.5,
                  weight: FontWeight.w500,
                  color: active ? AppColors.primary : AppColors.mutedForeground,
                ),
              ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────
  //  Empty state
  // ─────────────────────────────────────────────────────────────────────
  Widget _buildEmpty() {
    String message;
    switch (_activeTab) {
      case 'used':
        message = '暂无已使用的优惠券';
        break;
      case 'expired':
        message = '暂无已过期的优惠券';
        break;
      default:
        message = '暂无可用优惠券';
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('🎫', style: TextStyle(fontSize: 36, height: 1)),
        const SizedBox(height: 12),
        Text(
          message,
          style: AppTheme.sans(
              size: 13.5, color: AppColors.placeholderGray, height: 1.4),
        ),
        if (_activeTab == 'available') ...[
          const SizedBox(height: 16),
          PressableScale(
            onTap: () => AppRoutes.go(context, AppRoutes.invite),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(LucideIcons.gift,
                      size: 14, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    '邀好友得优惠',
                    style: AppTheme.sans(
                      size: 13,
                      weight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────
  //  Invite entry (available tab only)
  // ─────────────────────────────────────────────────────────────────────
  Widget _buildInviteEntry() {
    // Solid border approximation of dashed (Flutter has no native dashed
    // border) — visually faithful to spec intent.
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F6F2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.30),
          width: 1.5,
        ),
      ),
      child: PressableScale(
        onTap: () => AppRoutes.go(context, AppRoutes.invite),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.percent,
                size: 15, color: AppColors.midSage),
            const SizedBox(width: 6),
            Text(
              '邀好友获得更多优惠券',
              style: AppTheme.sans(
                size: 13,
                weight: FontWeight.w500,
                color: AppColors.midSage,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(LucideIcons.chevronRight,
                size: 13, color: AppColors.midSage),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Models & private widgets
// ─────────────────────────────────────────────────────────────────────────────

class _CouponTab {
  const _CouponTab({required this.id, required this.label});
  final String id;
  final String label;
}

class _CouponCard extends StatelessWidget {
  const _CouponCard({
    required this.coupon,
    required this.copied,
    required this.onCopy,
  });

  final Coupon coupon;
  final bool copied;
  final VoidCallback onCopy;

  bool get _available => coupon.status == 'available';

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _available ? 1.0 : 0.65,
      child: Container(
        decoration: BoxDecoration(
          color: coupon.bgColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: AppShadows.soft,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Main section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.70),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(coupon.emoji,
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
                                coupon.title,
                                style: AppTheme.sans(
                                  size: 13.5,
                                  weight: FontWeight.w600,
                                  color: _available
                                      ? const Color(0xFF2A3A30)
                                      : const Color(0xFF8A8A8A),
                                ),
                              ),
                            ),
                            if (!_available) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  coupon.status == 'used' ? '已用' : '过期',
                                  style: AppTheme.sans(
                                    size: 10,
                                    color: AppColors.mutedForeground,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          coupon.subtitle,
                          style: AppTheme.sans(
                              size: 11.5, color: AppColors.mutedForeground),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          coupon.condition,
                          style: AppTheme.sans(
                              size: 10.5, color: AppColors.placeholderGray),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        coupon.discount,
                        style: AppTheme.display(
                          size: 16,
                          weight: FontWeight.w700,
                          color: _available
                              ? coupon.color
                              : AppColors.placeholderGray,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.clock,
                              size: 10, color: AppColors.timeGray),
                          const SizedBox(width: 3),
                          Text(
                            coupon.expiry,
                            style: AppTheme.sans(
                                size: 9.5, color: AppColors.timeGray),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Dashed divider (approximated with a row of dots)
            _DashedDivider(
              color: Colors.black.withValues(alpha: 0.10),
            ),
            // Bottom row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  const Icon(LucideIcons.tag,
                      size: 11, color: AppColors.placeholderGray),
                  const SizedBox(width: 4),
                  Text(
                    coupon.code,
                    style: AppTheme.sans(
                        size: 11, color: AppColors.placeholderGray),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onCopy,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            copied ? LucideIcons.copyCheck : LucideIcons.copy,
                            size: 9,
                            color: AppColors.mutedForeground,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            copied ? '已复制' : '复制',
                            style: AppTheme.sans(
                                size: 10, color: AppColors.mutedForeground),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (_available)
                    PressableScale(
                      onTap: () => AppRoutes.go(context, AppRoutes.vip),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              coupon.color,
                              coupon.color.withValues(alpha: 0.80), // ${color}cc
                            ],
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(LucideIcons.zap,
                                size: 11, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              '立即使用',
                              style: AppTheme.sans(
                                size: 12,
                                weight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A horizontal dashed line approximated as a row of small dots.
class _DashedDivider extends StatelessWidget {
  const _DashedDivider({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dotWidth = 4.0;
        const gap = 4.0;
        final count =
            (constraints.maxWidth / (dotWidth + gap)).floor();
        return Row(
          children: [
            for (int i = 0; i < count; i++)
              Container(
                margin: const EdgeInsets.only(right: gap),
                width: dotWidth,
                height: 1,
                color: color,
              ),
          ],
        );
      },
    );
  }
}
