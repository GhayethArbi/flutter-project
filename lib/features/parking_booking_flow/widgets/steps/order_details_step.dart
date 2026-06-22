import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_booking_flow/cubit/parking_booking_flow_cubit.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class OrderDetailsStep extends StatelessWidget {
  const OrderDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final state = context.watch<ParkingBookingFlowCubit>().state;

    final dateFormat = DateFormat('dd/MM/yyyy');
    final validity =
        'Du ${dateFormat.format(state.startDate!)} - ${dateFormat.format(state.endDate!)}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: rs.adaptive(mobile: 48, tablet: 56, desktop: 64),
              height: rs.adaptive(mobile: 48, tablet: 56, desktop: 64),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade300,
              ),
              child: const Icon(Icons.image, color: Colors.grey),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.parking.title,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state.parking.address,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            SvgPicture.asset(
              'assets/vehicules/car_small.svg',
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                Colors.black54,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 8),
            Text(AppStrings.placeVoiture),
          ],
        ),
        const SizedBox(height: 22),
        Text(AppStrings.validite, style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Text(validity, style: const TextStyle(fontSize: 13)),
        const SizedBox(height: 22),
        Text(AppStrings.tarif, style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F4F4),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              _TarifRow(
                label: AppStrings.mensualite,
                value: '${state.monthlyPrice.toStringAsFixed(3)}DT',
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              _TarifRow(
                label: AppStrings.fraisDeService,
                value: '+${state.serviceFee.toStringAsFixed(3)}DT',
              ),
              Divider(height: 1, color: Colors.grey.shade300),
              _TarifRow(
                label: AppStrings.total,
                value: '${state.totalPrice.toStringAsFixed(3)}DT',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TarifRow extends StatelessWidget {
  final String label;
  final String value;

  const _TarifRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
          Text(value, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
