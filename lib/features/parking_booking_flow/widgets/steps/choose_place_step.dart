import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_booking_flow/cubit/parking_booking_flow_cubit.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class ChoosePlaceStep extends StatelessWidget {
  const ChoosePlaceStep({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final state = context.watch<ParkingBookingFlowCubit>().state;
    final parking = state.parking;
    final tariff = parking.tariff;
    final availableSpots = parking.spots;
    final isAvailable = availableSpots > 0;
    final monthlyPrice = tariff?.pricePerMonth ?? parking.price;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.pourToutVehicule,
          style: TextStyle(
            fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: rs.adaptive(mobile: 16, tablet: 18, desktop: 20)),
        _PlaceCard(
          icon: Icons.directions_car_outlined,
          title: AppStrings.placeVoiture,
          subtitle: isAvailable
              ? '$availableSpots place${availableSpots > 1 ? 's' : ''} disponible${availableSpots > 1 ? 's' : ''}'
              : 'Complet',
          price: '${monthlyPrice.toStringAsFixed(3)}DT\npar mois',
          isSelected: state.selectedPlaceId == 'car',
          onTap: isAvailable
              ? () => context.read<ParkingBookingFlowCubit>().selectPlace('car')
              : () {},
        ),
        // const SizedBox(height: 12),
        // _PlaceCard(
        //   icon: Icons.two_wheeler_outlined,
        //   title: AppStrings.placeMoto,
        //   subtitle: AppStrings.complet,
        //   price: '55DT\npar mois',
        //   isSelected: state.selectedPlaceId == 'moto',
        //   onTap: () => context.read<ParkingBookingFlowCubit>().selectPlace('moto'),
        // ),
      ],
    );
  }
}

class _PlaceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlaceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? const Color(0xFFB7F000)
        : const Color(0xFFDDE7A5);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF7FDE9) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              price,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
