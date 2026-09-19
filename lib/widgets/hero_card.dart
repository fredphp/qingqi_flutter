import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Hero 绿色渐变卡
/// - 渐变 #3D6B54 → #234A38
/// - 装饰：右上大圆（opacity 0.1）、右下曲线（opacity 0.05）
/// - 右上 sparkle 悬浮按钮
/// - 标题 + 副标题 + 搜索框（半透明白底）
class HeroCard extends StatelessWidget {
  const HeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.heroGradientStart, AppColors.heroGradientEnd],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 装饰：右上大圆
          Positioned(
            top: -40,
            right: -30,
            child: IgnorePointer(
              child: Container(
                width: 160,
                height: 160,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white10,
                ),
              ),
            ),
          ),
          // 装饰：左下细线曲线
          Positioned(
            bottom: -20,
            right: -10,
            child: IgnorePointer(
              child: CustomPaint(
                size: const Size(120, 80),
                painter: _CurvePainter(),
              ),
            ),
          ),
          // 右上 sparkle 按钮
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.white20,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.sparkle,
                size: 22,
              ),
            ),
          ),
          // 主内容
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              // 留出 sparkle 的空间
              const SizedBox(height: 36),
              const Text('你的 AI 生活助手', style: AppTextStyles.heroTitle),
              const SizedBox(height: 8),
              const Text(
                '一个 App，解决工作、学习、\n生活中的各种需求',
                style: AppTextStyles.heroSubtitle,
              ),
              const SizedBox(height: 20),
              const _SearchBar(),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.white15,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white25, width: 1),
      ),
      padding: const EdgeInsets.only(left: 16, right: 6),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: AppColors.white60, size: 20),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              '今天想解决什么？',
              style: AppTextStyles.searchPlaceholder,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white20,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('搜索', style: AppTextStyles.searchButton),
          ),
        ],
      ),
    );
  }
}

class _CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white05
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.cubicTo(
      size.width * 0.3,
      size.height * 0.1,
      size.width * 0.7,
      size.height * 0.9,
      size.width,
      size.height * 0.3,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
