import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_map/cubit/parking_map_cubit.dart';
import 'package:tunipark/features/parking_map/cubit/parking_map_state.dart';

class ParkingBottomActions extends StatelessWidget {
  const ParkingBottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocBuilder<ParkingMapCubit, ParkingMapState>(
      builder: (context, state) {
        final isMapMode = state.isMapMode;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: rs.wp(0.2)),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colorBtn,
              foregroundColor: Colors.black,
              minimumSize: Size.fromHeight(
                rs.adaptive(mobile: 52, tablet: 56, desktop: 60),
              ),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  rs.adaptive(mobile: 16, tablet: 18, desktop: 20),
                ),
              ),
            ),
            onPressed: () {
              final cubit = context.read<ParkingMapCubit>();

              if (isMapMode) {
                cubit.showList();
              } else {
                cubit.showMap();
              }
            },
            icon: Icon(
              isMapMode ? Icons.list : Icons.map_outlined,
              color: Colors.black,
            ),
            label: Text(
              isMapMode ? 'List' : 'Map',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}
