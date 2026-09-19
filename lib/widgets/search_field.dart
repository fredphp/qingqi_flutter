import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_theme.dart';

/// Three search field variants mirroring src/components/SearchField.tsx:
///  - solid: card-style search row with mint-soft action button (Home/Tools).
///  - glass: glassmorphic surface used inside the dark HeroBanner (white text).
///  - pill:  rounded-full translucent search used on the Tools page.
class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.variant = 'solid',
    this.value = '',
    this.onChanged,
    this.placeholder = '搜索工具、功能或关键词',
    this.onSearch,
  });

  final String variant;
  final String value;
  final ValueChanged<String>? onChanged;
  final String placeholder;
  final VoidCallback? onSearch;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode()..addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(covariant SearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      // keep external value in sync without losing cursor on user typing
      final sel = _controller.selection;
      _controller.text = widget.value;
      if (_controller.text.length >= sel.start) {
        _controller.selection = sel;
      }
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() => _focused = _focusNode.hasFocus);
  }

  void _submit() {
    _focusNode.unfocus();
    widget.onSearch?.call();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.variant) {
      case 'glass':
        return _buildGlass();
      case 'pill':
        return _buildPill();
      case 'solid':
      default:
        return _buildSolid();
    }
  }

  // ---------- solid ----------
  Widget _buildSolid() {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 6, top: 6, bottom: 6),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.search, size: 18, color: AppColors.mutedForeground),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              style: AppTheme.sans(size: 14, color: AppColors.foreground),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.placeholder,
                hintStyle: AppTheme.sans(size: 14, color: AppColors.placeholderGray),
                contentPadding: const EdgeInsets.symmetric(vertical: 6),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _submit(),
              onChanged: widget.onChanged,
            ),
          ),
          const SizedBox(width: 8),
          _RoundAction(
            onTap: _submit,
            child: const Icon(LucideIcons.search, size: 14, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  // ---------- glass ----------
  Widget _buildGlass() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.only(left: 14, right: 6, top: 6, bottom: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(140 * 3.14159265 / 180),
              colors: [
                Color(0x80FFFFFF), // rgba(255,255,255,0.5)
                Color(0x24FFFFFF), // rgba(255,255,255,0.14)
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x6BFFFFFF)), // rgba(255,255,255,0.42)
          ),
          child: Row(
            children: [
              const Icon(LucideIcons.search, size: 18, color: Colors.white70),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  style: AppTheme.sans(size: 14, color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: widget.placeholder,
                    hintStyle: AppTheme.sans(size: 14, color: Colors.white54),
                    contentPadding: const EdgeInsets.symmetric(vertical: 6),
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => _submit(),
                  onChanged: widget.onChanged,
                ),
              ),
              const SizedBox(width: 8),
              _RoundAction(
                onTap: _submit,
                color: const Color(0x33FFFFFF),
                child: const Icon(LucideIcons.search, size: 14, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- pill ----------
  Widget _buildPill() {
    final hasText = _controller.text.isNotEmpty;
    final accent = _focused || hasText;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.only(left: 12, right: 6, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: const Color(0xCCFFFFFF), // rgba(255,255,255,0.8)
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: accent ? AppColors.primary : const Color(0x2E1F4B39), // rgba(31,75,57,0.18)
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: accent
                ? const Color(0x1A1F4B39) // rgba(31,75,57,0.10)
                : const Color(0x141F4B39), // rgba(31,75,57,0.08)
            blurRadius: accent ? 0 : 4,
            spreadRadius: accent ? 3 : 0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            LucideIcons.search,
            size: 16,
            color: accent ? AppColors.primary : const Color(0xFF6A9E84),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              style: AppTheme.sans(size: 13.5, color: AppColors.foreground),
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.placeholder,
                hintStyle: AppTheme.sans(size: 13.5, color: AppColors.placeholderGray),
                contentPadding: const EdgeInsets.symmetric(vertical: 6),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _submit(),
              onChanged: (v) {
                setState(() {});
                widget.onChanged?.call(v);
              },
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: _submit,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent ? AppColors.primary : const Color(0x1A1F4B39), // rgba(31,75,57,0.10)
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.search,
                size: 12,
                color: accent ? Colors.white : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundAction extends StatelessWidget {
  const _RoundAction({required this.child, this.onTap, this.color});
  final Widget child;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? AppColors.mintSoft,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
      ),
    );
  }
}
