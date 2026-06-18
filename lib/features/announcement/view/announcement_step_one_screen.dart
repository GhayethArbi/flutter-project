import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/models/parking_spot_type.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../cubit/announcement_flow_cubit.dart';
import '../cubit/announcement_flow_state.dart';
import '../widgets/announcement_fixed_bottom_actions.dart';
import '../widgets/announcement_flow_header.dart';
import '../widgets/announcement_step_actions.dart';
import '../widgets/parking_type_option_card.dart';
import 'package:tunipark/core/constants/app_strings2.dart';

class AnnouncementStepOneScreen extends StatelessWidget {
  const AnnouncementStepOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocBuilder<AnnouncementFlowCubit, AnnouncementFlowState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: rs.adaptive(mobile: rs.w, tablet: 700, desktop: 850),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: rs.adaptive(mobile: 16, tablet: 24, desktop: 32),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: rs.adaptive(mobile: 8, tablet: 12, desktop: 16)),
                          AnnouncementFlowHeader(
                            step: 1,
                            totalSteps: 7,
                            onBack: () => context.read<AnnouncementFlowCubit>().goToStep(0),
                            onClose: () => Navigator.pop(context),
                          ),
                          SizedBox(height: rs.adaptive(mobile: 18, tablet: 24, desktop: 28)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: rs.adaptive(mobile: 16, tablet: 24, desktop: 32),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppStrings2.quelTypeDEmplacementProposezVous,
                              style: TextStyle(
                                fontSize: rs.adaptive(mobile: 20, tablet: 22, desktop: 24),
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1A1A),
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: rs.adaptive(mobile: 24, tablet: 28, desktop: 32)),

                            // COVERED (new)
                            ParkingTypeOptionCard(
                              icon: Icons.roofing_rounded,
                              title: AppStrings2.parkingCouvert,
                              subtitle: AppStrings2.emplacementProtegeParUneToitureOuUne,
                              isSelected: state.parkingType == ParkingSpotType.covered,
                              onTap: () => context
                                  .read<AnnouncementFlowCubit>()
                                  .selectParkingType(ParkingSpotType.covered),
                            ),
                            SizedBox(height: rs.adaptive(mobile: 14, tablet: 16, desktop: 20)),

                            ParkingTypeOptionCard(
                              icon: Icons.apartment_rounded,
                              title: AppStrings2.sousSolDImmeuble,
                              subtitle: AppStrings2.placeDansUnParkingSouterrainDImmeuble,
                              isSelected: state.parkingType == ParkingSpotType.underground,
                              onTap: () => context
                                  .read<AnnouncementFlowCubit>()
                                  .selectParkingType(ParkingSpotType.underground),
                            ),
                            SizedBox(height: rs.adaptive(mobile: 14, tablet: 16, desktop: 20)),

                            ParkingTypeOptionCard(
                              icon: Icons.home_rounded,
                              title: AppStrings2.garageDeMaison,
                              subtitle: AppStrings2.garageIndividuelAttenantOuSepareDUne,
                              isSelected: state.parkingType == ParkingSpotType.garage,
                              onTap: () => context
                                  .read<AnnouncementFlowCubit>()
                                  .selectParkingType(ParkingSpotType.garage),
                            ),
                            SizedBox(height: rs.adaptive(mobile: 14, tablet: 16, desktop: 20)),

                            ParkingTypeOptionCard(
                              icon: Icons.local_parking_rounded,
                              title: AppStrings2.parkingExterieur,
                              subtitle: AppStrings2.emplacementEnPleinAirDansUneCour,
                              isSelected: state.parkingType == ParkingSpotType.outdoor,
                              onTap: () => context
                                  .read<AnnouncementFlowCubit>()
                                  .selectParkingType(ParkingSpotType.outdoor),
                            ),
                            SizedBox(height: rs.adaptive(mobile: 24, tablet: 28, desktop: 32)),
                          ],
                        ),
                      ),
                    ),
                    AnnouncementFixedBottomActions(
                      child: AnnouncementStepActions(
                        onBack: () => context.read<AnnouncementFlowCubit>().goToStep(0),
                        onNext: () => context.read<AnnouncementFlowCubit>().goToStep(2),
                        isNextEnabled: state.parkingType != null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}