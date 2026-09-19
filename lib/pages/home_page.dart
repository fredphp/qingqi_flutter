import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/hero_card.dart';
import '../widgets/quick_actions.dart';
import '../widgets/section_header.dart';
import '../widgets/feature_card.dart';
import '../widgets/bottom_nav_bar.dart';

/// 首页 — 聚合所有区块
/// 顶部应用栏 / Hero 卡 / 快捷入口 / 精选 AI 区 / 功能卡列表 / 底部导航
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppTopBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeroCard(),
            const SizedBox(height: 24),
            const QuickActions(),
            const SizedBox(height: 24),
            const SectionHeader(title: '精选 AI · 让灵感落地'),
            const SizedBox(height: 12),
            const FeatureCard(
              image: 'assets/images/ai_id_photo.jpg',
              tag: '热门',
              title: 'AI证件照',
              desc: '专业规格 · 智能抠图换背景',
              tagStyle: AppTextStyles.tagHot,
            ),
            const FeatureCard(
              image: 'assets/images/ai_resume.jpg',
              tag: 'NEW',
              title: 'AI简历',
              desc: '打造更好的职业机会',
              tagStyle: AppTextStyles.tagNew,
            ),
            const FeatureCard(
              image: 'assets/images/ai_shopping.jpg',
              tag: '新品体验',
              title: 'AI购物助手',
              desc: '发现更适合你的购物',
              tagStyle: AppTextStyles.tagExperience,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        activeIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }
}
