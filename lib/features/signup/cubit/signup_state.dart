enum SignUpStep { info, password, success }

enum SignUpStatus { initial, loading, success, failure }

class SignUpState {
  final SignUpStep step;
  final SignUpStatus status;

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final bool passwordVisible;
  final bool confirmPasswordVisible;
  final String? errorMessage;
  final bool showStep1Errors;

  const SignUpState({
    this.step = SignUpStep.info,
    this.status = SignUpStatus.initial,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.passwordVisible = false,
    this.confirmPasswordVisible = false,
    this.errorMessage,
    this.showStep1Errors = false,
  });
  SignUpState copyWith({
    SignUpStep? step,
    SignUpStatus? status,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    bool? passwordVisible,
    bool? confirmPasswordVisible,
    String? errorMessage,
    bool clearError = false,
    bool? showStep1Errors,
  }) {
    return SignUpState(
      step: step ?? this.step,
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      confirmPasswordVisible:
          confirmPasswordVisible ?? this.confirmPasswordVisible,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      showStep1Errors: showStep1Errors ?? this.showStep1Errors,
    );
  }

  String? get firstNameError {
    if (!showStep1Errors) return null;
    if (firstName.trim().isEmpty) return 'Nom obligatoire';
    if (firstName.trim().length < 2) return 'Nom trop court';
    return null;
  }

  String? get lastNameError {
    if (!showStep1Errors) return null;
    if (lastName.trim().isEmpty) return 'Prénom obligatoire';
    if (lastName.trim().length < 2) return 'Prénom trop court';
    return null;
  }

  String? get emailError {
    if (!showStep1Errors) return null;
    if (email.trim().isEmpty) return 'E-mail obligatoire';
    if (!isEmailValid) return 'Adresse e-mail invalide';
    return null;
  }

  String? get phoneError {
    if (!showStep1Errors) return null;
    if (phone.trim().isEmpty) return 'Numéro obligatoire';
    if (!isPhoneValid) return 'Numéro invalide';
    return null;
  }

  bool get isEmailValid {
    return RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(email.trim());
  }

  bool get isPhoneValid {
    return RegExp(r'^[0-9]{8}$').hasMatch(phone.trim());
  }

  bool get isPasswordValid {
    return password.length >= 6;
  }

  bool get isConfirmPasswordValid {
    return confirmPassword == password && confirmPassword.isNotEmpty;
  }

  String? get passwordError {
    if (password.isEmpty) return null;
    if (!isPasswordValid) return 'Minimum 6 caractères';
    return null;
  }

  String? get confirmPasswordError {
    if (confirmPassword.isEmpty) return null;
    if (!isConfirmPasswordValid)
      return 'Les mots de passe ne correspondent pas';
    return null;
  }

  bool get isStep1Valid {
    return firstName.trim().length >= 2 &&
        lastName.trim().length >= 2 &&
        isEmailValid &&
        isPhoneValid;
  }

  bool get isStep2Valid {
    return isPasswordValid && isConfirmPasswordValid;
  }
}
