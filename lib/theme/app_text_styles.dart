import 'package:flutter/material.dart';
import 'app_colors.dart';

/// 轻启AI 文本样式
/// 字体回退顺序：PingFang SC → Noto Sans SC → 系统 Sans
class AppTextStyles {
  AppTextStyles._();

  static const String _fontFamilyFallback = 'PingFang SC';

  static const TextStyle appTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamilyFallback: [_fontFamilyFallback],
    height: 1.2,
  );

  static const TextStyle appSubtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamilyFallback: [_fontFamilyFallback],
    height: 1.3,
  );

  static const TextStyle coinText = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.accentGold,
    fontFamilyFallback: [_fontFamilyFallback],
  );

  static const TextStyle heroTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamilyFallback: [_fontFamilyFallback],
    height: 1.3,
  );

  static const TextStyle heroSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.white90,
    fontFamilyFallback: [_fontFamilyFallback],
    height: 1.5,
  );

  static const TextStyle searchPlaceholder = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.white60,
    fontFamilyFallback: [_fontFamilyFallback],
  );

  static const TextStyle searchText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontFamilyFallback: [_fontFamilyFallback],
  );

  static const TextStyle searchButton = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    fontFamilyFallback: [_fontFamilyFallback],
  );

  static const TextStyle quickActionLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamilyFallback: [_fontFamilyFallback],
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamilyFallback: [_fontFamilyFallback],
  );

  static const TextStyle sectionLink = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamilyFallback: [_fontFamilyFallback],
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamilyFallback: [_fontFamilyFallback],
  );

  static const TextStyle cardDesc = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamilyFallback: [_fontFamilyFallback],
    height: 1.4,
  );

  static const TextStyle ctaText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    fontFamilyFallback: [_fontFamilyFallback],
  );

  static const TextStyle tagHot = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.tagTextDark,
    fontFamilyFallback: [_fontFamilyFallback],
  );

  static const TextStyle tagNew = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.tagTextDark,
    fontFamilyFallback: [_fontFamilyFallback],
    letterSpacing: 0.5,
  );

  static const TextStyle tagExperience = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.tagTextDark,
    fontFamilyFallback: [_fontFamilyFallback],
  );

  static const TextStyle navLabelActive = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
    fontFamilyFallback: [_fontFamilyFallback],
  );

  static const TextStyle navLabelInactive = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    fontFamilyFallback: [_fontFamilyFallback],
  );
}
