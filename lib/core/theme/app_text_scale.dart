import 'package:flutter/material.dart';
import '../utils/responsive_extension.dart';

class AppTextScale {
  static double title(BuildContext context) =>
      context.rs.adaptive(mobile: 20, tablet: 22, desktop: 24);

  static double subtitle(BuildContext context) =>
      context.rs.adaptive(mobile: 14, tablet: 15, desktop: 16);

  static double body(BuildContext context) =>
      context.rs.adaptive(mobile: 13, tablet: 14, desktop: 15);

  static double button(BuildContext context) =>
      context.rs.adaptive(mobile: 15, tablet: 16, desktop: 17);
}