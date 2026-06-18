// ── Header ────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/features/profile/cubit/profile_state.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileState state;

  const ProfileHeader({required this.state});

  String _getInitials(String firstName, String lastName) {
    return '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}';
  }

  @override
  Widget build(BuildContext context) {
    final user = state.user;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFB7F000),
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
      ),
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _getInitials(user?.firstName ?? '', user?.lastName ?? ''),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.bonjour, style: TextStyle(fontSize: 12)),

                Text(
                  user?.fullName ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                Text(
                  user?.email ?? user?.phoneNumber ?? '',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),

          // Edit button
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.personalInfo);
            },
            icon: const Icon(Icons.edit, size: 18),
          ),
        ],
      ),
    );
  }
}
