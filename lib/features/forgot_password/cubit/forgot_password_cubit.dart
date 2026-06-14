import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/forgot_password_service.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordService service;

  ForgotPasswordCubit({required this.service})
    : super(const ForgotPasswordState());

  void identifierChanged(String value) {
    emit(
      state.copyWith(
        identifier: value,
        identifierTouched: true,
        status: ForgotPasswordStatus.initial,
        clearError: true,
      ),
    );
  }

  void codeChanged(String value) {
    emit(
      state.copyWith(
        code: value,
        codeTouched: true,
        status: ForgotPasswordStatus.initial,
        clearError: true,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        passwordTouched: true,
        status: ForgotPasswordStatus.initial,
        clearError: true,
      ),
    );
  }

  void confirmPasswordChanged(String value) {
    emit(
      state.copyWith(
        confirmPassword: value,
        confirmPasswordTouched: true,
        status: ForgotPasswordStatus.initial,
        clearError: true,
      ),
    );
  }

  Future<void> continuePressed() async {
    switch (state.step) {
      case ForgotPasswordStep.identifier:
        await _sendResetCode();
        break;
      case ForgotPasswordStep.verifyCode:
        await _verifyCode();
        break;
      case ForgotPasswordStep.newPassword:
        await _resetPassword();
        break;
      case ForgotPasswordStep.resetSuccess:
        break;
    }
  }

  Future<void> _sendResetCode() async {
    if (!state.isIdentifierValid) {
      emit(state.copyWith(identifierTouched: true));
      return;
    }

    emit(state.copyWith(status: ForgotPasswordStatus.loading));

    try {
      await service.requestResetOtp(identifier: state.identifier);

      emit(
        state.copyWith(
          status: ForgotPasswordStatus.success,
          step: ForgotPasswordStep.verifyCode,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _verifyCode() async {
    if (!state.isCodeValid) {
      emit(state.copyWith(codeTouched: true));
      return;
    }

    emit(state.copyWith(status: ForgotPasswordStatus.loading));

    try {
      final resetToken = await service.verifyOtp(
        identifier: state.identifier,
        otp: state.code,
      );

      emit(
        state.copyWith(
          resetToken: resetToken,
          status: ForgotPasswordStatus.success,
          step: ForgotPasswordStep.newPassword,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _resetPassword() async {
    if (!state.isPasswordValid || !state.isConfirmPasswordValid) {
      emit(state.copyWith(passwordTouched: true, confirmPasswordTouched: true));
      return;
    }

    emit(state.copyWith(status: ForgotPasswordStatus.loading));

    try {
      await service.resetPassword(
        token: state.resetToken,
        newPassword: state.password,
      );

      emit(
        state.copyWith(
          status: ForgotPasswordStatus.success,
          step: ForgotPasswordStep.resetSuccess,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ForgotPasswordStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> resendCode() async {
    await _sendResetCode();
  }

  void back() {
    switch (state.step) {
      case ForgotPasswordStep.identifier:
        break;
      case ForgotPasswordStep.verifyCode:
        emit(state.copyWith(step: ForgotPasswordStep.identifier));
        break;
      case ForgotPasswordStep.newPassword:
        emit(state.copyWith(step: ForgotPasswordStep.verifyCode));
        break;
      case ForgotPasswordStep.resetSuccess:
        emit(state.copyWith(step: ForgotPasswordStep.newPassword));
        break;
    }
  }
}
