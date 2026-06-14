import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/features/security/cubit/security_state.dart';


class SecurityCubit extends Cubit<SecurityState> {
  SecurityCubit() : super(const SecurityState());

  void toggleBiometric({required bool value}) {
    emit(state.copyWith(biometricEnabled: value));
    // TODO: persist via local storage / auth service
  }

  void toggleTwoFactor({required bool value}) {
    emit(state.copyWith(twoFactorEnabled: value));
    // TODO: trigger SMS verification flow
  }

  Future<void> disconnectAllDevices() async {
    emit(state.copyWith(status: SecurityStatus.loading, clearError: true));
    try {
      await Future.delayed(const Duration(seconds: 1)); // replace with real API
      emit(state.copyWith(status: SecurityStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: SecurityStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}