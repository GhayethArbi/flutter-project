import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../cubit/home_cubit.dart';
import '../widgets/home/home_filter_card.dart';
import '../widgets/home/home_search_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final horizontalPadding = rs.adaptive(
      mobile: 12,
      tablet: 20,
      desktop: rs.wp(0.18),
    );

    final topSpacing = rs.adaptive(
      mobile: 8,
      tablet: 12,
      desktop: 18,
    );

    final middleSpacing = rs.adaptive(
      mobile: 16,
      tablet: 20,
      desktop: 24,
    );

    final bottomPadding = rs.adaptive(
      mobile: 14,
      tablet: 18,
      desktop: 22,
    );

    final centerRadius = rs.adaptive(
      mobile: 24,
      tablet: 28,
      desktop: 32,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: rs.isDesktop ? 700 : double.infinity,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: topSpacing),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: const HomeFilterCard(),
                        ),
                        SizedBox(height: middleSpacing),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(centerRadius),
                            ),
                          ),
                        ),
                        SizedBox(height: middleSpacing),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontalPadding,
                    0,
                    horizontalPadding,
                    bottomPadding,
                  ),
                  child: const HomeSearchButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}