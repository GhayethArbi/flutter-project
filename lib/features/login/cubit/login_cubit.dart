import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/features/login/services/login_service.dart';
import 'login_state.dart';
import 'package:tunipark/core/storage/auth_storage_service.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginService loginService;
  final AuthStorageService authStorageService;

  LoginCubit({
    required this.loginService,
    required this.authStorageService,
  }) : super(const LoginState());

  void identifierChanged(String value) {
    emit(
      state.copyWith(
        identifier: value,
        identifierTouched: true,
        status: LoginStatus.initial,
        clearErrorMessage: true,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        passwordTouched: true,
        status: LoginStatus.initial,
        clearErrorMessage: true,
      ),
    );
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  Future<void> submit() async {
    // First show validation errors
    if (!state.isValid) {
      emit(
        state.copyWith(
          showValidationErrors: true,
          identifierTouched: true,
          passwordTouched: true,
          status: LoginStatus.initial,
        ),
      );
      return;
    }

  //   if (!state.isValid) return;

    emit(state.copyWith(status: LoginStatus.loading, clearErrorMessage: true));

    try {
      final response = await loginService.login(
        identifier: state.identifier.trim(), password: state.password,
      );

      final accessToken = response['accessToken']?.toString();
      final refreshToken = response['refreshToken']?.toString();
      final user = response['user'];

      if (accessToken != null && accessToken.isNotEmpty) {
        await authStorageService.saveAccessToken(accessToken);
        await authStorageService.setOnboardingSeen(true);
      }

      if (refreshToken != null && refreshToken.isNotEmpty) {
        await authStorageService.saveRefreshToken(refreshToken);
      }

      if (user != null) {
        await authStorageService.saveUserData(jsonEncode(user));
      }

      emit(
        state.copyWith(
          status: LoginStatus.success,
          accessToken: accessToken,
          refreshToken: refreshToken,
          clearErrorMessage: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
 

    // try {
    //   // Fake login for development
    //   await devSessionService.setDevLoggedIn(true);
    //   await devSessionService.setOnboardingSeen(true);

    //   emit(
    //     state.copyWith(
    //       status: LoginStatus.success,
    //       accessToken: "fake_access_token",
    //       refreshToken: "fake_refresh_token",
    //       clearErrorMessage: true,
    //     ),
    //   );
    // } catch (e) {
    //   emit(
    //     state.copyWith(
    //       status: LoginStatus.failure,
    //       errorMessage: e.toString(),
    //     ),
    //   );
    // }
  }
}