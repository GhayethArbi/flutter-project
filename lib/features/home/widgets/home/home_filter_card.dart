import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import 'home_address_field.dart';
import 'home_booking_section.dart';
import 'home_mode_toggle.dart';
import 'home_vehicle_dropdown.dart';

class HomeFilterCard extends StatelessWidget {
  const HomeFilterCard({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final horizontalPadding = rs.adaptive(
      mobile: 10,
      tablet: 14,
      desktop: 18,
    );

    final topPadding = rs.adaptive(
      mobile: 10,
      tablet: 14,
      desktop: 18,
    );

    final bottomPadding = rs.adaptive(
      mobile: 12,
      tablet: 16,
      desktop: 20,
    );

    final radius = rs.adaptive(
      mobile: 18,
      tablet: 22,
      desktop: 24,
    );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          topPadding,
          horizontalPadding,
          bottomPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeModeToggle(),
            SizedBox(height: rs.adaptive(mobile: 18, tablet: 20, desktop: 24)),

            const HomeAddressField(),
            SizedBox(height: rs.adaptive(mobile: 16, tablet: 18, desktop: 22)),

            const HomeVehicleDropdown(),

            const HomeBookingSection(),
          ],
        ),
      ),
    );
  }
}