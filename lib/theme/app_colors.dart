import 'package:flutter/material.dart';

/// 轻启AI 设计系统的颜色常量
/// 按 1:1 还原设计稿 https://dog-tree-31186095.aisite.pixso.design
class AppColors {
  AppColors._();

  /// 主色 — 深森林绿，用于 Logo / Hero 渐变末端 / CTA 文本 / 底部激活态
  static const Color primary = Color(0xFF2D5A47);

  /// Hero 渐变起点（左上）
  static const Color heroGradientStart = Color(0xFF3D6B54);

  /// Hero 渐变终点（右下）
  static const Color heroGradientEnd = Color(0xFF234A38);

  /// 主色浅 — CTA 按钮背景、强调底色
  static const Color primaryLight = Color(0xFFE8F0EC);

  /// 页面整体背景（暖白）
  static const Color background = Color(0xFFF7F9F8);

  /// 卡片 / 输入框背景
  static const Color surface = Color(0xFFFFFFFF);

  /// 主文本
  static const Color textPrimary = Color(0xFF1A1A1A);

  /// 次文本 / 描述 / 占位
  static const Color textSecondary = Color(0xFF6B7280);

  /// 三级文本 / 底部未激活导航
  static const Color textTertiary = Color(0xFF9CA3AF);

  /// 金色强调 — 积分 / 1285
  static const Color accentGold = Color(0xFFC6A87C);

  /// 积分胶囊背景
  static const Color coinPillBg = Color(0xFFFDF6E8);

  /// 积分胶囊边框
  static const Color coinPillBorder = Color(0xFFE5DCC8);

  /// 标签背景 — 米色
  static const Color tagBgBeige = Color(0xFFF3EFE0);

  /// 标签文本（深灰）
  static const Color tagTextDark = Color(0xFF4A5568);

  /// 浅灰边框
  static const Color border = Color(0xFFE5E7EB);

  /// 卡片柔和阴影色
  static const Color cardShadow = Color(0x0A000000);

  /// 半透明白（Hero 内部使用）
  static const Color white15 = Color(0x26FFFFFF);
  static const Color white20 = Color(0x33FFFFFF);
  static const Color white25 = Color(0x40FFFFFF);
  static const Color white60 = Color(0x99FFFFFF);
  static const Color white90 = Color(0xE6FFFFFF);

  /// 装饰圆 opacity 0.1
  static const Color white10 = Color(0x1AFFFFFF);
  static const Color white05 = Color(0x0DFFFFFF);

  /// 黄色 sparkle 图标
  static const Color sparkle = Color(0xFFFCD34D);
}
