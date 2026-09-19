import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// App typography & theme.
/// Display font: Sora (headings, numbers, brand, button labels)
/// Body font: Inter (all body text)
class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.primaryForeground,
        secondary: AppColors.secondary,
        surface: AppColors.card,
        onSurface: AppColors.foreground,
        error: AppColors.destructive,
        outline: AppColors.border,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: AppColors.foreground,
        displayColor: AppColors.foreground,
      ),
      primaryTextTheme: GoogleFonts.interTextTheme(base.primaryTextTheme),
      dividerColor: AppColors.border,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // ---- Font families ----
  static TextStyle display({
    double size = 14,
    FontWeight weight = FontWeight.w600,
    Color color = AppColors.foreground,
    double height = 1.2,
    double? letterSpacing,
  }) {
    return GoogleFonts.sora(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle sans({
    double size = 13,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.foreground,
    double height = 1.4,
    double? letterSpacing,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}

/// Common text style presets used throughout the app.
class T {
  T._();

  // Display presets
  static TextStyle displayXl([Color? c]) =>
      AppTheme.display(size: 26, weight: FontWeight.w700, color: c ?? AppColors.foreground);
  static TextStyle displayL([Color? c]) =>
      AppTheme.display(size: 24, weight: FontWeight.w700, color: c ?? AppColors.foreground);
  static TextStyle displayM([Color? c]) =>
      AppTheme.display(size: 22, weight: FontWeight.w700, color: c ?? AppColors.foreground);
  static TextStyle displayH([Color? c]) =>
      AppTheme.display(size: 19, weight: FontWeight.w700, color: c ?? AppColors.foreground);
  static TextStyle display18([Color? c]) =>
      AppTheme.display(size: 18, weight: FontWeight.w600, color: c ?? AppColors.foreground);
  static TextStyle displayS([Color? c]) =>
      AppTheme.display(size: 17, weight: FontWeight.w600, color: c ?? AppColors.foreground);
  static TextStyle displayBtn([Color? c]) =>
      AppTheme.display(size: 15, weight: FontWeight.w600, color: c ?? Colors.white);

  // Sans presets
  static TextStyle body([Color? c]) => AppTheme.sans(size: 13, color: c ?? AppColors.foreground);
  static TextStyle bodySm([Color? c]) =>
      AppTheme.sans(size: 12, color: c ?? AppColors.mutedForeground);
  static TextStyle bodyXs([Color? c]) =>
      AppTheme.sans(size: 11, color: c ?? AppColors.mutedForeground);
  static TextStyle label([Color? c]) =>
      AppTheme.sans(size: 13.5, weight: FontWeight.w600, color: c ?? AppColors.foreground);
  static TextStyle semibold([Color? c, double size = 13]) =>
      AppTheme.sans(size: size, weight: FontWeight.w600, color: c ?? AppColors.foreground);
  static TextStyle caption([Color? c]) =>
      AppTheme.sans(size: 10.5, color: c ?? AppColors.mutedForeground);
  static TextStyle tiny([Color? c]) =>
      AppTheme.sans(size: 10, color: c ?? AppColors.mutedForeground);
}
