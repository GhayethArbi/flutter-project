import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/di/service_locator.dart';
import 'package:tunipark/features/main_navigation/cubit/main_nav_cubit.dart';


import '../cubit/announcement_flow_cubit.dart';
import '../cubit/announcement_flow_state.dart';
import 'announcement_intro_screen.dart';
import 'announcement_step_one_screen.dart';
import 'announcement_step_two_screen.dart';
import 'announcement_step_three_screen.dart';
import 'announcement_step_three_b_screen.dart';
import 'announcement_step_four_screen.dart';
import 'announcement_step_five_screen.dart';
import 'announcement_step_six_screen.dart';
import 'announcement_success_screen.dart';

class AnnouncementFlowScreen extends StatelessWidget {
  const AnnouncementFlowScreen({super.key, required this.sl});

  final ServiceLocator sl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnnouncementFlowCubit(parkingService: sl.parkingService),
      child: BlocBuilder<AnnouncementFlowCubit, AnnouncementFlowState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: KeyedSubtree(
              key: ValueKey(state.currentStep),
              child: _buildCurrentStep(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrentStep(BuildContext context, AnnouncementFlowState state) {
    switch (state.currentStep) {
      case 0:
        return const AnnouncementIntroScreen();
      case 1:
        return const AnnouncementStepOneScreen();
      case 2:
        return const AnnouncementStepTwoScreen();
      case 3:
        return const AnnouncementStepThreeScreen();
      case 4:
        return const AnnouncementStepThreeBScreen();
      case 5:
        return const AnnouncementStepFourScreen();
      case 6:
        return const AnnouncementStepFiveScreen();
      case 7:
        return const AnnouncementStepSixScreen();
      case 8:
  return AnnouncementSuccessScreen(
    onFinish: () {
      context.read<AnnouncementFlowCubit>().resetFlow();
      Navigator.of(context).pop();
      context.read<MainNavCubit>().changeTab(3);
    },
  );
      default:
        return const AnnouncementIntroScreen();
    }
  }
}
