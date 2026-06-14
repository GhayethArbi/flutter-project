import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_colors.dart';

import '../cubit/bookings_cubit.dart';
import '../cubit/bookings_state.dart';

class BookingFilterTabs extends StatelessWidget {
  const BookingFilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsCubit, BookingsState>(
      buildWhen: (p, c) => p.filter != c.filter,
      builder: (context, state) {
        return Row(
          children: [
            _TabItem(
              label: 'Active',
              selected: state.filter == BookingsFilter.active,
              onTap: () => context.read<BookingsCubit>().setFilter(BookingsFilter.active),
            ),
          
            _TabItem(
              label: 'Past',
              selected: state.filter == BookingsFilter.past,
              onTap: () => context.read<BookingsCubit>().setFilter(BookingsFilter.past),
            ),
          ],
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? AppColors.colorBtn : AppColors.border,
                width: selected ? 3 : 1,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: selected ? AppColors.colorBtn : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}