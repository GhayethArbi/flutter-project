import 'package:equatable/equatable.dart';
import '../models/booking_model.dart';

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
