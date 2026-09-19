import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Daily task card used on the Profile page (checkin / invite).
/// Mirrors src/components/TaskCard.tsx.
class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    this.done = false,
    this.onAction,
  });

  final TaskItem task;
  final bool done;
  final VoidCallback? onAction;

  bool get _isCheckin => task.id == 'checkin';
  bool get _isInvite => task.id == 'invite';

  @override
  Widget build(BuildContext context) {
    final border = _isCheckin
        ? const Color(0x1F1F4B39) // rgba(31,75,57,0.12)
        : const Color(0x2EC9A96A); // rgba(201,169,106,0.18)
    final iconGradient = _isCheckin
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(145 * 3.14159265 / 180),
            colors: [Color(0xFF2D6B50), AppColors.primary],
          )
        : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(145 * 3.14159265 / 180),
            colors: [Color(0xFFD4A84B), AppColors.accent],
          );
    final iconShadow = _isCheckin
        ? const Color(0x591F4B39) // rgba(31,75,57,0.35)
        : const Color(0x66C9A96A); // rgba(201,169,106,0.40)
    final btnShadow = _isCheckin
        ? const Color(0x4D1F4B39) // rgba(31,75,57,0.30)
        : const Color(0x59C9A96A); // rgba(201,169,106,0.35)

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
        boxShadow: AppShadows.soft,
      ),
      child: Stack(
        children: [
          // ---- background decoration ----
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: 150,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.transparent,
                    _isCheckin
                        ? const Color(0x1FA6C0AB) // rgba(166,192,171,0.12)
                        : const Color(0x1AC9A96A), // rgba(201,169,106,0.10)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (_isCheckin ? AppColors.secondary : const Color(0xFFE8C87A))
                    .withValues(alpha: 0.30),
              ),
            ),
          ),
          Positioned(
            right: -8,
            bottom: 8,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (_isCheckin ? AppColors.primary : AppColors.accent)
                    .withValues(alpha: 0.15),
              ),
            ),
          ),

          // ---- body ----
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // icon block
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: iconGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: iconShadow,
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    AppIcons.resolve(task.icon),
                    size: 22,
                    color: const Color(0xEBFFFFFF), // rgba(255,255,255,0.92)
                  ),
                ),
                const SizedBox(width: 14),
                // text + reward
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              task.title,
                              style: AppTheme.sans(
                                size: 14,
                                weight: FontWeight.w600,
                                color: AppColors.foreground,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          if (done)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0x264CAF7D), // rgba(76,175,125,0.15)
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const Text(
                                '今日已完成',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.success,
                                  height: 1.1,
                                ),
                              ),
                            )
                          else
                            const Icon(LucideIcons.sparkles, size: 11, color: AppColors.accent),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _isCheckin ? '坚持签到，积累更多奖励' : '每成功邀请1位好友',
                        style: AppTheme.sans(size: 12, color: AppColors.mutedForeground),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // reward pill
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: _isCheckin
                                  ? const Color(0x141F4B39) // rgba(31,75,57,0.08)
                                  : const Color(0x21C9A96A), // rgba(201,169,106,0.13)
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _isInvite ? LucideIcons.gift : LucideIcons.coins,
                                  size: 10,
                                  color: done
                                      ? AppColors.mutedForeground
                                      : (_isInvite ? AppColors.accent : AppColors.accent),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  task.reward,
                                  style: AppTheme.display(
                                    size: 11.5,
                                    weight: FontWeight.w600,
                                    color: done
                                        ? AppColors.mutedForeground
                                        : (_isCheckin ? AppColors.primary : AppColors.goldBrown3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_isCheckin && !done) ...[
                            const SizedBox(width: 6),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (int d = 1; d <= 7; d++) ...[
                                  if (d > 1) const SizedBox(width: 2),
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: d <= 3
                                          ? AppColors.primary
                                          : const Color(0x331F4B39), // rgba(31,75,57,0.2)
                                    ),
                                  ),
                                ],
                                const SizedBox(width: 4),
                                Text(
                                  '3/7天',
                                  style: AppTheme.sans(
                                    size: 10,
                                    color: AppColors.mutedForeground,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (_isInvite) ...[
                            const SizedBox(width: 6),
                            Text(
                              '已邀请 2 位好友',
                              style: AppTheme.sans(
                                size: 10,
                                color: AppColors.mutedForeground,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // action button
                _ActionBtn(
                  label: task.action,
                  done: done,
                  gradient: iconGradient,
                  shadowColor: btnShadow,
                  onTap: onAction,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  const _ActionBtn({
    required this.label,
    required this.done,
    required this.gradient,
    required this.shadowColor,
    this.onTap,
  });

  final String label;
  final bool done;
  final Gradient gradient;
  final Color shadowColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (done) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0x1F4CAF7D), // rgba(76,175,125,0.12)
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(LucideIcons.checkCircle, size: 16, color: AppColors.success),
      );
    }
    return PressableScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTheme.sans(size: 12, weight: FontWeight.w600, color: Colors.white),
            ),
            const SizedBox(width: 2),
            const Icon(LucideIcons.arrowRight, size: 11, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
