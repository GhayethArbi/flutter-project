import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/storage/auth_storage_service.dart';
import 'package:tunipark/features/personal_information/services/user_service.dart';

part 'personal_info_state.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit({
    required this.authStorageService,
    required this.userService,
  }) : super(const PersonalInfoState());

  final AuthStorageService authStorageService;
  final UserService userService;

  // ── Load ──────────────────────────────────────────────────────────────────

  Future<void> loadProfile() async {
    emit(state.copyWith(status: PersonalInfoStatus.loading));

    try {
      final user = await authStorageService.getUser();

      if (user == null) {
        emit(state.copyWith(
          status: PersonalInfoStatus.failure,
          errorMessage: 'Impossible de charger le profil.',
        ));
        return;
      }

      emit(state.copyWith(
        status: PersonalInfoStatus.loaded,
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        phone: user.phoneNumber ?? '',
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PersonalInfoStatus.failure,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  // ── Update ────────────────────────────────────────────────────────────────

  Future<void> updateField({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
  }) async {
    emit(state.copyWith(status: PersonalInfoStatus.saving));

    try {
      // Token injection is handled by AuthInterceptor — no token logic here.
      final updatedUser = await userService.updateUser(
        userId: state.id,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phone,
        email: email,
      );

      // Keep local storage in sync with the server response.
      await authStorageService.saveUserData(jsonEncode(updatedUser));

      emit(state.copyWith(
        status: PersonalInfoStatus.success,
        firstName: firstName ?? state.firstName,
        lastName: lastName ?? state.lastName,
        phone: phone ?? state.phone,
        email: email ?? state.email,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: PersonalInfoStatus.failure,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  void resetStatus() => emit(state.copyWith(status: PersonalInfoStatus.loaded));
}