import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileState.initial());

  void updateFirstName(String v) => emit(state.copyWith(firstName: v));
  void updateLastName(String v) => emit(state.copyWith(lastName: v));
  void updateEmail(String v) => emit(state.copyWith(email: v));
  void updatePhone(String v) => emit(state.copyWith(phone: v));
  void updateCurrentPassword(String v) =>
      emit(state.copyWith(currentPassword: v));
  void updateNewPassword(String v) =>
      emit(state.copyWith(newPassword: v));

  Future<void> submit() async {
    if (!state.isValid) return;

    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(isLoading: false));
  }
}