// lib/features/bookings/view/session_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tunipark/features/bookings/utils/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/core/constants/app_strings.dart';

import '../cubit/session_cubit.dart';
import '../models/booking_model.dart';
import '../services/booking_service.dart';

/// Full-screen view of a single booking/session.
/// Reached from the "View session" button on a [BookingCard].
///
/// Hosts the actions that don't fit on the card:
///  - End session
///  - Extend (pay via Flouci, then poll for confirmation)
///  - Navigate to the parking
class SessionDetailScreen extends StatelessWidget {
  const SessionDetailScreen({
    super.key,
    required this.booking,
    required this.bookingService,
    this.onChanged,
  });

  final BookingModel booking;
  final BookingService bookingService;

  /// Called when the session was ended or extended, so the caller
  /// (the bookings list) can refresh itself.
  final VoidCallback? onChanged;

  static Route<void> route({
    required BookingModel booking,
    required BookingService bookingService,
    VoidCallback? onChanged,
  }) {
    return MaterialPageRoute(
      builder: (_) => SessionDetailScreen(
        booking: booking,
        bookingService: bookingService,
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionCubit(booking: booking, bookingService: bookingService),
      child: _SessionDetailView(onChanged: onChanged),
    );
  }
}

class _SessionDetailView extends StatefulWidget {
  const _SessionDetailView({this.onChanged});

  final VoidCallback? onChanged;

  @override
  State<_SessionDetailView> createState() => _SessionDetailViewState();
}

class _SessionDetailViewState extends State<_SessionDetailView> {
  bool _changed = false;

  void _markChanged() => _changed = true;

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop && _changed) widget.onChanged?.call();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundPage,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundPage,
          elevation: 0,
          foregroundColor: AppColors.textPrimary,
          title: Text(
            AppStrings.sessionDetails,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: BlocConsumer<SessionCubit, SessionState>(
          listenWhen: (prev, curr) =>
              prev.errorMessage != curr.errorMessage ||
              prev.extendSuccess != curr.extendSuccess ||
              prev.endSuccess != curr.endSuccess ||
              prev.extendPayLink != curr.extendPayLink,
          listener: (context, state) async {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: AppColors.danger,
                ),
              );
            }

            if (state.endSuccess) {
              _markChanged();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppStrings.sessionEnded)),
              );
              Navigator.of(context).pop();
            }

            if (state.extendSuccess) {
              _markChanged();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppStrings.extendSuccess),
                  backgroundColor: AppColors.limeDark,
                ),
              );
            }

            // Once we have a pay link, open it and start polling for
            // the payment confirmation (same flow as the booking screen).
            if (state.extendPayLink != null && !state.extendSuccess) {
              final uri = Uri.parse(state.extendPayLink!);
              final launched = await launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              );

              if (!launched && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppStrings.cantOpenPaymentLink),
                    backgroundColor: AppColors.danger,
                  ),
                );
              } else if (context.mounted) {
                context.read<SessionCubit>().startPollingPayment();
              }
            }
          },
          builder: (context, state) {
            final booking = state.booking;

            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: rs.adaptive(mobile: 16, tablet: 32, desktop: 48),
                  vertical: 16,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ParkingHeaderCard(booking: booking),
                      const SizedBox(height: 16),
                      _DetailsCard(booking: booking),
                      const SizedBox(height: 24),
                      if (state.action == SessionAction.extending) ...[
                        const _BannerLoading(label: null),
                        const SizedBox(height: 16),
                      ],
                      if (booking.isActive) ..._activeActions(context, state),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _activeActions(BuildContext context, SessionState state) {
    final isBusy = state.isBusy;

    return [
      FilledButton(
        onPressed: isBusy ? null : () => _confirmExtend(context),
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(AppStrings.payAndExtend),
      ),
      const SizedBox(height: 10),
      OutlinedButton(
        onPressed: isBusy
            ? null
            : () async {
                final navigated = await MapsLauncher.openDirections(
                  latitude: state.booking.parking.latitude,
                  longitude: state.booking.parking.longitude,
                  label: state.booking.parking.title,
                );
                if (!navigated && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppStrings.cantOpenMaps),
                      backgroundColor: AppColors.danger,
                    ),
                  );
                }
              },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(AppStrings.navigate),
      ),
      const SizedBox(height: 10),
      OutlinedButton(
        onPressed: isBusy ? null : () => _confirmEnd(context),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.danger,
          side: const BorderSide(color: AppColors.danger),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(AppStrings.endSession),
      ),
    ];
  }

  Future<void> _confirmEnd(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppStrings.endSession),
        content: Text(AppStrings.confirmEndSession),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppStrings.no),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppStrings.yes),
          ),
        ],
      ),
    );

    if (ok == true && context.mounted) {
      await context.read<SessionCubit>().endSession();
    }
  }

  Future<void> _confirmExtend(BuildContext context) async {
    await context.read<SessionCubit>().initExtend();
  }
}

class _BannerLoading extends StatelessWidget {
  const _BannerLoading({required this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.limeSubtle,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label ?? AppStrings.openingPaymentLink,
              style: const TextStyle(
                color: AppColors.limeDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ParkingHeaderCard extends StatelessWidget {
  const _ParkingHeaderCard({required this.booking});

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.parking.title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  booking.parking.address,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          _StatusBadge(status: booking.status),
        ],
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.booking});

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Row(label: AppStrings.vehicle, value: '${booking.vehicleBrand} ${booking.vehicleModel}'.trim()),
          const Divider(height: 24, color: AppColors.divider),
          _Row(label: AppStrings.plate, value: booking.vehiclePlate),
          const Divider(height: 24, color: AppColors.divider),
          _Row(label: AppStrings.from, value: _date(booking.startedAt)),
          const Divider(height: 24, color: AppColors.divider),
          _Row(label: AppStrings.until, value: _date(booking.endedAt)),
          const Divider(height: 24, color: AppColors.divider),
          _Row(
            label: AppStrings.paid,
            value: '${(booking.paymentAmount ?? 0).toStringAsFixed(0)} DT',
            valueColor: AppColors.limeDark,
          ),
        ],
      ),
    );
  }

  String _date(DateTime? value) {
    if (value == null) return '-';
    return DateFormat('d MMM, HH:mm').format(value);
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final data = switch (status) {
      BookingStatus.active => (AppStrings.active, AppColors.limeSubtle, AppColors.limeDark),
      BookingStatus.cancelled => ('Cancelled', AppColors.dangerLight, AppColors.danger),
      BookingStatus.expired => ('Past', AppColors.iconBackground, AppColors.grey),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: data.$2,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        data.$1,
        style: TextStyle(
          color: data.$3,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}