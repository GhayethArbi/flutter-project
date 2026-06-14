import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  Size get size => MediaQuery.sizeOf(context);
  double get w => size.width;
  double get h => size.height;

  bool get isMobile => w < 600;
  bool get isTablet => w >= 600 && w < 1024;
  bool get isDesktop => w >= 1024;

  double wp(double percent) => w * percent;
  double hp(double percent) => h * percent;

  double adaptive({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isDesktop) return desktop ?? tablet ?? mobile;
    if (isTablet) return tablet ?? mobile;
    return mobile;
  }

  double clampSize(double value, double min, double max) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }
}