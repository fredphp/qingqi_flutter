import 'package:flutter/material.dart';

/// Centralized color palette for 轻启AI.
/// Mirrors src/index.css :root custom properties + extra ad-hoc hex values
/// found across the React components/pages.
class AppColors {
  AppColors._();

  // ---- Surfaces ----
  static const Color background = Color(0xFFFAF7F1); // --background
  static const Color foreground = Color(0xFF1B2B22); // --foreground
  static const Color card = Color(0xFFFEFCF6); // --card
  static const Color cardForeground = Color(0xFF1B2B22);
  static const Color popover = Color(0xFFFEFCF6);
  static const Color muted = Color(0xFFF1EDE1); // --muted
  static const Color mutedForeground = Color(0xFF7A8B80); // --muted-foreground
  static const Color border = Color(0xFFE8E2D5); // --border
  static const Color input = Color(0xFFE8E2D5);
  static const Color ring = Color(0xFFA6C0AB);

  // ---- Brand ----
  static const Color primary = Color(0xFF1F4B39); // --primary (forest green)
  static const Color primaryForeground = Color(0xFFFBF8F1);
  static const Color secondary = Color(0xFFA6C0AB); // --secondary (sage)
  static const Color secondaryForeground = Color(0xFF1F4B39);
  static const Color accent = Color(0xFFC9A96A); // --accent (gold)
  static const Color accentForeground = Color(0xFF4A3A17);
  static const Color destructive = Color(0xFFC4573F); // --destructive
  static const Color destructiveForeground = Color(0xFFFBF8F1);

  // ---- Extra design tokens ----
  static const Color sageSoft = Color(0xFFEEF2EC);
  static const Color mintSoft = Color(0xFFE4EFE7);
  static const Color forestDeep = Color(0xFF173A2C);
  static const Color goldSoft = Color(0xFFF4ECD8);
  static const Color midSage = Color(0xFF4A7A63); // mid-sage text
  static const Color inactiveNav = Color(0xFF9AADA2); // inactive nav icon/text
  static const Color success = Color(0xFF4CAF7D); // success green
  static const Color forestMid = Color(0xFF2D6B50); // gradient stop
  static const Color forestLight = Color(0xFF2F6B52); // lighter forest
  static const Color goldLight = Color(0xFFD8BD85);
  static const Color goldDark = Color(0xFFB08F52);
  static const Color goldBrown = Color(0xFF8A6D34); // gold-brown text
  static const Color goldBrown2 = Color(0xFF8A6A30);
  static const Color goldBrown3 = Color(0xFFB08A3A);
  static const Color goldCoin = Color(0xFFD4A84B);

  // ---- Tints used across cards/badges ----
  static const Color tintSage = Color(0xFFEEF2EC);
  static const Color tintMint = Color(0xFFE4EFE7);
  static const Color tintGold = Color(0xFFF4ECD8);
  static const Color tintBlue = Color(0xFFEEF4FC);
  static const Color tintPink = Color(0xFFFDF0F0);
  static const Color tintPurple = Color(0xFFF4EEF8);
  static const Color tintBeige = Color(0xFFF4F0E8);
  static const Color tintCool = Color(0xFFF0F4F8);
  static const Color tintWarmWhite = Color(0xFFF8F6EF);
  static const Color tintInput = Color(0xFFF7F4EE);
  static const Color tintPdfFav = Color(0xFFF8F0F0);
  static const Color tintOcrFav = Color(0xFFFDF6E8);
  static const Color tintResizeFav = Color(0xFFF4F0E8);
  static const Color tintWatermarkFav = Color(0xFFF0F4F8);

  // ---- Misc text colors ----
  static const Color placeholderGray = Color(0xFFA0A8A2);
  static const Color timeGray = Color(0xFFC4CFC6);
  static const Color dividerWarm = Color(0xFFF0EBE0);
  static const Color dividerMuted = Color(0xFFECE7DB);
  static const Color stepPending = Color(0xFFA8B3AB);
  static const Color stepActiveBg = Color(0xFFD5E7DA);
  static const Color rankOne = Color(0xFFE8603A);
  static const Color rankThree = Color(0xFF7A8B80);
  static const Color rankRest = Color(0xFFC4CFC6);
  static const Color paidBlue = Color(0xFF2A6EB5);
  static const Color dangerText = Color(0xFFC47A7A);
  static const Color dangerStrong = Color(0xFFB43C3C);
  static const Color crownBrown = Color(0xFF7A4F10);
  static const Color unselectedRadio = Color(0xFFD6D0C2);

  // ---- Tool-page hero gradient stops ----
  // ImageCompress / PdfToImage: forest
  // ImageResize: green (#2d5a27 -> #4a7d3f)
  // ImageConvert: brown-gold (#5a4a1f -> #8a7040)
  // ImageWatermark: deep brown (#4a2e1f -> #743f2c)
  // PdfMerge: navy (#2a4060 -> #3d5c85)
  // Ocr: purple (#3d2e5a -> #5c4582)
  // IdPhoto: teal-blue (#24627e -> #1a3d52)

  // ---- Helper: hex from string (for dynamic tool tints) ----
  static Color fromHex(String hex) {
    final h = hex.replaceFirst('#', '');
    return Color(int.parse('FF$h', radix: 16));
  }

  // ---- Common semi-transparent primaries ----
  static Color primaryWithOpacity(double o) => primary.withValues(alpha: o);
  static Color accentWithOpacity(double o) => accent.withValues(alpha: o);
}
