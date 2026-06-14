import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/signup_service.dart';
import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpService service;

  SignUpCubit({required this.service}) : super(const SignUpState());

  void firstNameChanged(String value) {
    emit(
      state.copyWith(
        firstName: value,
        status: SignUpStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void lastNameChanged(String value) {
    emit(
      state.copyWith(
        lastName: value,
        status: SignUpStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        status: SignUpStatus.initial,
        clearError: true,
      ),
    );
  }

  void phoneChanged(String value) {
    emit(
      state.copyWith(
        phone: value,
        status: SignUpStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: SignUpStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void confirmPasswordChanged(String value) {
    emit(
      state.copyWith(
        confirmPassword: value,
        status: SignUpStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible));
  }

void nextStep() {
  if (state.step != SignUpStep.info) return;

  if (!state.isStep1Valid) {
    emit(
      state.copyWith(
        showStep1Errors: true,
        status: SignUpStatus.failure,
        errorMessage: 'Veuillez remplir correctement tous les champs.',
      ),
    );
    return;
  }

  emit(
    state.copyWith(
      step: SignUpStep.password,
      showStep1Errors: false,
      errorMessage: null,
    ),
  );
}
void goBack() {
  if (state.step == SignUpStep.password) {
    emit(
      state.copyWith(
        step: SignUpStep.info,
        password: '',          // ← add
        confirmPassword: '',   // ← add
        passwordVisible: false,         // ← add
        confirmPasswordVisible: false,  // ← add
        errorMessage: null,
        showStep1Errors: true,
      ),
    );
  }
}
  Future<void> submit() async {
    if (!state.isStep2Valid || state.status == SignUpStatus.loading) return;

    emit(state.copyWith(status: SignUpStatus.loading, errorMessage: null));

    try {
      await service.register(
        firstName: state.firstName.trim(),
        lastName: state.lastName.trim(),
        email: state.email.trim(),
        phone: state.phone.trim(),
        password: state.password,
      );

      emit(
        state.copyWith(
          status: SignUpStatus.success,
          step: SignUpStep.success,
          errorMessage: null,
        ),
      );
    } catch (e) {
      print("login failed: ${e.toString().replaceFirst('Exception: ', '')}");
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: e.toString().replaceFirst('Exception: ', ''),
        ),
      );
    }
  }
}
