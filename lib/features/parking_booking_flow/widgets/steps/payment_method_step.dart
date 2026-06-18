import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_booking_flow/cubit/parking_booking_flow_cubit.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/constants/app_strings2.dart';

class PaymentMethodStep extends StatelessWidget {
  const PaymentMethodStep({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final state = context.watch<ParkingBookingFlowCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.paiement100Securise,
          style: TextStyle(
            fontSize: rs.adaptive(mobile: 15, tablet: 16, desktop: 17),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: rs.adaptive(mobile: 18, tablet: 20, desktop: 22)),
        _PaymentMethodCard(
          title: AppStrings2.flouci,
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              'assets/flouci.png',
              width: 42,
              height: 24,
              fit: BoxFit.cover,
            ),
          ),
          isSelected: state.selectedPaymentMethodId == 'flouci',
          onTap: () {
            context.read<ParkingBookingFlowCubit>().selectPaymentMethod(
              'flouci',
            );
          },
        ),
        const SizedBox(height: 12),
        _PaymentMethodCard(
          title: AppStrings2.carteBancaire,
          trailing: Image.asset(
            'assets/mastercard.png',
            width: 42,
            height: 24,
            fit: BoxFit.contain,
          ),
          isSelected: state.selectedPaymentMethodId == 'bank_card',
          onTap: () {
            context.read<ParkingBookingFlowCubit>().selectPaymentMethod(
              'bank_card',
            );
          },
        ),
        // Replace the existing paymentLoading indicator block with:
        if (state.paymentLoading)
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Center(child: CircularProgressIndicator()),
          ),

        if (state.awaitingDeepLink && !state.paymentLoading)
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text(AppStrings.enAttenteDeConfirmationDuPaiement,
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),

        if (state.paymentError != null && !state.paymentLoading)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0F0),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.redAccent),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      state.paymentError!,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        SizedBox(height: rs.adaptive(mobile: 18, tablet: 20, desktop: 22)),
        Row(
          children: [
            const Icon(Icons.add, size: 18),
            const SizedBox(width: 10),
            Text(AppStrings.ajouterUneCarteBancaire,
              style: TextStyle(
                fontSize: rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final String title;
  final Widget trailing;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.title,
    required this.trailing,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? const Color(0xFFB7F000)
        : const Color(0xFFDDE7A5);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF7FDE9) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
