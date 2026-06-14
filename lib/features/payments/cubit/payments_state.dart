import 'package:equatable/equatable.dart';
import '../models/payment_model.dart';

class PaymentsState extends Equatable {
  final List<PaymentModel> payments;
  final bool isLoading;

  const PaymentsState({
    required this.payments,
    required this.isLoading,
  });

  factory PaymentsState.initial() {
    return const PaymentsState(
      payments: [],
      isLoading: false,
    );
  }

  bool get isEmpty => payments.isEmpty;

  PaymentsState copyWith({
    List<PaymentModel>? payments,
    bool? isLoading,
  }) {
    return PaymentsState(
      payments: payments ?? this.payments,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [payments, isLoading];
}