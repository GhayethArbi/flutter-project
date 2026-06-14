import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract class AppTextStyles {
  static const onboardingTitle = TextStyle(
    color: AppColors.white,
    fontSize: 19,
    fontWeight: FontWeight.w600,
    height: 1.55,
  );

  static const skipButton = TextStyle(
    color: AppColors.grey,
    fontSize: 14,
    letterSpacing: 0.4,
  );

  static const buttonLabel = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.3,
  );

  static const TextStyle onboardingDescription = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: AppColors.subtitleOnBoarding, // adaptez selon votre palette (ex: Colors.white60)
  height: 1.55,
);
}