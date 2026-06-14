import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';

class HomeModeToggle extends StatelessWidget {
  const HomeModeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final height = rs.adaptive(
      mobile: rs.clampSize(rs.hp(0.06), 44, 50),
      tablet: 54,
      desktop: 58,
    );

    final radius = rs.adaptive(
      mobile: 12,
      tablet: 14,
      desktop: 16,
    );

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Row(
            children: [
              Expanded(
                child: _ModeItem(
                  title: 'Par mois',
                  isSelected: state.selectedMode == HomeMode.monthly,
                  onTap: () {
                    context.read<HomeCubit>().changeMode(HomeMode.monthly);
                  },
                ),
              ),
              Expanded(
                child: _ModeItem(
                  title: 'Heure/Jour',
                  isSelected: state.selectedMode == HomeMode.hourlyDaily,
                  onTap: () {
                    context.read<HomeCubit>().changeMode(HomeMode.hourlyDaily);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ModeItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final margin = rs.adaptive(
      mobile: 2,
      tablet: 3,
      desktop: 4,
    );

    final radius = rs.adaptive(
      mobile: 10,
      tablet: 12,
      desktop: 14,
    );

    final fontSize = rs.adaptive(
      mobile: 15,
      tablet: 16,
      desktop: 17,
    );

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: EdgeInsets.all(margin),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.colorBtn
              : const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.85),
          ),
        ),
      ),
    );
  }
}