import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';

class HomeSearchButton extends StatelessWidget {
  const HomeSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final buttonHeight = rs.adaptive(
      mobile: rs.clampSize(rs.hp(0.065), 50, 56),
      tablet: 58,
      desktop: 62,
    );

    final fontSize = rs.adaptive(
      mobile: 15,
      tablet: 16,
      desktop: 17,
    );

    final radius = rs.adaptive(
      mobile: 12,
      tablet: 14,
      desktop: 16,
    );

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: ElevatedButton(
            onPressed: state.canSearch && !state.isSubmitting
                ? () async {
                    final place = await context.read<HomeCubit>().search();

                    if (!context.mounted || place == null) return;

                    Navigator.pushNamed(
                      context,
                      AppRoutes.parkingMap,
                      arguments: place,
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFFF7F7F7),
              foregroundColor: Colors.black,
              disabledBackgroundColor: const Color(0xFFEDEDED),
              disabledForegroundColor: Colors.black45,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            child: state.isSubmitting
                ? SizedBox(
                    width: rs.adaptive(mobile: 20, tablet: 22, desktop: 24),
                    height: rs.adaptive(mobile: 20, tablet: 22, desktop: 24),
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    'Rechercher',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }
}