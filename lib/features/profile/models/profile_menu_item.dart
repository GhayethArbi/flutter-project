import 'package:flutter/material.dart';

/// A route key used to identify where a menu item should navigate.
/// Keeping navigation out of the model lets items remain `const`.
enum ProfileMenuRoute {
  personalInfo,
  myVehicles,
  payment,
  referral,
  // electricRecharge,
  parkingProfessionals,
  helpCenter,
  safetyInstructions,
  signOut,
  aboutUs,
}

class ProfileMenuItem {
  const ProfileMenuItem({
    required this.title,
    required this.icon,
    this.route,
    this.showDivider = true,
  });

  final String title;
  final IconData icon;

  /// Nullable — items without a route (e.g. sign-out handled separately) leave this null.
  final ProfileMenuRoute? route;
  final bool showDivider;
}