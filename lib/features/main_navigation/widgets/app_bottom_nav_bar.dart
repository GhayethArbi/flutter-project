import 'package:flutter/material.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/theme/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 8,
      selectedItemColor: AppColors.colorBtn,
      unselectedItemColor: Colors.black54,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.location_pin),
          label: AppStrings.explore,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.calendar_month),
          label: AppStrings.reservations,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.add_circle),
          label: AppStrings.announce,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.notifications),
          label: AppStrings.notifications,
        ),
        
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: AppStrings.monProfil,
        ),
      ],
    );
  }
}