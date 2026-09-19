import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Reusable shadow definitions matching the CSS @utility shadow classes.
class AppShadows {
  AppShadows._();

  /// shadow-soft: 0 6px 18px rgba(31,75,57,0.07), 0 1px 3px rgba(31,75,57,0.04)
  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x121F4B39), // rgba(31,75,57,0.07)
      blurRadius: 18,
      offset: Offset(0, 6),
    ),
    BoxShadow(
      color: Color(0x0A1F4B39), // rgba(31,75,57,0.04)
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
  ];

  /// shadow-custom: 0px 10px 30px 0px rgba(31,75,57,0.10)
  static const List<BoxShadow> custom = [
    BoxShadow(
      color: Color(0x1A1F4B39), // rgba(31,75,57,0.10)
      blurRadius: 30,
      offset: Offset(0, 10),
    ),
  ];

  /// Card decoration helper: rounded-3xl (24) card with soft shadow + warm border.
  static BoxDecoration card({
    Color color = AppColors.card,
    double radius = 24,
    Color borderColor = AppColors.border,
    double borderWidth = 1,
    List<BoxShadow>? shadows,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: borderWidth),
      boxShadow: shadows ?? soft,
    );
  }
}
