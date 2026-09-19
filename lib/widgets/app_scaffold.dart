import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_gradients.dart';
import 'bottom_nav.dart';

/// The mobile canvas shell: constrains content to a max width of 420px and
/// centers it (mirroring the React `max-w-[420px] mx-auto` container).
/// Optionally renders the bottom navigation bar.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.child,
    this.activeTab,
    this.backgroundColor,
    this.extendBody = false,
  });

  final Widget child;
  /// Which bottom-nav tab is active. null => no bottom nav rendered.
  final String? activeTab;
  final Color? backgroundColor;
  /// When true, content draws behind the bottom nav (nav floats).
  final bool extendBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Stack(
            children: [
              // subtle body radial gradients (sage top-left, gold top-right)
              Positioned.fill(child: AppBackgroundPaint.overlay()),
              // page content
              Positioned.fill(
                child: SafeArea(
                  top: false,
                  bottom: false,
                  child: child,
                ),
              ),
              // floating bottom nav
              if (activeTab != null)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: BottomNav(active: activeTab!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
