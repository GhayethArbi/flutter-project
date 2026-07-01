import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/features/parking_booking_flow/cubit/parking_booking_flow_state.dart';
import 'package:tunipark/features/parking_booking_flow/services/parking_session_service.dart';
import 'package:tunipark/features/parking_booking_flow/services/payment_service.dart';
import 'package:tunipark/features/parking_map/models/parking_place.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkingBookingFlowCubit extends Cubit<ParkingBookingFlowState> {
  ParkingBookingFlowCubit(
    ParkingPlace parking, {
    required this.parkingSessionService,
    required this.paymentService,
  }) : super(ParkingBookingFlowState.initial(parking));

  final ParkingSessionService parkingSessionService;
  final PaymentService paymentService;

  void selectPlace(String placeId) {
    emit(state.copyWith(selectedPlaceId: placeId));
  }

  void selectPlateType(String plateType) {
    if (plateType == 'TN') {
      emit(
        state.copyWith(
          selectedPlateType: 'TN',
          plateLeftNumber: '1',
          plateCenterText: 'تونس',
          plateRightNumber: '1',
        ),
      );
    } else {
      emit(state.copyWith(selectedPlateType: 'RS', rsText: 'ن ت'));
    }
  }

  void updatePlateLeftNumber(String value) {
    emit(state.copyWith(plateLeftNumber: value));
  }

  void updatePlateCenterText(String value) {
    emit(state.copyWith(plateCenterText: value));
  }

  void updatePlateRightNumber(String value) {
    emit(state.copyWith(plateRightNumber: value));
  }

  void updateRsText(String value) {
    emit(state.copyWith(rsText: value));
  }

  void selectPaymentMethod(String paymentMethodId) {
    emit(state.copyWith(selectedPaymentMethodId: paymentMethodId));
  }

  Future<void> nextStep() async {
    if (!state.canContinue) return;

    if (state.step == ParkingBookingStep.paymentMethod) {
      if (state.selectedPaymentMethodId == 'flouci') {
        await _startFlouciPayment();
      } else {
        emit(state.copyWith(step: ParkingBookingStep.paymentSuccess));
      }
      return;
    }

    final next = state.step.next;
    if (next != null) emit(state.copyWith(step: next));
  }

  void previousStep() {
    final previous = state.step.previous;
    if (previous != null) emit(state.copyWith(step: previous));
  }

  void goToHome(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  // ─── Payment callbacks (invoked from deep-link handler) ──────────────────────

  void onPaymentSuccess() {
    emit(
      state.copyWith(
        paymentLoading: false,
        awaitingDeepLink: false,

        step: ParkingBookingStep.paymentSuccess,
        clearPaymentError: true,
      ),
    );
  }

  void onPaymentFailed() {
    emit(
      state.copyWith(
        paymentLoading: false,
        awaitingDeepLink: false,
        paymentError: 'Paiement échoué ou annulé',
      ),
    );
  }

  void resetPaymentLoading() {
    emit(state.copyWith(paymentLoading: false));
  }

  // ─── Private ─────────────────────────────────────────────────────────────────
  void onAppResumedWithoutDeepLink() {
    if (!state.awaitingDeepLink) return; // Not in a Flouci flow, ignore

    emit(
      state.copyWith(
        awaitingDeepLink: false,
        paymentLoading: false,
        paymentError: 'Paiement annulé ou non complété',
      ),
    );
  }

  Future<void> _startFlouciPayment() async {
    emit(
      state.copyWith(
        paymentLoading: true,
        awaitingDeepLink: false,
        clearPaymentError: true,
      ),
    );

    try {
      final tariff = state.parking.tariff;
      final endTime = DateTime(
        state.startDate!.year,
        state.startDate!.month + 1,
        state.startDate!.day,
        state.startDate!.hour,
        state.startDate!.minute,
        state.startDate!.second,
        state.startDate!.millisecond,
        state.startDate!.microsecond,
      );
      final sessionId = await parkingSessionService.createSession(
        parkingId: state.parking.id,
        vehiclePlate: _vehiclePlate,
        startDate: state.startDate!,
        endDate: endTime,
        pricePerMonth: tariff?.pricePerMonth ?? state.monthlyPrice,
        serviceFee: state.serviceFee,
        totalPrice: state.totalPrice,
        tariffId: tariff?.id,
      );
      print(
        ' 1101 Parking session created with ID: $sessionId amount == ${state.totalPrice}',
      );
      final payLink = await paymentService.initFlouciPayment(
        sessionId: sessionId,
        amount: state.totalPrice * 1000,
      );

      final launched = await launchUrl(
        Uri.parse(payLink),
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        throw Exception('Impossible d\'ouvrir le lien de paiement Flouci');
      }

      // Stop spinner — deep-link handler calls onPaymentSuccess()
      emit(
        state.copyWith(
          paymentLoading: false,
          awaitingDeepLink: true, // NEW — screen uses this to show "waiting" UI
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          paymentLoading: false,
          awaitingDeepLink: false,
          paymentError: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  String get _vehiclePlate {
    if (state.selectedPlateType == 'TN') {
      return '${state.plateLeftNumber}-TN-${state.plateRightNumber}';
    }
    return state.rsText;
  }
}
