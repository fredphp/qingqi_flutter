import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import '../theme/app_theme.dart';
import 'common.dart';

/// Profile page header rendered on a dark forest background.
/// Mirrors src/components/ProfileHeader.tsx.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    this.nickname = '轻启用户',
    this.uid = 'UID 8821943',
    this.avatar = '',
    this.onEdit,
  });

  final String nickname;
  final String uid;
  final String avatar;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final initial = nickname.isNotEmpty ? nickname.substring(0, 1).toUpperCase() : 'U';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // ---- Avatar + glow ring + VIP badge ----
          SizedBox(
            width: 84,
            height: 88,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // glow ring (behind, inset -3px)
                Positioned(
                  left: -3,
                  top: -3,
                  right: -3,
                  bottom: 5, // leave space for VIP badge
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xCCC9A96A), // rgba(201,169,106,0.8)
                          Color(0x99A6C0AB), // rgba(166,192,171,0.6)
                          Color(0x4DFFFFFF), // rgba(255,255,255,0.3)
                        ],
                        stops: [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 72,
                    height: 72,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xCCFFFFFF), width: 2.5),
                    ),
                    child: avatar.isNotEmpty
                        ? NetImage(avatar, width: 72, height: 72, fit: BoxFit.cover)
                        : Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              gradient: AppGradients.avatarFallback,
                            ),
                            child: Text(
                              initial,
                              style: AppTheme.display(
                                size: 28,
                                weight: FontWeight.w700,
                                color: const Color(0xF2C9A96A), // rgba(201,169,106,0.95)
                              ),
                            ),
                          ),
                  ),
                ),
                // VIP badge
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Center(
                    child: Transform.translate(
                      offset: const Offset(0, -2),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          gradient: AppGradients.vipBadge,
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x80C9A96A), // rgba(201,169,106,0.5)
                              blurRadius: 6,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(LucideIcons.crown, size: 8, color: AppColors.crownBrown),
                            const SizedBox(width: 2),
                            Text(
                              'VIP',
                              style: AppTheme.display(
                                size: 9,
                                weight: FontWeight.w700,
                                color: AppColors.crownBrown,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // ---- Info column ----
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          nickname,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.display(
                            size: 20,
                            weight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.2,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        LucideIcons.checkCircle,
                        size: 15,
                        color: Color(0xE6C9A96A), // rgba(201,169,106,0.9)
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0x26FFFFFF), // rgba(255,255,255,0.15)
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          uid,
                          style: AppTheme.sans(
                            size: 10,
                            weight: FontWeight.w500,
                            color: const Color(0xBFFFFFFF), // rgba(255,255,255,0.75)
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0x40C9A96A), // rgba(201,169,106,0.25)
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          'Lv.5 探索者',
                          style: AppTheme.sans(
                            size: 10,
                            weight: FontWeight.w600,
                            color: const Color(0xF2DCBE82), // rgba(220,190,130,0.95)
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 6,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: const Color(0x2EFFFFFF), // rgba(255,255,255,0.18)
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: 0.68,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: AppGradients.xpBar,
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '680 / 1000 XP',
                        style: AppTheme.sans(
                          size: 10,
                          color: const Color(0x8CFFFFFF), // rgba(255,255,255,0.55)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // ---- Edit button ----
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: PressableScale(
              onTap: onEdit,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0x29FFFFFF), // rgba(255,255,255,0.16)
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: const Color(0x4DFFFFFF)), // rgba(255,255,255,0.3)
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LucideIcons.pencil, size: 11, color: Color(0xE6FFFFFF)),
                        const SizedBox(width: 6),
                        Text(
                          '编辑',
                          style: AppTheme.sans(
                            size: 11.5,
                            weight: FontWeight.w600,
                            color: const Color(0xE6FFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
