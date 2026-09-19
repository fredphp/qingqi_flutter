import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// 顶部应用栏
/// 左：Logo（绿色圆角方块 + 白色叶子） + 标题 + 副标题
/// 右：积分胶囊（1285） + 头像
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // Logo
            const _Logo(),
            const SizedBox(width: 10),
            // 标题 + 副标题
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('轻启AI', style: AppTextStyles.appTitle),
                  SizedBox(height: 2),
                  Text(
                    '让工具更简单 · 让生活更轻松',
                    style: AppTextStyles.appSubtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // 积分胶囊
            const _CoinPill(),
            const SizedBox(width: 10),
            // 头像
            const _Avatar(),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.eco_rounded, color: Colors.white, size: 22),
    );
  }
}

class _CoinPill extends StatelessWidget {
  const _CoinPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.coinPillBg,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.coinPillBorder, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.monetization_on_rounded,
              color: AppColors.accentGold, size: 14),
          SizedBox(width: 4),
          Text('1285', style: AppTextStyles.coinText),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.tagBgBeige, width: 2),
        image: const DecorationImage(
          image: AssetImage('assets/images/avatar.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
