import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// A tappable widget that scales down slightly on press (mirrors the
/// `active:scale-[0.97]` Tailwind class used across the React app).
class PressableScale extends StatefulWidget {
  const PressableScale({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.97,
    this.disabled = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double scale;
  final bool disabled;

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 90),
  );

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (!widget.disabled) _ctrl.forward();
  }

  void _onTapUp(TapUpDetails _) {
    _ctrl.reverse();
  }

  void _onTapCancel() {
    _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.disabled ? null : widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: widget.scale).animate(
          CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
        ),
        child: widget.child,
      ),
    );
  }
}

/// Network image with a subtle placeholder + error fallback.
class NetImage extends StatelessWidget {
  const NetImage(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final img = CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, __) => Container(
        width: width,
        height: height,
        color: AppColors.muted,
      ),
      errorWidget: (_, __, ___) => Container(
        width: width,
        height: height,
        color: AppColors.muted,
        child: const Icon(Icons.broken_image_outlined, size: 18, color: AppColors.placeholderGray),
      ),
    );
    if (borderRadius != null) {
      return ClipRRect(borderRadius: BorderRadius.circular(borderRadius!), child: img);
    }
    return img;
  }
}

/// A small pill/tag widget.
class Pill extends StatelessWidget {
  const Pill({
    super.key,
    required this.text,
    this.bg,
    this.fg,
    this.radius = 999,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    this.fontSize = 11,
    this.weight = FontWeight.w500,
    this.border,
  });

  final String text;
  final Color? bg;
  final Color? fg;
  final double radius;
  final EdgeInsets padding;
  final double fontSize;
  final FontWeight weight;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg ?? AppColors.primary,
        borderRadius: BorderRadius.circular(radius),
        border: border,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: weight,
          color: fg ?? Colors.white,
          height: 1.1,
        ),
      ),
    );
  }
}

/// Vertical divider line used inside stat grids.
class VDivider extends StatelessWidget {
  const VDivider({super.key, this.color, this.height = 24, this.width = 1});
  final Color? color;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      width: width,
      height: height,
      color: color ?? AppColors.dividerMuted,
    );
  }
}

/// Horizontal divider line.
class HDivider extends StatelessWidget {
  const HDivider({super.key, this.color, this.indent = 0, this.thickness = 1});
  final Color? color;
  final double indent;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: indent),
      height: thickness,
      color: color ?? AppColors.dividerWarm,
    );
  }
}
