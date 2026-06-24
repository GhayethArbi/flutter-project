import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/bookings/utils/map_launcher.dart';

import '../models/booking_model.dart';
import '../services/booking_service.dart';
import '../view/session_detail_screen.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.booking,
    required this.onCancel,
    required this.onRefresh,
    required this.bookingService,
  });

  final BookingModel booking;
  final Future<void> Function() onCancel;
  final Future<void> Function() onRefresh;
  final BookingService bookingService;

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final isMobile = rs.isMobile;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadow,
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(booking: booking),
          const SizedBox(height: 14),
          Wrap(
            spacing: 22,
            runSpacing: 10,
            children: [
              _Info(label: AppStrings.duration, value: _durationText()),
              _Info(label: AppStrings.from, value: _date(booking.startedAt)),
              _Info(label: AppStrings.until, value: _date(booking.endedAt)),
              _Info(
                label: AppStrings.paid,
                value: '${(booking.paymentAmount ?? 0).toStringAsFixed(0)} DT',
                valueColor: AppColors.limeDark,
              ),
            ],
          ),
          const SizedBox(height: 16),
          isMobile
              ? _MobileActions(
                  booking: booking,
                  onCancel: onCancel,
                  onViewSession: () => _viewSession(context),
                )
              : _DesktopActions(
                  booking: booking,
                  onCancel: onCancel,
                  onViewSession: () => _viewSession(context),
                ),
        ],
      ),
    );
  }

  /// "View session" and "Extend" both open the session detail screen —
  /// extend lives there since it triggers a Flouci payment flow.
  Future<void> _viewSession(BuildContext context) async {
    await Navigator.of(context).push(
      SessionDetailScreen.route(
        booking: booking,
        bookingService: bookingService,
        onChanged: onRefresh,
      ),
    );
  }

  // Future<void> _navigate(BuildContext context) async {
  //   final lat = booking.parking.latitude;
  //   final lng = booking.parking.longitude;

  //   if (lat == null || lng == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(AppStrings.cantOpenMaps),
  //         backgroundColor: AppColors.danger,
  //       ),
  //     );
  //     return;
  //   }

  //   final opened = await MapsLauncher.openDirections(
  //     latitude: lat,
  //     longitude: lng,
  //     label: booking.parking.title,
  //   );

  //   if (!opened && context.mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(AppStrings.cantOpenMaps),
  //         backgroundColor: AppColors.danger,
  //       ),
  //     );
  //   }
  // }

  String _durationText() {
    if (booking.pricePerMonth != null) return 'By month';
    final days = booking.endedAt?.difference(booking.startedAt).inDays;
    if (days == null || days <= 0) return '-';
    return days == 1 ? '1 day' : '$days days';
  }

  String _date(DateTime? value) {
    if (value == null) return '-';
    return DateFormat('d MMM').format(value);
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.booking});

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                booking.parking.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                booking.parking.address,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        _StatusChip(status: booking.status),
      ],
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.label, required this.value, this.valueColor});

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopActions extends StatelessWidget {
  const _DesktopActions({
    required this.booking,
    required this.onCancel,
    required this.onViewSession,
  });

  final BookingModel booking;
  final Future<void> Function() onCancel;
  final VoidCallback onViewSession;

  @override
  Widget build(BuildContext context) {
    final actions = _actions(context);

    return Row(
      children: actions
          .map(
            (e) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: e,
              ),
            ),
          )
          .toList(),
    );
  }

  List<Widget> _actions(BuildContext context) {
    switch (booking.status) {
      case BookingStatus.active:
        return [
          _PrimaryButton(label: AppStrings.viewSession, onTap: onViewSession),
        ];

      case BookingStatus.expired:
      case BookingStatus.cancelled:
        return [
          _OutlineButton(label: AppStrings.viewReceipt, onTap: onViewSession),
          //_OutlineButton(label: AppStrings.bookAgain, onTap: () {}),
        ];
    }
  }

  // Future<void> _confirmCancel(BuildContext context) async {
  //   final ok = await showDialog<bool>(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: Text(AppStrings.cancelReservation),
  //       content: Text(AppStrings.areYouSureYouWantTo),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, false),
  //           child: Text(AppStrings.no),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, true),
  //           child: Text(AppStrings.yes),
  //         ),
  //       ],
  //     ),
  //   );

  //   if (ok == true) await onCancel();
  // }
}

class _MobileActions extends StatelessWidget {
  const _MobileActions({
    required this.booking,
    required this.onCancel,
    required this.onViewSession,
  });

  final BookingModel booking;
  final Future<void> Function() onCancel;
  final VoidCallback onViewSession;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          _DesktopActions(
            booking: booking,
            onCancel: onCancel,
            onViewSession: onViewSession,
          )._actions(context).map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(width: double.infinity, child: e),
            );
          }).toList(),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final BookingStatus status;

  @override
  Widget build(BuildContext context) {
    final data = switch (status) {
      BookingStatus.active => (
        'Active',
        AppColors.limeSubtle,
        AppColors.limeDark,
      ),
      BookingStatus.cancelled => (
        'Cancelled',
        AppColors.dangerLight,
        AppColors.danger,
      ),
      BookingStatus.expired => (
        'Past',
        AppColors.iconBackground,
        AppColors.grey,
      ),
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

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(label),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  const _OutlineButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(label),
    );
  }
}

// class _DangerButton extends StatelessWidget {
//   const _DangerButton({required this.label, required this.onTap});

//   final String label;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton(
//       onPressed: onTap,
//       style: OutlinedButton.styleFrom(
//         foregroundColor: AppColors.danger,
//         side: const BorderSide(color: AppColors.danger),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//       child: Text(label),
//     );
//   }
// }
