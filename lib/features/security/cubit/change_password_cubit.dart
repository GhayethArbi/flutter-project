import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/auth/logout_handler.dart';
import 'package:tunipark/core/storage/auth_storage_service.dart';
import 'package:tunipark/features/security/service/change_password_service.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required this.changePasswordService,
    required this.authStorageService,
    required this.logoutHandler,
  }) : super(const ChangePasswordState());

  final ChangePasswordService changePasswordService;
  final AuthStorageService authStorageService;
  final LogoutHandler logoutHandler;

  void updateCurrentPassword(String value) =>
      emit(state.copyWith(currentPassword: value, clearError: true));

  void updateNewPassword(String value) =>
      emit(state.copyWith(newPassword: value, clearError: true));

  void updateConfirmPassword(String value) =>
      emit(state.copyWith(confirmPassword: value, clearError: true));

  void toggleCurrentVisibility() =>
      emit(state.copyWith(showCurrent: !state.showCurrent));

  void toggleNewVisibility() => emit(state.copyWith(showNew: !state.showNew));

  void toggleConfirmVisibility() =>
      emit(state.copyWith(showConfirm: !state.showConfirm));

  Future<void> submit() async {
    if (!state.canSubmit) return;
    emit(
      state.copyWith(status: ChangePasswordStatus.loading, clearError: true),
    );
    try {
      final user = await authStorageService.getUser();
      if (user == null) {
        emit(
          state.copyWith(
            status: ChangePasswordStatus.failure,
            errorMessage: 'Session expirée. Veuillez vous reconnecter.',
          ),
        );
        return;
      }

      await changePasswordService.changePassword(
        userId: user.id,
        currentPassword: state.currentPassword,
        newPassword: state.newPassword,
      );

      emit(state.copyWith(status: ChangePasswordStatus.success));
      logoutHandler.logout();
    } catch (e) {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
