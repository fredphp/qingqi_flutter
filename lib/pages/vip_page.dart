import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_icons.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/benefit_grid.dart';
import '../widgets/common.dart';
import '../widgets/plan_card.dart';
import '../widgets/top_bar.dart';

class VipPage extends StatefulWidget {
  const VipPage({super.key});

  @override
  State<VipPage> createState() => _VipPageState();
}

class _VipPageState extends State<VipPage> {
  String _selectedId = 'yearly';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        children: [
          SafeArea(
            bottom: false,
            child: TopBar(
              showBack: true,
              backTo: '/profile',
              transparent: true,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildHero(),
                _buildBenefits(),
                _buildPlans(),
                _buildCTA(),
                _buildDisclaimer(),
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
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: const BoxDecoration(gradient: AppGradients.vipHero),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Radial gold overlay
          Positioned.fill(child: CustomPaint(painter: _VipHeroOverlayPainter())),
          // 2 decorative concentric circle borders (top-right)
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.16),
                  width: 1,
                ),
              ),
            ),
          ),
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.12),
                  width: 1,
                ),
              ),
            ),
          ),
          // Content
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Crown icon box
              Container(
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: AppGradients.gold,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: AppShadows.custom,
                ),
                child: Icon(
                  AppIcons.resolve('CrownIcon'),
                  size: 36,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '轻启 Pro 会员',
                style: AppTheme.display(
                  size: 22,
                  weight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '解锁全部 AI 工具 · 无限次高清处理\n专属客服 · 优先体验新功能',
                textAlign: TextAlign.center,
                style: AppTheme.sans(
                  size: 12.5,
                  color: const Color(0xAEFFFFFF),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _trustBadge('ShieldCheckIcon', '安全支付'),
                  const SizedBox(width: 8),
                  _trustBadge('SparklesIcon', '即时生效'),
                  const SizedBox(width: 8),
                  _trustBadge('CheckCircleIcon', '随时取消'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _trustBadge(String icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0x1FFFFFFF),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x2EFFFFFF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(AppIcons.resolve(icon), size: 12, color: AppColors.goldLight),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTheme.sans(
              size: 11,
              weight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // ── Benefits section ──
  Widget _buildBenefits() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '会员专属权益',
                style: AppTheme.display(
                  size: 15,
                  weight: FontWeight.w700,
                  color: AppColors.foreground,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.mintSoft,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '全部 4 项',
                  style: AppTheme.sans(
                    size: 10.5,
                    weight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          BenefitGrid(benefits: MockData.vipBenefits),
        ],
      ),
    );
  }

  // ── Plans section ──
  Widget _buildPlans() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '选择套餐',
            style: AppTheme.display(
              size: 15,
              weight: FontWeight.w700,
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < MockData.vipPlans.length; i++) ...[
            PlanCard(
              plan: MockData.vipPlans[i],
              selected: MockData.vipPlans[i].id == _selectedId,
              onTap: () =>
                  setState(() => _selectedId = MockData.vipPlans[i].id),
            ),
            if (i != MockData.vipPlans.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  // ── CTA ──
  Widget _buildCTA() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: PressableScale(
        onTap: () {},
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: AppGradients.gold,
            borderRadius: BorderRadius.circular(999),
            boxShadow: AppShadows.custom,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(AppIcons.resolve('CrownIcon'),
                  size: 18, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                '立即开通会员',
                style: AppTheme.display(
                  size: 15.5,
                  weight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Disclaimer ──
  Widget _buildDisclaimer() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 40),
      child: Text(
        '开通即表示您同意《轻启会员服务协议》和《自动续费服务条款》\n到期前 24 小时内自动续费，可在账户管理中取消',
        textAlign: TextAlign.center,
        style: AppTheme.sans(
          size: 10.5,
          color: const Color(0xFFA0ACA5),
          height: 1.5,
        ),
      ),
    );
  }
}

class _VipHeroOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // radial-gradient(circle at 50% 40%, rgba(216,189,133,0.38), transparent 58%)
    final center = Offset(size.width * 0.5, size.height * 0.4);
    final radius = size.width * 0.6;
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..shader = const RadialGradient(
          colors: [
            Color(0x61D8BD85), // rgba(216,189,133,0.38)
            Colors.transparent,
          ],
          stops: [0.0, 0.58],
        ).createShader(Rect.fromCircle(center: center, radius: radius)),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
