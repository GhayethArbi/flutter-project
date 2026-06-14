import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/features/onboarding/widgets/onboarding_button.dart';
import 'package:tunipark/features/onboarding/widgets/onboarding_content.dart';
import 'package:tunipark/features/onboarding/widgets/onboarding_dots.dart';

import '../../../core/theme/core.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';

class OnboardingScreen extends StatefulWidget {
  final void Function(BuildContext context)? onFinish;
  const OnboardingScreen({super.key, this.onFinish});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    if (cubit.state.isLast) {
      widget.onFinish?.call(context);
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _skip(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();
    _pageController.animateToPage(
      cubit.state.total - 1,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(total: AppStrings.onboardingTitles.length),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          final h = MediaQuery.of(context).size.height;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 52,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 28),
                        child: AnimatedOpacity(
                          opacity: state.isLast ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 250),
                          child: GestureDetector(
                            onTap: () => _skip(context),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                AppStrings.skip,
                                style: AppTextStyles.skipButton,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: AppStrings.onboardingTitles.length,
                      onPageChanged: (i) =>
                          context.read<OnboardingCubit>().jumpTo(i),
                      itemBuilder: (_, i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: OnboardingContent(
                          asset: _assets[i],
                          title: AppStrings.onboardingTitles[i],
                          description: AppStrings.onboardingDescriptions[i],
                          imageHeight: h * 0.36,
                        ),
                      ),
                    ),
                  ),

                  OnboardingDots(
                    total: state.total,
                    current: state.currentIndex,
                  ),

                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: OnboardingButton(
                      label: state.isLast ? AppStrings.start : AppStrings.next,
                      onTap: () => _next(context),
                    ),
                  ),

                  const SizedBox(height: 42),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

const _assets = [
  AppAssets.onboarding1,
  AppAssets.onboarding2,
  AppAssets.onboarding3,
  AppAssets.onboarding4,
];
