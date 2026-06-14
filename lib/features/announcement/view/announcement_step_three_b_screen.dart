import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/models/parking_vehicle_type.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../cubit/announcement_flow_cubit.dart';
import '../cubit/announcement_flow_state.dart';
import '../widgets/announcement_fixed_bottom_actions.dart';
import '../widgets/announcement_flow_header.dart';

class AnnouncementStepThreeBScreen extends StatelessWidget {
  const AnnouncementStepThreeBScreen({super.key});

  // ── Validation ───────────────────────────────────────────────
  bool _isValid(AnnouncementFlowState s) =>
      s.maxPlaces >= 1 &&
      s.vehicleTypes.isNotEmpty &&
      s.openingTime.isNotEmpty &&
      s.closingTime.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocBuilder<AnnouncementFlowCubit, AnnouncementFlowState>(
      builder: (context, state) {
        final cubit = context.read<AnnouncementFlowCubit>();

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
                    // ── CONTENT ──────────────────────────────────
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: rs.adaptive(mobile: 16, tablet: 24, desktop: 32),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: rs.adaptive(mobile: 8, tablet: 12, desktop: 16)),

                            AnnouncementFlowHeader(
                              step: 4,
                              totalSteps: 7,
                              onBack: () => cubit.goToStep(3),
                              onClose: () => Navigator.pop(context),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 18, tablet: 24, desktop: 28)),

                            Text(
                              'Capacité & horaires',
                              style: TextStyle(
                                fontSize: rs.adaptive(mobile: 20, tablet: 22, desktop: 24),
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 6, tablet: 8, desktop: 10)),

                            Text(
                              'Indiquez combien de places vous proposez, vos horaires et les véhicules acceptés.',
                              style: TextStyle(
                                fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
                                height: 1.45,
                                color: const Color(0xFF888888),
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 28, tablet: 32, desktop: 38)),

                            // ── MAX PLACES ───────────────────────
                            _SectionLabel(text: 'Nombre de places'),
                            SizedBox(height: rs.adaptive(mobile: 12, tablet: 14, desktop: 16)),
                            _PlacesCounter(
                              value: state.maxPlaces,
                              onDecrement: () {
                                if (state.maxPlaces > 1) {
                                  cubit.updateMaxPlaces(state.maxPlaces - 1);
                                }
                              },
                              onIncrement: () =>
                                  cubit.updateMaxPlaces(state.maxPlaces + 1),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 28, tablet: 32, desktop: 38)),

                            // ── OPENING HOURS ────────────────────
                            _SectionLabel(text: 'Horaires d\'accès'),
                            SizedBox(height: rs.adaptive(mobile: 12, tablet: 14, desktop: 16)),
                            Row(
                              children: [
                                Expanded(
                                  child: _TimePickerTile(
                                    label: 'Ouverture',
                                    value: state.openingTime,
                                    onChanged: cubit.updateOpeningTime,
                                    context: context,
                                  ),
                                ),
                                SizedBox(
                                  width: rs.adaptive(mobile: 12, tablet: 14, desktop: 16),
                                ),
                                Expanded(
                                  child: _TimePickerTile(
                                    label: 'Fermeture',
                                    value: state.closingTime,
                                    onChanged: cubit.updateClosingTime,
                                    context: context,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: rs.adaptive(mobile: 28, tablet: 32, desktop: 38)),

                            // ── VEHICLE TYPES ────────────────────
                            _SectionLabel(text: 'Véhicules acceptés'),
                            SizedBox(height: rs.adaptive(mobile: 6, tablet: 8, desktop: 10)),
                            Text(
                              'Sélectionnez au moins un type de véhicule',
                              style: TextStyle(
                                fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 14),
                                color: const Color(0xFF888888),
                              ),
                            ),
                            SizedBox(height: rs.adaptive(mobile: 14, tablet: 16, desktop: 18)),

                            Wrap(
                              spacing: rs.adaptive(mobile: 10, tablet: 12, desktop: 14),
                              runSpacing: rs.adaptive(mobile: 10, tablet: 12, desktop: 14),
                              children: ParkingVehicleType.values.map((type) {
                                final selected =
                                    state.vehicleTypes.contains(type);
                                return _VehicleChip(
                                  type: type,
                                  isSelected: selected,
                                  onTap: () => cubit.toggleVehicleType(type),
                                );
                              }).toList(),
                            ),

                            SizedBox(height: rs.adaptive(mobile: 32, tablet: 40, desktop: 48)),
                          ],
                        ),
                      ),
                    ),

                    // ── BOTTOM BUTTONS ────────────────────────────
                    AnnouncementFixedBottomActions(
                      child: Row(
                        children: [
                          Expanded(
                            child: _BottomButton(
                              text: 'Retour',
                              isPrimary: false,
                              onPressed: () => cubit.goToStep(3),
                            ),
                          ),
                          SizedBox(
                            width: rs.adaptive(mobile: 14, tablet: 18, desktop: 20),
                          ),
                          Expanded(
                            child: _BottomButton(
                              text: 'Suivant',
                              isPrimary: true,
                              onPressed: _isValid(state)
                                  ? () => cubit.goToStep(5)
                                  : null,
                            ),
                          ),
                        ],
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

// ─── Section Label ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    return Text(
      text,
      style: TextStyle(
        fontSize: rs.adaptive(mobile: 15, tablet: 16, desktop: 17),
        fontWeight: FontWeight.w700,
        color: const Color(0xFF5A5A5A),
      ),
    );
  }
}

