import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';
import '../../models/vehicle_option.dart';

class HomeVehicleDropdown extends StatelessWidget {
  const HomeVehicleDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final labelFontSize = rs.adaptive(mobile: 15, tablet: 16, desktop: 17);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Type de véhicule',
              style: TextStyle(
                fontSize: labelFontSize,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF3A3A3A),
              ),
            ),
            SizedBox(height: rs.adaptive(mobile: 8, tablet: 10, desktop: 12)),
            _VehicleDropdownField(
              value: state.selectedVehicle?.title,
              isOpen: state.isVehicleDropdownOpen,
              onTap: cubit.toggleVehicleDropdown,
            ),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 220),
              crossFadeState: state.isVehicleDropdownOpen
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Padding(
                padding: EdgeInsets.only(
                  top: rs.adaptive(mobile: 12, tablet: 14, desktop: 16),
                ),
                child: _VehicleDropdownPanel(
                  isElectricVehicle: state.isElectricVehicle,
                  selectedVehicle: state.selectedVehicle,
                  options: cubit.vehicleOptions,
                  onElectricTap: cubit.toggleElectricVehicle,
                  onSelectVehicle: cubit.selectVehicle,
                ),
              ),
              secondChild: const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }
}

class _VehicleDropdownField extends StatelessWidget {
  final String? value;
  final bool isOpen;
  final VoidCallback onTap;

  const _VehicleDropdownField({
    required this.value,
    required this.isOpen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final fieldHeight = rs.adaptive(
      mobile: rs.clampSize(rs.hp(0.065), 50, 56),
      tablet: 58,
      desktop: 62,
    );

    final fieldRadius = rs.adaptive(mobile: 14, tablet: 16, desktop: 18);

    final textFontSize = rs.adaptive(mobile: 14, tablet: 15, desktop: 16);

    final iconSize = rs.adaptive(mobile: 20, tablet: 22, desktop: 24);

    final horizontalPadding = rs.adaptive(mobile: 14, tablet: 16, desktop: 18);

    return InkWell(
      borderRadius: BorderRadius.circular(fieldRadius),
      onTap: onTap,
      child: Container(
        height: fieldHeight,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(fieldRadius),
          border: Border.all(color: AppColors.colorBtn, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value ?? 'Sélectionnez votre type véhicule',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: textFontSize,
                  color: value == null
                      ? const Color(0xFFB4B4B4)
                      : const Color(0xFF000000),
                  fontWeight: value == null ? FontWeight.w400 : FontWeight.w500,
                ),
              ),
            ),
            Icon(
              isOpen
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: const Color(0xFF444444),
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}

class _VehicleDropdownPanel extends StatelessWidget {
  final bool isElectricVehicle;
  final VehicleOption? selectedVehicle;
  final List<VehicleOption> options;
  final VoidCallback onElectricTap;
  final ValueChanged<VehicleOption> onSelectVehicle;

  const _VehicleDropdownPanel({
    required this.isElectricVehicle,
    required this.selectedVehicle,
    required this.options,
    required this.onElectricTap,
    required this.onSelectVehicle,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final panelRadius = rs.adaptive(mobile: 22, tablet: 24, desktop: 26);

    final panelPadding = rs.adaptive(mobile: 12, tablet: 14, desktop: 16);

    final panelMaxHeight = rs.adaptive(
      mobile: rs.clampSize(rs.hp(0.38), 240, 340),
      tablet: rs.clampSize(rs.hp(0.42), 280, 400),
      desktop: 420,
    );

    final spacing = rs.adaptive(mobile: 14, tablet: 16, desktop: 18);

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: panelMaxHeight),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(panelPadding),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(panelRadius),
          border: Border.all(color: const Color(0xFFE8E8E8)),
        ),
        child: Column(
          children: [
            _ElectricHeader(value: isElectricVehicle, onTap: onElectricTap),
            SizedBox(height: spacing),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: options.map((option) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: rs.adaptive(
                          mobile: 10,
                          tablet: 12,
                          desktop: 14,
                        ),
                      ),
                      child: _VehicleOptionTile(
                        option: option,
                        isSelected: selectedVehicle?.id == option.id,
                        onTap: () => onSelectVehicle(option),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ElectricHeader extends StatelessWidget {
  final bool value;
  final VoidCallback onTap;

  const _ElectricHeader({required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final iconSize = rs.adaptive(mobile: 22, tablet: 24, desktop: 26);

    final titleFontSize = rs.adaptive(mobile: 16, tablet: 17, desktop: 18);

    final checkboxSize = rs.adaptive(mobile: 24, tablet: 26, desktop: 28);

    return Row(
      children: [
        Icon(Icons.bolt, size: iconSize, color: Colors.black),
        SizedBox(width: rs.adaptive(mobile: 10, tablet: 12, desktop: 14)),
        Expanded(
          child: Text(
            'Véhicule électrique',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1F1F1F),
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: checkboxSize,
            height: checkboxSize,
            decoration: BoxDecoration(
              color: value ? const Color(0xFFD7F205) : Colors.transparent,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: const Color(0xFFCACACA), width: 1.2),
            ),
            child: value
                ? const Icon(Icons.check, size: 16, color: Colors.black)
                : null,
          ),
        ),
      ],
    );
  }
}

class _VehicleOptionTile extends StatelessWidget {
  final VehicleOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _VehicleOptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });
  Widget _buildVehicleIcon(String assetPath, double iconSize) {
    if (assetPath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        assetPath,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.contain,
        placeholderBuilder: (_) => const SizedBox(),
      );
    }

    return Image.asset(
      assetPath,
      width: iconSize,
      height: iconSize,
      fit: BoxFit.contain,
    );
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    final tileRadius = rs.adaptive(mobile: 14, tablet: 16, desktop: 18);

    final horizontalPadding = rs.adaptive(mobile: 12, tablet: 14, desktop: 16);

    final verticalPadding = rs.adaptive(mobile: 10, tablet: 12, desktop: 14);

    final iconSize = rs.adaptive(mobile: 28, tablet: 30, desktop: 32) - 7;

    final titleFontSize = rs.adaptive(mobile: 16, tablet: 17, desktop: 18);

    final subtitleFontSize = rs.adaptive(mobile: 13, tablet: 14, desktop: 15);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(tileRadius),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFF2F9D9)
                : const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(tileRadius),
            border: Border.all(color: const Color(0xFFDDE890), width: 1),
          ),
          child: Row(
            children: [
              SizedBox(
                width: rs.adaptive(mobile: 36, tablet: 40, desktop: 44)+15,
                child: Center(
                  child: _buildVehicleIcon(option.iconAsset, iconSize),
                ),
              ),
              SizedBox(width: rs.adaptive(mobile: 12, tablet: 14, desktop: 16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.title,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F1F1F),
                      ),
                    ),
                    SizedBox(
                      height: rs.adaptive(mobile: 2, tablet: 4, desktop: 4),
                    ),
                    Text(
                      option.subtitle,
                      style: TextStyle(
                        fontSize: subtitleFontSize,
                        color: const Color(0xFF7B7B7B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
