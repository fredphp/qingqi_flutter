import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// VIP plan radio card used in the VIP page plan picker.
/// Mirrors src/components/PlanCard.tsx.
class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.plan,
    this.selected = false,
    this.onTap,
  });

  final VipPlan plan;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final border = selected ? AppColors.accent : const Color(0xFFE8E2D5);
    final bg = selected ? const Color(0xFFFDF8EC) : AppColors.card;
    return PressableScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: border, width: selected ? 1.5 : 1),
          boxShadow: selected
              ? const [
                  BoxShadow(
                    color: Color(0x2EC9A96A), // rgba(201,169,106,0.18)
                    blurRadius: 18,
                    offset: Offset(0, 6),
                  ),
                ]
              : AppShadows.soft,
        ),
        child: Row(
          children: [
            // radio
            Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.accent : AppColors.unselectedRadio,
                  width: 2,
                ),
                color: selected ? AppColors.accent : Colors.transparent,
              ),
              child: selected
                  ? Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          plan.name,
                          style: AppTheme.display(
                            size: 14.5,
                            weight: FontWeight.w600,
                            color: AppColors.foreground,
                          ),
                        ),
                      ),
                      if (plan.badge.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.goldSoft,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            plan.badge,
                            style: AppTheme.sans(
                              size: 10,
                              weight: FontWeight.w500,
                              color: AppColors.goldBrown,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    plan.period,
                    style: AppTheme.sans(size: 11, color: AppColors.mutedForeground),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              plan.price,
              style: AppTheme.display(
                size: 18,
                weight: FontWeight.w600,
                color: AppColors.goldDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
