import 'package:flutter/material.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/features/parking_map/models/parking_place.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/constants/app_strings2.dart';

class BottomBar extends StatelessWidget {
  final ParkingPlace parking;
  final dynamic rs;
  const BottomBar({required this.parking, required this.rs});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        rs.adaptive(mobile: 16.0, tablet: 24.0, desktop: 32.0),
        12,
        rs.adaptive(mobile: 16.0, tablet: 24.0, desktop: 32.0),
        MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${parking.price.toInt()} DT',
                      style: TextStyle(
                        fontSize: rs.adaptive(
                          mobile: 24.0,
                          tablet: 26.0,
                          desktop: 28.0,
                        ),
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF173B6C),
                      ),
                    ),
                    TextSpan(
                      text: AppStrings2.month,
                      style: TextStyle(
                        fontSize: rs.adaptive(
                          mobile: 14.0,
                          tablet: 15.0,
                          desktop: 16.0,
                        ),
                        color: AppColors.grisText,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${parking.spots} place${parking.spots > 1 ? 's' : ''} disponible',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grisText,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamed(AppRoutes.parkingBookingFlow, arguments: parking);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorBtn,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(
                horizontal: rs.adaptive(
                  mobile: 28.0,
                  tablet: 36.0,
                  desktop: 44.0,
                ),
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: Text(AppStrings.voirLaDisponibilite,
              style: TextStyle(
                fontSize: rs.adaptive(
                  mobile: 15.0,
                  tablet: 16.0,
                  desktop: 17.0,
                ),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
