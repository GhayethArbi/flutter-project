import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunipark/core/models/Vehicules_option.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class ParkingCompatibility extends StatelessWidget {
  final List<VehicleOption> vehicles;

  const ParkingCompatibility({super.key, required this.vehicles});

  static const Color _primaryColor = Color(0xFF173B6C);

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Compatible avec',
          style: TextStyle(
            fontSize: rs.adaptive(mobile: 16, tablet: 18, desktop: 20),
            fontWeight: FontWeight.w700,
            color: _primaryColor,
          ),
        ),

        SizedBox(height: rs.adaptive(mobile: 10, tablet: 12, desktop: 14)),

        Container(
          padding: EdgeInsets.all(
            rs.adaptive(mobile: 6, tablet: 8, desktop: 10),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFD0D5DD)),
            borderRadius: BorderRadius.circular(
              rs.adaptive(mobile: 12, tablet: 14, desktop: 16),
            ),
          ),

          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: vehicles.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rs.isDesktop ? 4 : 3,
                childAspectRatio: rs.adaptive(
                  mobile: 1.8,
                  tablet: 2.0,
                  desktop: 2.2,
                ),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (_, index) {
                final vehicle = vehicles[index];
                final color = vehicle.enabled ? Colors.black87 : Colors.black26;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      vehicle.iconAsset,
                      width: rs.adaptive(mobile: 28, tablet: 34, desktop: 40),
                      height: rs.adaptive(mobile: 28, tablet: 34, desktop: 40),
                      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                    ),
                    SizedBox(height: 6),
                    Text(
                      vehicle.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: rs.adaptive(
                          mobile: 11,
                          tablet: 13,
                          desktop: 15,
                        ),
                        fontWeight: FontWeight.w600,
                        color: color,
                        decoration: vehicle.enabled
                            ? null
                            : TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
