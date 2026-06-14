import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/bookings/widgets/booking_card.dart';
import 'package:tunipark/features/bookings/widgets/booking_filter_tabs.dart';

import '../cubit/bookings_cubit.dart';
import '../cubit/bookings_state.dart';
import '../services/booking_service.dart';


class BookingsScreen extends StatelessWidget {
  const BookingsScreen({
    super.key,
    required this.bookingService,
  });

  final BookingService bookingService;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingsCubit(bookingService: bookingService)..loadBookings(),
      child: const _BookingsView(),
    );
  }
}

class _BookingsView extends StatelessWidget {
  const _BookingsView();

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Scaffold(
      backgroundColor: AppColors.backgroundPage,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: rs.adaptive(mobile: 16, tablet: 32, desktop: 48),
            vertical: 16,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mes réservations',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 18),
                const BookingFilterTabs(),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocConsumer<BookingsCubit, BookingsState>(
                    listener: (context, state) {
                      if (state.status == BookingsStatus.failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errorMessage ?? 'Something went wrong'),
                            backgroundColor: AppColors.danger,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.isEmpty) {
                        return const _EmptyBookings();
                      }

                      return RefreshIndicator(
                        onRefresh: context.read<BookingsCubit>().refresh,
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: state.filteredBookings.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final booking = state.filteredBookings[index];

                            return BookingCard(
                              booking: booking,
                              onCancel: () async {
                                await context
                                    .read<BookingsCubit>()
                                    .cancelBooking(booking.sessionId);
                              },
                              onRefresh: context.read<BookingsCubit>().refresh,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyBookings extends StatelessWidget {
  const _EmptyBookings();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No reservations found',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}