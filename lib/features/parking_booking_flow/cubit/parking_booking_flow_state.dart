import 'package:equatable/equatable.dart';
import 'package:tunipark/features/parking_map/models/parking_place.dart';

enum ParkingBookingStep {
  choosePlace,
  vehicleInfo,
  orderDetails,
  paymentMethod,
  paymentSuccess,
}

extension ParkingBookingStepX on ParkingBookingStep {
  static const int _totalSteps = 5;

  int get totalSteps => _totalSteps;

  int get indexValue => ParkingBookingStep.values.indexOf(this);

  bool get isFirst => this == ParkingBookingStep.choosePlace;
  bool get isLast => this == ParkingBookingStep.paymentSuccess;

  ParkingBookingStep? get next {
    final nextIndex = indexValue + 1;
    if (nextIndex >= _totalSteps) return null;
    return ParkingBookingStep.values[nextIndex];
  }

  ParkingBookingStep? get previous {
    final prevIndex = indexValue - 1;
    if (prevIndex < 0) return null;
    return ParkingBookingStep.values[prevIndex];
  }
}

class ParkingBookingFlowState extends Equatable {
  final ParkingPlace parking;
  final ParkingBookingStep step;

  final String? selectedPlaceId;

  final String? selectedPlateType;
  final String plateLeftNumber;
  final String plateCenterText;
  final String plateRightNumber;
  final String rsText;

  final DateTime? startDate;
  final DateTime? endDate;

  final double monthlyPrice;
  final double serviceFee;

  final String? selectedPaymentMethodId;

  final bool paymentLoading;
  final String? paymentError;
  final bool awaitingDeepLink; // NEW

  const ParkingBookingFlowState({
    required this.parking,
    required this.step,
    required this.selectedPlaceId,
    required this.selectedPlateType,
    required this.plateLeftNumber,
    required this.plateCenterText,
    required this.plateRightNumber,
    required this.rsText,
    required this.startDate,
    required this.endDate,
    required this.monthlyPrice,
    required this.serviceFee,
    required this.selectedPaymentMethodId,
    required this.paymentLoading,
    required this.paymentError,
    required this.awaitingDeepLink,
  });

  factory ParkingBookingFlowState.initial(ParkingPlace parking) {
    return ParkingBookingFlowState(
      parking: parking,
      step: ParkingBookingStep.choosePlace,
      selectedPlaceId: null,
      selectedPlateType: 'TN',
      plateLeftNumber: '1',
      plateCenterText: 'تونس',
      plateRightNumber: '1',
      rsText: 'ن ت',
      startDate: DateTime(2026, 4, 1),
      endDate: DateTime(2026, 4, 30),
      monthlyPrice: parking.price,
      serviceFee: 10,
      selectedPaymentMethodId: null,
      paymentLoading: false,
      paymentError: null,
      awaitingDeepLink: false, // NEW
    );
  }

  double get totalPrice => monthlyPrice + serviceFee;

  bool get canContinue {
    if (paymentLoading) return false;

    switch (step) {
      case ParkingBookingStep.choosePlace:
        return selectedPlaceId != null;
      case ParkingBookingStep.vehicleInfo:
        if (selectedPlateType == 'TN') {
          return plateLeftNumber.trim().isNotEmpty &&
              plateCenterText.trim().isNotEmpty &&
              plateRightNumber.trim().isNotEmpty;
        }
        return rsText.trim().isNotEmpty;
      case ParkingBookingStep.orderDetails:
        return true;
      case ParkingBookingStep.paymentMethod:
        return selectedPaymentMethodId != null;
      case ParkingBookingStep.paymentSuccess:
        return true;
    }
  }

  ParkingBookingFlowState copyWith({
    ParkingPlace? parking,
    ParkingBookingStep? step,
    String? selectedPlaceId,
    String? selectedPlateType,
    String? plateLeftNumber,
    String? plateCenterText,
    String? plateRightNumber,
    String? rsText,
    DateTime? startDate,
    DateTime? endDate,
    double? monthlyPrice,
    double? serviceFee,
    String? selectedPaymentMethodId,
    bool? paymentLoading,
    String? paymentError,
    bool clearPaymentError = false,
    bool? awaitingDeepLink, // NEW
  }) {
    return ParkingBookingFlowState(
      parking: parking ?? this.parking,
      step: step ?? this.step,
      selectedPlaceId: selectedPlaceId ?? this.selectedPlaceId,
      selectedPlateType: selectedPlateType ?? this.selectedPlateType,
      plateLeftNumber: plateLeftNumber ?? this.plateLeftNumber,
      plateCenterText: plateCenterText ?? this.plateCenterText,
      plateRightNumber: plateRightNumber ?? this.plateRightNumber,
      rsText: rsText ?? this.rsText,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      monthlyPrice: monthlyPrice ?? this.monthlyPrice,
      serviceFee: serviceFee ?? this.serviceFee,
      selectedPaymentMethodId:
          selectedPaymentMethodId ?? this.selectedPaymentMethodId,
      paymentLoading: paymentLoading ?? this.paymentLoading,
      paymentError: clearPaymentError
          ? null
          : (paymentError ?? this.paymentError),
      awaitingDeepLink: awaitingDeepLink ?? this.awaitingDeepLink, // NEW
    );
  }

  @override
  List<Object?> get props => [
    parking,
    step,
    selectedPlaceId,
    selectedPlateType,
    plateLeftNumber,
    plateCenterText,
    plateRightNumber,
    rsText,
    startDate,
    endDate,
    monthlyPrice,
    serviceFee,
    selectedPaymentMethodId,
    paymentLoading,
    paymentError,
    awaitingDeepLink, // NEW
  ];
}
