import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_map/cubit/parking_map_cubit.dart';
import 'package:tunipark/features/parking_map/cubit/parking_map_state.dart';

import 'parking_card_item.dart';

class ParkingCardsSection extends StatelessWidget {
  final PageController pageController;

  const ParkingCardsSection({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocBuilder<ParkingMapCubit, ParkingMapState>(
      builder: (context, state) {
        return SizedBox(
          height: rs.adaptive(mobile: 185, tablet: 200, desktop: 215),
          child: PageView.builder(
            controller: pageController,
            itemCount: state.parkings.length,
            onPageChanged: (index) {
              context.read<ParkingMapCubit>().selectParkingFromCard(index);
            },
            itemBuilder: (context, index) {
              final parking = state.parkings[index];

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: rs.wp(0.015)),
                child: ParkingCardItem(
                  parking: parking,
                  isSelected: index == state.selectedIndex,
                  isBestRecommendation: index == 0,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
