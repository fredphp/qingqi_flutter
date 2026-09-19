import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_icons.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/common.dart';
import '../widgets/invite_code_card.dart';
import '../widgets/share_options.dart';
import '../widgets/top_bar.dart';

class InvitePage extends StatefulWidget {
  const InvitePage({super.key});

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  bool _copied = false;

  void _onCopyCode() {
    Clipboard.setData(const ClipboardData(text: MockData.inviteCodePage));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          const TopBar(title: '邀请好友', showBack: true, backTo: '/profile'),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildHero(),
                // InviteCodeCard
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: InviteCodeCard(
                    code: MockData.inviteCodePage,
                    copied: _copied,
                    onCopy: _onCopyCode,
                  ),
                ),
                // Stats row
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _statPill(
                          icon: AppIcons.resolve('UsersIcon'),
                          value: '12',
                          label: '已邀好友',
                          bg: AppColors.mintSoft,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _statPill(
                          icon: AppIcons.resolve('TrophyIcon'),
                          value: '600',
                          label: '获得金币',
                          bg: AppColors.goldSoft,
                        ),
                      ),
                    ],
                  ),
                ),
                // HowItWorks card
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildHowItWorks(),
                ),
                // CTA
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _buildCTA(),
                ),
                // Share options card
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
                  child: _buildShareCard(),
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
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      decoration: const BoxDecoration(gradient: AppGradients.inviteHero),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 3 emoji decorations
          Positioned(
            top: 6,
            right: -8,
            child: Opacity(
              opacity: 0.10,
              child: Text('🌿', style: const TextStyle(fontSize: 56)),
            ),
          ),
          Positioned(
            bottom: -18,
            left: -10,
            child: Opacity(
              opacity: 0.10,
              child: Text('🍃', style: const TextStyle(fontSize: 64)),
            ),
          ),
          const Positioned(
            bottom: 6,
            right: 28,
            child: Opacity(
              opacity: 0.35,
              child: Text(
                '✦',
                style: TextStyle(fontSize: 16, color: Color(0xFFB08F52)),
              ),
            ),
          ),
          // Centered Column
          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Gift box
                  Container(
                    width: 64,
                    height: 64,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFF4ECD8), Color(0xFFE8D5A8)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: AppShadows.soft,
                    ),
                    child: Icon(AppIcons.resolve('GiftIcon'),
                        size: 28, color: const Color(0xFFB08F52)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '邀请好友，一起薅羊毛 🎉',
                    textAlign: TextAlign.center,
                    style: AppTheme.display(
                      size: 21,
                      weight: FontWeight.w700,
                      color: AppColors.foreground,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      style: AppTheme.sans(
                        size: 12.5,
                        color: const Color(0xFF4A5A50),
                        height: 1.6,
                      ),
                      children: const [
                        TextSpan(text: '每成功邀请一位好友注册并使用\n你和好友各获得 '),
                        TextSpan(
                          text: '50 金币',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFB08F52),
                          ),
                        ),
                        TextSpan(text: ' 奖励'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statPill({
    required IconData icon,
    required String value,
    required String label,
    required Color bg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(height: 6),
          Text(
            value,
            style: AppTheme.display(
              size: 17,
              weight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTheme.sans(size: 11, color: AppColors.mutedForeground),
          ),
        ],
      ),
    );
  }

  // ── HowItWorks card ──
  Widget _buildHowItWorks() {
    final steps = [
      '分享您的专属邀请码或链接给好友',
      '好友使用邀请码注册轻启AI账号',
      '双方各自获得 50 枚金币奖励',
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
          Text(
            '活动规则',
            style: AppTheme.sans(
              size: 13.5,
              weight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < steps.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF245A44), Color(0xFF1F4B39)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${i + 1}',
                    style: AppTheme.display(
                      size: 12,
                      weight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      steps[i],
                      style: AppTheme.sans(
                        size: 12.5,
                        color: AppColors.foreground,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (i != steps.length - 1) const SizedBox(height: 12),
          ],
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F4EF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '· 每位用户最多获得 300 金币邀请奖励\n· 金币可兑换会员时长或高级功能使用次数\n· 恶意刷量行为将取消奖励资格',
              style: AppTheme.sans(
                size: 11,
                color: AppColors.mutedForeground,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── CTA ──
  Widget _buildCTA() {
    return PressableScale(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: AppGradients.primaryCta,
          borderRadius: BorderRadius.circular(999),
          boxShadow: AppShadows.soft,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(AppIcons.resolve('GiftIcon'),
                size: 18, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              '立即邀请好友',
              style: AppTheme.display(
                size: 15,
                weight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Share options card ──
  Widget _buildShareCard() {
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
          Text(
            '分享方式',
            style: AppTheme.sans(
              size: 13.5,
              weight: FontWeight.w600,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 12),
          ShareOptions(
            methods: MockData.shareMethods,
            onTap: (_) {},
          ),
        ],
      ),
    );
  }
}
