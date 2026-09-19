import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import 'common.dart';

enum ActionButtonVariant { primary, ghost }
enum ActionButtonRadius { normal, full }

/// Full-width CTA button.
/// Mirrors src/components/ActionButton.tsx.
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    this.onTap,
    this.variant = ActionButtonVariant.primary,
    this.radius = ActionButtonRadius.normal,
    this.disabled = false,
    this.icon,
    this.height = 52,
  });

  final String label;
  final VoidCallback? onTap;
  final ActionButtonVariant variant;
  final ActionButtonRadius radius;
  final bool disabled;
  final IconData? icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == ActionButtonVariant.primary;
    final r = radius == ActionButtonRadius.full ? 999.0 : 16.0;

    return PressableScale(
      disabled: disabled,
      onTap: onTap,
      child: Opacity(
        opacity: disabled ? 0.5 : 1.0,
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: isPrimary ? AppColors.primary : AppColors.card,
            gradient: isPrimary
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF245A44), AppColors.primary],
                  )
                : null,
            borderRadius: BorderRadius.circular(r),
            border: isPrimary ? null : Border.all(color: AppColors.border),
            boxShadow: isPrimary && !disabled ? AppShadows.custom : null,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: isPrimary ? Colors.white : AppColors.foreground),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: isPrimary
                    ? AppTheme.display(size: 15, weight: FontWeight.w600, color: Colors.white)
                    : AppTheme.sans(size: 14, weight: FontWeight.w600, color: AppColors.foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A smaller pill-style button used inline (e.g. "立即使用", "去签到").
class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.label,
    this.onTap,
    this.bg,
    this.fg = Colors.white,
    this.borderColor,
    this.icon,
    this.fontSize = 12.5,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    this.gradient,
  });

  final String label;
  final VoidCallback? onTap;
  final Color? bg;
  final Color fg;
  final Color? borderColor;
  final IconData? icon;
  final double fontSize;
  final EdgeInsets padding;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return PressableScale(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: bg,
          gradient: gradient,
          borderRadius: BorderRadius.circular(999),
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: fontSize + 3, color: fg),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: AppTheme.sans(size: fontSize, weight: FontWeight.w600, color: fg),
            ),
          ],
        ),
      ),
    );
  }
}