// ─── Places Counter ───────────────────────────────────────────────────────────

class _PlacesCounter extends StatelessWidget {
  final int value;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _PlacesCounter({
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: rs.adaptive(mobile: 16, tablet: 18, desktop: 20),
        vertical: rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          rs.adaptive(mobile: 12, tablet: 14, desktop: 16),
        ),
        border: Border.all(color: const Color(0xFFD6EA74)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Places disponibles',
            style: TextStyle(
              fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
              fontWeight: FontWeight.w500,
              color: const Color(0xFF3B3B3B),
            ),
          ),
          Row(
            children: [
              _CounterBtn(
                icon: Icons.remove,
                onTap: onDecrement,
                enabled: value > 1,
              ),
              SizedBox(width: rs.adaptive(mobile: 18, tablet: 22, desktop: 24)),
              Text(
                '$value',
                style: TextStyle(
                  fontSize: rs.adaptive(mobile: 20, tablet: 22, desktop: 24),
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              SizedBox(width: rs.adaptive(mobile: 18, tablet: 22, desktop: 24)),
              _CounterBtn(
                icon: Icons.add,
                onTap: onIncrement,
                enabled: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CounterBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;

  const _CounterBtn({
    required this.icon,
    required this.onTap,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final size = rs.adaptive(mobile: 36.0, tablet: 38.0, desktop: 40.0);

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFFB7F000) : const Color(0xFFE8E8E8),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: rs.adaptive(mobile: 18, tablet: 20, desktop: 20),
          color: enabled ? const Color(0xFF1A1A1A) : const Color(0xFFAAAAAA),
        ),
      ),
    );
  }
}

// ─── Time Picker Tile ─────────────────────────────────────────────────────────

class _TimePickerTile extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final BuildContext context;

  const _TimePickerTile({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.context,
  });

  Future<void> _pick(BuildContext ctx) async {
    final parts = value.split(':');
    final initial = TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 8,
      minute: int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0,
    );

    final picked = await showTimePicker(
      context: ctx,
      initialTime: initial,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFFB7F000),
            onPrimary: Color(0xFF1A1A1A),
            surface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      final hh = picked.hour.toString().padLeft(2, '0');
      final mm = picked.minute.toString().padLeft(2, '0');
      onChanged('$hh:$mm');
    }
  }

  @override
  Widget build(BuildContext ctx) {
    final rs = ctx.rs;

    return GestureDetector(
      onTap: () => _pick(ctx),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
          vertical: rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 12, tablet: 14, desktop: 16),
          ),
          border: Border.all(color: const Color(0xFFD6EA74)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: rs.adaptive(mobile: 11, tablet: 12, desktop: 13),
                fontWeight: FontWeight.w500,
                color: const Color(0xFF888888),
              ),
            ),
            SizedBox(height: rs.adaptive(mobile: 6, tablet: 7, desktop: 8)),
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: rs.adaptive(mobile: 16, tablet: 18, desktop: 18),
                  color: const Color(0xFF3A4D00),
                ),
                SizedBox(width: rs.adaptive(mobile: 6, tablet: 8, desktop: 8)),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: rs.adaptive(mobile: 16, tablet: 18, desktop: 18),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Vehicle Chip ─────────────────────────────────────────────────────────────

class _VehicleChip extends StatelessWidget {
  final ParkingVehicleType type;
  final bool isSelected;
  final VoidCallback onTap;

  const _VehicleChip({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: rs.adaptive(mobile: 14, tablet: 16, desktop: 18),
          vertical: rs.adaptive(mobile: 10, tablet: 11, desktop: 12),
        ),
        decoration: BoxDecoration(
          color:
              isSelected ? const Color(0xFFE7F2C5) : const Color(0xFFEDEDED),
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 24, tablet: 26, desktop: 28),
          ),
          border: isSelected
              ? Border.all(color: const Color(0xFFB7F000))
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              type.emoji,
              style: TextStyle(
                fontSize: rs.adaptive(mobile: 16, tablet: 17, desktop: 18),
              ),
            ),
            SizedBox(width: rs.adaptive(mobile: 6, tablet: 7, desktop: 8)),
            Text(
              type.label,
              style: TextStyle(
                fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
                fontWeight: FontWeight.w600,
                color: const Color(0xFF3B3B3B),
              ),
            ),
            if (isSelected) ...[
              SizedBox(width: rs.adaptive(mobile: 6, tablet: 7, desktop: 8)),
              Icon(
                Icons.check_circle_rounded,
                size: rs.adaptive(mobile: 15, tablet: 16, desktop: 17),
                color: const Color(0xFF3A4D00),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Bottom Button ────────────────────────────────────────────────────────────

class _BottomButton extends StatelessWidget {
  final String text;
  final bool isPrimary;
  final VoidCallback? onPressed;

  const _BottomButton({
    required this.text,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return SizedBox(
      height: rs.adaptive(mobile: 48, tablet: 52, desktop: 54),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor:
              isPrimary ? const Color(0xFFB7F000) : Colors.white,
          disabledBackgroundColor: isPrimary
              ? const Color(0xFFB7F000).withOpacity(0.4)
              : Colors.white,
          side: const BorderSide(color: Color(0xFFB7F000)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              rs.adaptive(mobile: 24, tablet: 28, desktop: 30),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: rs.adaptive(mobile: 14, tablet: 15, desktop: 16),
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A1A),
          ),
        ),
      ),
    );
  }
}