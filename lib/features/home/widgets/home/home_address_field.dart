import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';
import '../../../parking_map/models/selected_place.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class HomeAddressField extends StatelessWidget {
  const HomeAddressField({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final labelFontSize = rs.adaptive(
      mobile: 15,
      tablet: 16,
      desktop: 17,
    );

    final fieldHeight = rs.adaptive(
      mobile: rs.clampSize(rs.hp(0.065), 50, 56),
      tablet: 58,
      desktop: 62,
    );

    final fieldRadius = rs.adaptive(
      mobile: 14,
      tablet: 16,
      desktop: 18,
    );

    final textFontSize = rs.adaptive(
      mobile: 14,
      tablet: 15,
      desktop: 16,
    );

    final iconSize = rs.adaptive(
      mobile: 20,
      tablet: 22,
      desktop: 24,
    );

    final horizontalPadding = rs.adaptive(
      mobile: 14,
      tablet: 16,
      desktop: 18,
    );

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.address != current.address ||
          previous.selectedPlace != current.selectedPlace,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.adresse,
              style: TextStyle(
                fontSize: labelFontSize,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3A3A3A),
              ),
            ),
            SizedBox(height: rs.adaptive(mobile: 8, tablet: 10, desktop: 12)),
            InkWell(
              borderRadius: BorderRadius.circular(fieldRadius),
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  AppRoutes.addressSearch,
                );

                if (!context.mounted) return;

                if (result is SelectedPlace) {
                  context.read<HomeCubit>().setSelectedPlace(result);
                }
              },
              child: Container(
                height: fieldHeight,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(fieldRadius),
                  border: Border.all(
                    color: AppColors.colorBtn,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        state.address.isEmpty
                            ? 'Ou cherchez-vous un parking ?'
                            : state.address,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: state.address.isEmpty
                              ? const Color(0xFFB4B4B4)
                              : const Color(0xFF000000),
                          fontSize: textFontSize,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.location_on,
                      color: const Color(0xFF444444),
                      size: iconSize,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}