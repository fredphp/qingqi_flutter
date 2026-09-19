import 'package:flutter/material.dart';
import '../theme/lucide_icons.dart';
import '../theme/app_colors.dart';

/// Decorative botanical backdrop: rotated leaf/sprout/trees icons + two soft
/// white radial blobs. Place behind content inside a Stack. Pointer-events
/// are ignored (IgnorePointer).
/// Mirrors src/components/BotanicalBackdrop.tsx.
class BotanicalBackdrop extends StatelessWidget {
  const BotanicalBackdrop({super.key, this.tone = 'light'});

  /// 'dark' or 'light'.
  final String tone;

  @override
  Widget build(BuildContext context) {
    final bool isDark = tone == 'dark';
    final Color iconColor = isDark
        ? Colors.white.withValues(alpha: 0.16)
        : AppColors.primary.withValues(alpha: 0.14);
    final Color blobColor = Colors.white.withValues(alpha: isDark ? 0.06 : 0.5);

    // Returns a Positioned.fill — must be placed inside a parent Stack.
    return Positioned.fill(
      child: IgnorePointer(
        child: ClipRect(
          child: Stack(
            children: [
              // Radial blobs (decorative)
              Positioned(
                left: -60,
                top: -40,
                child: _Blob(size: 200, color: blobColor),
              ),
              Positioned(
                right: -80,
                bottom: -60,
                child: _Blob(size: 240, color: blobColor),
              ),
              // LeafIcon 130 at top-right, rotate -18deg
              Positioned(
                top: -10,
                right: -20,
                child: Transform.rotate(
                  angle: -18 * 3.14159265 / 180,
                  child: Icon(LucideIcons.leaf, size: 130, color: iconColor),
                ),
              ),
              // SproutIcon 86 at bottom-left, rotate 14deg
              Positioned(
                bottom: -8,
                left: -12,
                child: Transform.rotate(
                  angle: 14 * 3.14159265 / 180,
                  child: Icon(LucideIcons.sprout, size: 86, color: iconColor),
                ),
              ),
              // TreesIcon 72 at bottom-right, rotate -8deg
              Positioned(
                bottom: -10,
                right: -8,
                child: Transform.rotate(
                  angle: -8 * 3.14159265 / 180,
                  child: Icon(LucideIcons.trees, size: 72, color: iconColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: Size.square(size),
        painter: _BlobPainter(size: size, color: color),
      ),
    );
  }
}

class _BlobPainter extends CustomPainter {
  _BlobPainter({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final rect = Rect.fromCircle(center: Offset(size / 2, size / 2), radius: size / 2);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, color.withValues(alpha: 0.0)],
      ).createShader(rect);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2, paint);
  }

  @override
  bool shouldRepaint(covariant _BlobPainter old) =>
      old.size != size || old.color != color;
}
