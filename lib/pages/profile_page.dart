import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../data/mock_data.dart';
import '../router.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/asset_stat_grid.dart';
import '../widgets/common.dart';
import '../widgets/profile_header.dart';
import '../widgets/section_header.dart';
import '../widgets/service_list.dart';
import '../widgets/task_card.dart';
import '../widgets/vip_card.dart';

/// "我的" page — profile hub.
/// Mirrors src/pages/Profile.tsx.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _checkedIn = false;

  static const Map<String, String> _assetRouteMap = {
    'coin': '/vip',
    'coupon': '/coupons',
    'rights': '/vip',
    'orders': '/orders',
  };

  static final List<AssetStat> _stats = const [
    AssetStat(id: 'coin', label: '金币', value: '1,280', icon: 'CoinsIcon'),
    AssetStat(id: 'coupon', label: '优惠券', value: '3', icon: 'TicketIcon'),
    AssetStat(id: 'rights', label: '权益', value: 'VIP', icon: 'CrownIcon'),
    AssetStat(id: 'orders', label: '订单', value: '12', icon: 'ShoppingBagIcon'),
  ];

  static const List<_QuickAction> _quickActions = [
    _QuickAction(
      icon: LucideIcons.shoppingBag,
      label: '我的订单',
      route: '/orders',
      bg: Color(0x171F4B39), // rgba(31,75,57,0.09)
      color: Color(0xFF1F4B39),
    ),
    _QuickAction(
      icon: LucideIcons.bookmark,
      label: '收藏工具',
      route: '/favorites',
      bg: Color(0x21C9A96A), // rgba(201,169,106,0.13)
      color: Color(0xFFB08A3A),
    ),
    _QuickAction(
      icon: LucideIcons.clock,
      label: '历史记录',
      route: '/history',
      bg: Color(0x1C4A7A63), // rgba(74,122,99,0.11)
      color: Color(0xFF2D6B50),
    ),
    _QuickAction(
      icon: LucideIcons.tag,
      label: '我的优惠',
      route: '/coupons',
      bg: Color(0x21C9A96A), // rgba(201,169,106,0.13)
      color: Color(0xFFC9A96A),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return AppScaffold(
      activeTab: 'profile',
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeaderZone(topInset),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: VipCard(
                title: '开通 VIP 畅享全部功能',
                subtitle: '月卡 ¥19.9 · 无限使用所有工具',
                action: '立即升级',
                onOpen: () => AppRoutes.go(context, AppRoutes.vip),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AssetStatGrid(
                stats: _stats,
                onTap: (stat) {
                  final route = _assetRouteMap[stat.id];
                  if (route != null) AppRoutes.go(context, route);
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildQuickActions(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildDailyTasks(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildServices(),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: Text(
                  '轻启AI · 版本 1.0.0',
                  style: AppTheme.sans(size: 11, color: AppColors.mutedForeground),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────
  //  Header zone (forest gradient + decorative blobs + ProfileHeader
  //  + inner stats strip)
  // ──────────────────────────────────────────────────────────────────
  Widget _buildHeaderZone(double topInset) {
    final notifTop = topInset > 40 ? topInset + 4 : 48.0;
    return Container(
      decoration: const BoxDecoration(
        gradient: AppGradients.profileHeader,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative radial circle blobs (sage / gold / light-sage)
          Positioned(
            right: -32,
            top: -32,
            child: IgnorePointer(
              child: Container(
                width: 192,
                height: 192,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.secondary.withValues(alpha: 0.20),
                      AppColors.secondary.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.70],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -16,
            bottom: 0,
            child: IgnorePointer(
              child: Container(
                width: 128,
                height: 128,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accent.withValues(alpha: 0.15),
                      AppColors.accent.withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.70],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 40,
            bottom: 32,
            child: IgnorePointer(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF7FA88A).withValues(alpha: 0.10),
                      const Color(0xFF7FA88A).withValues(alpha: 0.0),
                    ],
                    stops: const [0.0, 0.70],
                  ),
                ),
              ),
            ),
          ),
          // Foreground content
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top notification bar (px-5 pt-12 pb-0)
              Padding(
                padding: EdgeInsets.only(
                    left: 20, right: 20, top: notifTop, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xCCC9A96A), // rgba(201,169,106,0.8)
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '我的主页',
                          style: AppTheme.sans(
                            size: 12,
                            weight: FontWeight.w500,
                            color: const Color(0x8CFFFFFF), // rgba(255,255,255,0.55)
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Color(0x1FFFFFFF), // rgba(255,255,255,0.12)
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        LucideIcons.bell,
                        size: 15,
                        color: Color(0xCCFFFFFF), // rgba(255,255,255,0.8)
                      ),
                    ),
                  ],
                ),
              ),
              // ProfileHeader (px-5 pt-4 pb-6)
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 16, bottom: 24),
                child: ProfileHeader(
                  nickname: MockData.profileNickname,
                  uid: MockData.profileUid,
                  avatar: '',
                  onEdit: () => AppRoutes.go(context, AppRoutes.settings),
                ),
              ),
              // Inner stats strip (mx-5 mb-5)
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 20),
                child: _buildInnerStatsStrip(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInnerStatsStrip() {
    const stats = <(String, String)>[
      ('累计使用', '138次'),
      ('节省时间', '46h'),
      ('连续签到', '3天'),
      ('生成文件', '215个'),
    ];
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0x1AFFFFFF), // rgba(255,255,255,0.10)
            border: Border.all(
                color: const Color(0x24FFFFFF)), // rgba(255,255,255,0.14)
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    for (int i = 0; i < stats.length; i++) ...[
                      if (i > 0)
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          width: 1,
                          color: const Color(0x24FFFFFF),
                        ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              stats[i].$2,
                              style: AppTheme.display(
                                size: 15,
                                weight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              stats[i].$1,
                              style: AppTheme.sans(
                                size: 10,
                                color: const Color(0x80FFFFFF), // rgba(255,255,255,0.5)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Positioned(
                right: -4,
                top: -4,
                child: Icon(
                  LucideIcons.zap,
                  size: 36,
                  color: const Color(0x1AC9A96A), // #c9a96a opacity 0.10
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────
  //  Quick actions row
  // ──────────────────────────────────────────────────────────────────
  Widget _buildQuickActions() {
    return Row(
      children: [
        for (int i = 0; i < _quickActions.length; i++) ...[
          if (i > 0) const SizedBox(width: 10),
          Expanded(child: _buildQuickAction(_quickActions[i])),
        ],
      ],
    );
  }

  Widget _buildQuickAction(_QuickAction qa) {
    return PressableScale(
      onTap: () => AppRoutes.go(context, qa.route),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: AppShadows.soft,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: qa.bg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(qa.icon, size: 17, color: qa.color),
            ),
            const SizedBox(height: 8),
            Text(
              qa.label,
              style: AppTheme.sans(
                size: 10.5,
                weight: FontWeight.w500,
                color: AppColors.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────────
  //  Daily tasks section
  // ──────────────────────────────────────────────────────────────────
  Widget _buildDailyTasks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BarSectionTitle(
          title: '今日任务',
          trailing: Text(
            _checkedIn ? '今日已签到 ✓' : '完成任务赚硬币',
            style: AppTheme.sans(size: 11, color: AppColors.mutedForeground),
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            for (int i = 0; i < MockData.dailyTasks.length; i++) ...[
              if (i > 0) const SizedBox(height: 10),
              TaskCard(
                task: MockData.dailyTasks[i],
                done: MockData.dailyTasks[i].id == 'checkin' && _checkedIn,
                onAction: () {
                  final id = MockData.dailyTasks[i].id;
                  if (id == 'checkin') {
                    setState(() => _checkedIn = true);
                  } else if (id == 'invite') {
                    AppRoutes.go(context, AppRoutes.invite);
                  }
                },
              ),
            ],
          ],
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────────
  //  More services section
  // ──────────────────────────────────────────────────────────────────
  Widget _buildServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const BarSectionTitle(title: '更多服务'),
        const SizedBox(height: 12),
        ServiceList(
          items: MockData.services,
          onTap: (item) => AppRoutes.go(context, item.route),
        ),
      ],
    );
  }
}

class _QuickAction {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.route,
    required this.bg,
    required this.color,
  });
  final IconData icon;
  final String label;
  final String route;
  final Color bg;
  final Color color;
}
