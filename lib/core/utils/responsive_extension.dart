import 'package:flutter/material.dart';
import 'responsive.dart';

extension ResponsiveExtension on BuildContext {
  Responsive get rs => Responsive(this);
}