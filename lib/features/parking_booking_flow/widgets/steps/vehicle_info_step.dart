import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_booking_flow/cubit/parking_booking_flow_cubit.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class VehicleInfoStep extends StatelessWidget {
  const VehicleInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final state = context.watch<ParkingBookingFlowCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.selectionnezVotrePlaqueDimmatriculation,
          style: TextStyle(
            fontSize: rs.adaptive(mobile: 15, tablet: 16, desktop: 17),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: rs.adaptive(mobile: 18, tablet: 20, desktop: 22)),
        Row(
          children: [
            _PlateTypeItem(
              label: 'TN',
              isSelected: state.selectedPlateType == 'TN',
              onTap: () {
                context.read<ParkingBookingFlowCubit>().selectPlateType('TN');
              },
            ),
            const SizedBox(width: 18),
            _PlateTypeItem(
              label: 'RS',
              isSelected: state.selectedPlateType == 'RS',
              onTap: () {
                context.read<ParkingBookingFlowCubit>().selectPlateType('RS');
              },
            ),
          ],
        ),
        SizedBox(height: rs.adaptive(mobile: 20, tablet: 24, desktop: 28)),
        state.selectedPlateType == 'TN'
            ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFDDE7A5)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: state.plateLeftNumber,
                        onChanged: context
                            .read<ParkingBookingFlowCubit>()
                            .updatePlateLeftNumber,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          state.plateCenterText,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: state.plateRightNumber,
                        onChanged: context
                            .read<ParkingBookingFlowCubit>()
                            .updatePlateRightNumber,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFDDE7A5)),
                ),
                child: Center(
                  child: TextFormField(
                    initialValue: state.rsText,
                    onChanged: context
                        .read<ParkingBookingFlowCubit>()
                        .updateRsText,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
        SizedBox(height: rs.hp(0.30)),
        Row(
          children: [
            const Icon(Icons.add, size: 18),
            const SizedBox(width: 10),
            Text(AppStrings.ajouterUnePlaqueDimmatriculation,
              style: TextStyle(
                fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PlateTypeItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlateTypeItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? const Color(0xFFB7F000) : Colors.white,
              border: Border.all(color: const Color(0xFFB7F000)),
            ),
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
