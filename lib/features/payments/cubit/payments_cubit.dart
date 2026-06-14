import 'package:flutter_bloc/flutter_bloc.dart';
import 'payments_state.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit() : super(PaymentsState.initial());

  Future<void> loadPayments() async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(milliseconds: 300));

    // pour l’instant vide (comme design)
    emit(state.copyWith(
      isLoading: false,
      payments: [],
    ));
  }
}