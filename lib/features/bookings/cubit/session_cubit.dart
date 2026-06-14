// lib/features/bookings/cubit/session_cubit.dart

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/booking_model.dart';
import '../services/booking_service.dart';

// ── State ─────────────────────────────────────────────────────────────────

enum SessionAction { none, ending, extending, polling }

class SessionState extends Equatable {
  const SessionState({
    required this.booking,
    this.action = SessionAction.none,
    this.errorMessage,
    this.extendPayLink,
    this.extendPaymentId,
    this.extendSuccess = false,
    this.endSuccess = false,
  });

  final BookingModel booking;
  final SessionAction action;
  final String? errorMessage;

  // Flouci extend flow
  final String? extendPayLink;
  final String? extendPaymentId;
  final bool extendSuccess;
  final bool endSuccess;

  bool get isBusy => action != SessionAction.none;

  SessionState copyWith({
    BookingModel? booking,
    SessionAction? action,
    String? errorMessage,
    String? extendPayLink,
    String? extendPaymentId,
    bool? extendSuccess,
    bool? endSuccess,
  }) {
    return SessionState(
      booking: booking ?? this.booking,
      action: action ?? this.action,
      errorMessage: errorMessage,
      extendPayLink: extendPayLink ?? this.extendPayLink,
      extendPaymentId: extendPaymentId ?? this.extendPaymentId,
      extendSuccess: extendSuccess ?? this.extendSuccess,
      endSuccess: endSuccess ?? this.endSuccess,
    );
  }

  @override
  List<Object?> get props => [
        booking,
        action,
        errorMessage,
        extendPayLink,
        extendPaymentId,
        extendSuccess,
        endSuccess,
      ];
}

// ── Cubit ──────────────────────────────────────────────────────────────────

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({
    required BookingModel booking,
    required BookingService bookingService,
  })  : _service = bookingService,
        super(SessionState(booking: booking));

  final BookingService _service;
  Timer? _pollTimer;

  // ── End session ──────────────────────────────────────────────────────────

  Future<void> endSession() async {
    emit(state.copyWith(action: SessionAction.ending, errorMessage: null));
    try {
      await _service.endSession(state.booking.sessionId);
      emit(state.copyWith(action: SessionAction.none, endSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        action: SessionAction.none,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  // ── Extend session (init Flouci for same parkingId) ───────────────────────
  // "Extend" = the owner creates a new session for the same parking.
  // In your backend there's no "extend" endpoint, so the flow is:
  // 1. End current session
  // 2. Create new session (same parkingId + vehiclePlate)
  // 3. Init Flouci payment on the new session
  // 4. Return payLink → open in browser/webview
  // 5. Poll payment status until PAID
  //
  // This matches your existing ParkingBookingFlowCubit pattern.

  Future<void> initExtend() async {
    emit(state.copyWith(
      action: SessionAction.extending,
      errorMessage: null,
      extendPayLink: null,
      extendPaymentId: null,
    ));

    try {
      // Step 1: init Flouci on the CURRENT session
      // (server will create a new payment linked to this session)
      final result =
          await _service.initFlouciPayment(state.booking.sessionId);

      emit(state.copyWith(
        action: SessionAction.none,
        extendPayLink: result.payLink,
        extendPaymentId: result.paymentId,
      ));
    } catch (e) {
      emit(state.copyWith(
        action: SessionAction.none,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  /// Start polling payment status every 3s after user returns from Flouci
  void startPollingPayment() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      final paymentId = state.extendPaymentId;
      if (paymentId == null) return;

      try {
        final result = await _service.getPaymentStatus(paymentId);
        if (result.isPaid) {
          _pollTimer?.cancel();
          emit(state.copyWith(
            action: SessionAction.none,
            extendSuccess: true,
          ));
        } else if (result.isFailed) {
          _pollTimer?.cancel();
          emit(state.copyWith(
            action: SessionAction.none,
            errorMessage: 'Paiement échoué. Veuillez réessayer.',
          ));
        }
      } catch (_) {
        // silently ignore poll errors
      }
    });
  }

  void stopPolling() => _pollTimer?.cancel();

  void clearError() =>
      emit(state.copyWith(action: SessionAction.none, errorMessage: null));

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }
}