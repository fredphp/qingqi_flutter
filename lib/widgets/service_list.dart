import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../data/mock_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_icons.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';

/// Grouped list of profile service entries (orders / downloads / …).
/// Mirrors src/components/ServiceList.tsx.
class ServiceList extends StatelessWidget {
  const ServiceList({
    super.key,
    required this.items,
    this.onTap,
  });

  final List<ServiceItem> items;
  final void Function(ServiceItem item)? onTap;

  static const Map<String, _ChipStyle> _styles = {
    'orders': _ChipStyle(bg: Color(0x1A1F4B39), icon: Color(0xFF1F4B39)), // rgba(31,75,57,0.10)
    'downloads': _ChipStyle(bg: Color(0x1F4A7A63), icon: Color(0xFF2D6B50)), // rgba(74,122,99,0.12)
    'history': _ChipStyle(bg: Color(0x267FA88A), icon: Color(0xFF4A7A63)), // rgba(127,168,138,0.15)
    'favorites': _ChipStyle(bg: Color(0x24C9A96A), icon: Color(0xFFB08A3A)), // rgba(201,169,106,0.14)
    'redeem': _ChipStyle(bg: Color(0x24C9A96A), icon: Color(0xFFC9A96A)), // rgba(201,169,106,0.14)
    'help': _ChipStyle(bg: Color(0x171F4B39), icon: Color(0xFF2D6B50)), // rgba(31,75,57,0.09)
    'settings': _ChipStyle(bg: Color(0x1F7FA88A), icon: Color(0xFF4A7A63)), // rgba(127,168,138,0.12)
    'about': _ChipStyle(bg: Color(0x1A1F4B39), icon: Color(0xFF1F4B39)), // rgba(31,75,57,0.10)
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _ServiceRow(
              item: items[i],
              onTap: () => onTap?.call(items[i]),
            ),
            if (i != items.length - 1)
              Container(
                margin: const EdgeInsets.only(left: 62),
                height: 1,
                color: AppColors.dividerWarm, // #f0ebe0
              ),
          ],
        ],
      ),
    );
  }
}

class _ChipStyle {
  const _ChipStyle({required this.bg, required this.icon});
  final Color bg;
  final Color icon;
}

class _ServiceRow extends StatefulWidget {
  const _ServiceRow({required this.item, required this.onTap});
  final ServiceItem item;
  final VoidCallback onTap;

  @override
  State<_ServiceRow> createState() => _ServiceRowState();
}

class _ServiceRowState extends State<_ServiceRow> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final style = ServiceList._styles[widget.item.id] ??
        const _ChipStyle(bg: Color(0x171F4B39), icon: Color(0xFF1F4B39));
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        color: _pressed ? const Color(0x66F1EDE1) : Colors.transparent, // muted/40
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: style.bg,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                AppIcons.resolve(widget.item.icon),
                size: 16,
                color: style.icon,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                widget.item.label,
                style: AppTheme.sans(
                  size: 13.5,
                  weight: FontWeight.w500,
                  color: AppColors.foreground,
                ),
              ),
            ),
            const Icon(
              LucideIcons.chevronRight,
              size: 14,
              color: AppColors.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }
}
