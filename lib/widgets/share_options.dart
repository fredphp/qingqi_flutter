import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_icons.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Row of share method buttons (WeChat / Save / Link / etc).
/// Mirrors src/components/ShareOptions.tsx.
class ShareOptions extends StatelessWidget {
  const ShareOptions({
    super.key,
    required this.methods,
    this.onTap,
  });

  final List<ShareMethod> methods;
  final ValueChanged<ShareMethod>? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: methods.asMap().entries.map((entry) {
        final m = entry.value;
        final isLast = entry.key == methods.length - 1;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: isLast ? 0 : 12), // gap-3
            child: PressableScale(
              onTap: onTap == null ? null : () => onTap!(m),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 52,
                    height: 52, // h-52 w-52
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                      boxShadow: AppShadows.soft,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      AppIcons.resolve(m.icon),
                      size: 21,
                      color: AppColors.fromHex('#1f4b39'),
                    ),
                  ),
                  const SizedBox(height: 6), // gap 6
                  Text(
                    m.label,
                    style: AppTheme.sans(
                      size: 11.5,
                      weight: FontWeight.w500,
                      color: AppColors.foreground,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
