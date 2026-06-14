import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_booking_flow/cubit/parking_booking_flow_state.dart';

class ParkingBookingProgressBar extends StatelessWidget {
  final ParkingBookingStep step;

  const ParkingBookingProgressBar({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    debugPrint('📊 ProgressBar building — step=${step}');

    String label;
    switch (step) {
      case ParkingBookingStep.choosePlace:
        label = 'étape 1/3';
        break;
      case ParkingBookingStep.vehicleInfo:
      case ParkingBookingStep.orderDetails:
        label = 'étape 2/3';
        break;
      case ParkingBookingStep.paymentMethod:
        // case ParkingBookingStep.addBankCard:
        // case ParkingBookingStep.scanCard:
        label = 'étape 3/3';
        break;
      case ParkingBookingStep.paymentSuccess:
        label = '';
        break;
    }

    if (label.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: rs.adaptive(mobile: 10, tablet: 12, desktop: 14),
      ),
      color: const Color(0xFFF1F8D5),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }
}
