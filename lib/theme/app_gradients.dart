import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Reusable gradient definitions matching the CSS @utility classes.
class AppGradients {
  AppGradients._();

  /// bg-forest-gradient: linear-gradient(150deg, #245a44 0%, #1f4b39 46%, #173a2c 100%)
  static const LinearGradient forest = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF245A44), AppColors.primary, AppColors.forestDeep],
    stops: [0.0, 0.46, 1.0],
    transform: GradientRotation(150 * 3.14159265 / 180),
  );

  /// bg-ivory-gradient: linear-gradient(180deg, #e7efe6 0%, #f6f2e9 62%, #faf7f1 100%)
  static const LinearGradient ivory = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFE7EFE6), Color(0xFFF6F2E9), AppColors.background],
    stops: [0.0, 0.62, 1.0],
  );

  /// bg-gold-gradient: linear-gradient(135deg, #d8bd85 0%, #c9a96a 58%, #b08f52 100%)
  static const LinearGradient gold = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD8BD85), AppColors.accent, AppColors.goldDark],
    stops: [0.0, 0.58, 1.0],
  );

  /// Primary CTA gradient: linear-gradient(135deg, #245a44 0%, #1f4b39 100%)
  static const LinearGradient primaryCta = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF245A44), AppColors.primary],
  );

  /// Success gradient (downloaded state): linear-gradient(135deg, #4caf7d 0%, #3d9e6e 100%)
  static const LinearGradient success = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.success, Color(0xFF3D9E6E)],
  );

  /// AI assistant bubble / CTA gradient: linear-gradient(135deg, #1f4b39 0%, #2f6b52 100%)
  static const LinearGradient assistantBubble = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary, AppColors.forestLight],
  );

  /// Profile header gradient: linear-gradient(160deg, #163827 0%, #1f4b39 45%, #2d6b50 80%, #3a7d5f 100%)
  static const LinearGradient profileHeader = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF163827),
      AppColors.primary,
      AppColors.forestMid,
      Color(0xFF3A7D5F),
    ],
    stops: [0.0, 0.45, 0.80, 1.0],
    transform: GradientRotation(160 * 3.14159265 / 180),
  );

  /// Vip hero gradient: linear-gradient(175deg, #1a3228 0%, #1f4b39 40%, #245a44 70%, #2d6b50 100%)
  static const LinearGradient vipHero = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF1A3228),
      AppColors.primary,
      Color(0xFF245A44),
      AppColors.forestMid,
    ],
    stops: [0.0, 0.40, 0.70, 1.0],
    transform: GradientRotation(175 * 3.14159265 / 180),
  );

  /// Processing background: linear-gradient(175deg, #1f4b39 0%, #2b5c47 40%, #1a3d2e 100%)
  static const LinearGradient processing = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.primary, Color(0xFF2B5C47), Color(0xFF1A3D2E)],
    stops: [0.0, 0.40, 1.0],
    transform: GradientRotation(175 * 3.14159265 / 180),
  );

  /// Progress ring gradient: #1f4b39 -> #7fa88a -> #c9a96a
  static const SweepGradient ring = SweepGradient(
    colors: [AppColors.primary, Color(0xFF7FA88A), AppColors.accent],
  );

  /// Progress bar fill: linear-gradient(90deg, #4caf7d 0%, #d8bd85 100%)
  static const LinearGradient progressFill = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.success, Color(0xFFD8BD85)],
  );

  /// XP bar: linear-gradient(90deg, #c9a96a, #e8c87a)
  static const LinearGradient xpBar = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.accent, Color(0xFFE8C87A)],
  );

  /// VIP badge gradient: linear-gradient(90deg, #c9a96a 0%, #e8c87a 50%, #c9a96a 100%)
  static const LinearGradient vipBadge = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.accent, Color(0xFFE8C87A), AppColors.accent],
    stops: [0.0, 0.5, 1.0],
  );

  /// Avatar fallback gradient: linear-gradient(145deg, #2d6b50 0%, #1f4b39 55%, #163827 100%)
  static const LinearGradient avatarFallback = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.forestMid, AppColors.primary, Color(0xFF163827)],
    stops: [0.0, 0.55, 1.0],
  );

  // ---- Tool-page hero gradients (155deg) ----
  /// ImageCompress / PdfToImage hero: #1f4b39 -> #245a44 -> #2f6b52
  static LinearGradient forestHero() => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.primary, Color(0xFF245A44), AppColors.forestLight],
        stops: [0.0, 0.55, 1.0],
        transform: GradientRotation(155 * 3.14159265 / 180),
      );

  /// ImageResize hero: #2d5a27 -> #3a6e32 -> #4a7d3f
  static const LinearGradient resizeHero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2D5A27), Color(0xFF3A6E32), Color(0xFF4A7D3F)],
    stops: [0.0, 0.55, 1.0],
    transform: GradientRotation(155 * 3.14159265 / 180),
  );

  /// ImageConvert hero: #5a4a1f -> #7a6030 -> #8a7040
  static const LinearGradient convertHero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF5A4A1F), Color(0xFF7A6030), Color(0xFF8A7040)],
    stops: [0.0, 0.55, 1.0],
    transform: GradientRotation(155 * 3.14159265 / 180),
  );

  /// ImageWatermark hero: #4a2e1f -> #603a28 -> #743f2c
  static const LinearGradient watermarkHero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A2E1F), Color(0xFF603A28), Color(0xFF743F2C)],
    stops: [0.0, 0.55, 1.0],
    transform: GradientRotation(155 * 3.14159265 / 180),
  );

  /// PdfMerge hero: #2a4060 -> #314d75 -> #3d5c85
  static const LinearGradient pdfMergeHero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2A4060), Color(0xFF314D75), Color(0xFF3D5C85)],
    stops: [0.0, 0.55, 1.0],
    transform: GradientRotation(155 * 3.14159265 / 180),
  );

  /// Ocr hero: #3d2e5a -> #4e3a72 -> #5c4582
  static const LinearGradient ocrHero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3D2E5A), Color(0xFF4E3A72), Color(0xFF5C4582)],
    stops: [0.0, 0.55, 1.0],
    transform: GradientRotation(155 * 3.14159265 / 180),
  );

  /// IdPhoto hero: #24627e -> #1e5168 -> #1a3d52
  static const LinearGradient idPhotoHero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF24627E), Color(0xFF1E5168), Color(0xFF1A3D52)],
    stops: [0.0, 0.55, 1.0],
    transform: GradientRotation(155 * 3.14159265 / 180),
  );

  /// Tools header gradient: linear-gradient(155deg, #c2e0cd 0%, #d8eadd 35%, #edf4f0 65%, #f7f0e4 100%)
  static const LinearGradient toolsHeader = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFC2E0CD),
      Color(0xFFD8EADD),
      Color(0xFFEDF4F0),
      Color(0xFFF7F0E4),
    ],
    stops: [0.0, 0.35, 0.65, 1.0],
    transform: GradientRotation(155 * 3.14159265 / 180),
  );

  /// Discover header gradient: linear-gradient(180deg, #f0f6f2 0%, rgba(240,246,242,0.95) 100%)
  static const LinearGradient discoverHeader = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF0F6F2), Color(0xFFF0F6F2)],
  );

  /// Invite hero gradient: linear-gradient(155deg, #e7f0e9 0%, #eef5ee 35%, #f7f3ec 65%, #fdf8ef 100%)
  static const LinearGradient inviteHero = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE7F0E9),
      Color(0xFFEEF5EE),
      Color(0xFFF7F3EC),
      Color(0xFFFDF8EF),
    ],
    stops: [0.0, 0.35, 0.65, 1.0],
    transform: GradientRotation(155 * 3.14159265 / 180),
  );

  /// About hero gradient: linear-gradient(160deg, #1f4b39 0%, #2f6b52 60%, #3d8a69 100%)
  static const LinearGradient aboutHero = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.primary, AppColors.forestLight, Color(0xFF3D8A69)],
    stops: [0.0, 0.60, 1.0],
    transform: GradientRotation(160 * 3.14159265 / 180),
  );

  /// Orders success banner: linear-gradient(90deg, #e4efe7 0%, #eef5ee 100%)
  static const LinearGradient successBanner = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFE4EFE7), Color(0xFFEEF5EE)],
  );

  /// Notice banner gradient: linear-gradient(90deg, #e4efe7 0%, #f4ece0 100%)
  static const LinearGradient noticeBanner = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFFE4EFE7), Color(0xFFF4ECE0)],
  );

  /// Discover stats strip: linear-gradient(135deg, #f0f6f2 0%, #f9f3e7 100%)
  static const LinearGradient discoverStats = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF0F6F2), Color(0xFFF9F3E7)],
  );

  /// Result/AI promo gradient: linear-gradient(135deg, #1f4b39 0%, #2f6b52 100%)
  static const LinearGradient promo = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary, AppColors.forestLight],
  );

  /// Discover featured banner: linear-gradient(135deg, #1f4b39 0%, #2d6b50 50%, #3a7a5e 100%)
  static const LinearGradient discoverFeatured = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primary, AppColors.forestMid, Color(0xFF3A7A5E)],
  );
}

/// Body background radial overlays (sage top-left, gold top-right).
/// Use as a decorative Stack layer behind content.
class AppBackgroundPaint {
  static Widget overlay({Widget? child}) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(painter: _BodyBgPainter()),
        ),
        if (child != null) child,
      ],
    );
  }
}

class _BodyBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // sage glow at 12% 0%
    canvas.drawCircle(
      Offset(size.width * 0.12, 0),
      size.width * 0.6,
      Paint()
        ..shader = RadialGradient(
          colors: [AppColors.secondary.withValues(alpha: 0.22), Colors.transparent],
        ).createShader(Rect.fromCircle(
            center: Offset(size.width * 0.12, 0), radius: size.width * 0.6)),
    );
    // gold glow at 100% 8%
    canvas.drawCircle(
      Offset(size.width, size.height * 0.08),
      size.width * 0.55,
      Paint()
        ..shader = RadialGradient(
          colors: [AppColors.accent.withValues(alpha: 0.12), Colors.transparent],
        ).createShader(Rect.fromCircle(
            center: Offset(size.width, size.height * 0.08),
            radius: size.width * 0.55)),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
