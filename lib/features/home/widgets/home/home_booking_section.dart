import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';
import '../datetime_picker_bottom_sheet.dart';
import '../home_datetime_field.dart';
import '../home_duration_chip.dart';
import 'package:tunipark/core/constants/app_strings2.dart';

class HomeBookingSection extends StatelessWidget {
  const HomeBookingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.selectedMode != current.selectedMode ||
          previous.startDateTime != current.startDateTime ||
          previous.endDateTime != current.endDateTime,
      builder: (context, state) {
        if (state.selectedMode != HomeMode.hourlyDaily) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            SizedBox(height: rs.adaptive(mobile: 16, tablet: 18, desktop: 22)),

            HomeDateTimeField(
              label: AppStrings2.start,
              value: state.startDateTime,
              onTap: () async {
                final picked = await showModalBottomSheet<DateTime>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => DateTimePickerBottomSheet(
                    initialValue: state.startDateTime ?? DateTime.now(),
                    title: AppStrings2.selectStart,
                  ),
                );

                if (picked != null && context.mounted) {
                  context.read<HomeCubit>().setStartDateTime(picked);
                }
              },
            ),

            SizedBox(height: rs.adaptive(mobile: 12, tablet: 14, desktop: 16)),

            HomeDateTimeField(
              label: AppStrings2.end,
              value: state.endDateTime,
              onTap: () async {
                final base = state.startDateTime ?? DateTime.now();

                final picked = await showModalBottomSheet<DateTime>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => DateTimePickerBottomSheet(
                    initialValue:
                        state.endDateTime ?? base.add(const Duration(hours: 2)),
                    minimumDate: base,
                    title: AppStrings2.selectEnd,
                  ),
                );

                if (picked != null && context.mounted) {
                  context.read<HomeCubit>().setEndDateTime(picked);
                }
              },
            ),

            SizedBox(height: rs.adaptive(mobile: 12, tablet: 14, desktop: 16)),

            Row(
              children: [
                HomeDurationChip(
                  label: '6 heures',
                  onTap: () => context.read<HomeCubit>().applyDuration(
                        const Duration(hours: 6),
                      ),
                ),
                SizedBox(width: rs.adaptive(mobile: 8, tablet: 10, desktop: 12)),
                HomeDurationChip(
                  label: '1 jour',
                  onTap: () => context.read<HomeCubit>().applyDuration(
                        const Duration(days: 1),
                      ),
                ),
                SizedBox(width: rs.adaptive(mobile: 8, tablet: 10, desktop: 12)),
                HomeDurationChip(
                  label: '2 jours',
                  onTap: () => context.read<HomeCubit>().applyDuration(
                        const Duration(days: 2),
                      ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}