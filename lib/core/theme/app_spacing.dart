import 'package:flutter/material.dart';
import '../utils/responsive_extension.dart';

class AppSpacing {
  static double screenPadding(BuildContext context) =>
      context.rs.adaptive(mobile: 20, tablet: 28, desktop: 36);

  static double sectionGap(BuildContext context) =>
      context.rs.adaptive(mobile: 24, tablet: 28, desktop: 32);

  static double itemGap(BuildContext context) =>
      context.rs.adaptive(mobile: 12, tablet: 14, desktop: 16);

  static double bigGap(BuildContext context) =>
      context.rs.adaptive(mobile: 36, tablet: 44, desktop: 52);

  static double buttonHeight(BuildContext context) =>
      context.rs.adaptive(mobile: 54, tablet: 56, desktop: 58);

  static BorderRadius cardRadius(BuildContext context) =>
      BorderRadius.circular(
        context.rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
      );
}