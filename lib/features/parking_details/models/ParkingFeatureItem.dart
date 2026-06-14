import 'package:flutter/material.dart';

class ParkingFeatureItem {
  final IconData icon;
  final String title;
  final bool showInfo;

  const ParkingFeatureItem({
    required this.icon,
    required this.title,
    this.showInfo = false,
  });
}