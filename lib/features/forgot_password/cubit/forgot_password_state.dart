enum ForgotPasswordStep { identifier, verifyCode, newPassword, resetSuccess }

enum ForgotPasswordStatus { initial, loading, success, failure }

class ForgotPasswordState {
  final ForgotPasswordStep step;
  final ForgotPasswordStatus status;

  final String identifier;
  final String code;
  final String resetToken;

  final String password;
  final String confirmPassword;
  final bool identifierTouched;
  final bool codeTouched;
  final bool passwordTouched;
  final bool confirmPasswordTouched;

  final String? errorMessage;

  const ForgotPasswordState({
    this.step = ForgotPasswordStep.identifier,
    this.status = ForgotPasswordStatus.initial,
    this.identifier = '',
    this.code = '',
    this.resetToken = '',
    this.password = '',
    this.confirmPassword = '',
    this.identifierTouched = false,
    this.codeTouched = false,
    this.passwordTouched = false,
    this.confirmPasswordTouched = false,
    this.errorMessage,
  });

  bool get isIdentifierValid => identifier.trim().isNotEmpty;

  bool get isCodeValid => code.length == 6;

  bool get isPasswordValid => password.length >= 6;

  bool get isConfirmPasswordValid =>
      confirmPassword.isNotEmpty && confirmPassword == password;

  bool get canContinue {
    switch (step) {
      case ForgotPasswordStep.identifier:
        return isIdentifierValid;
      case ForgotPasswordStep.verifyCode:
        return isCodeValid;
      case ForgotPasswordStep.newPassword:
        return isPasswordValid && isConfirmPasswordValid;
      case ForgotPasswordStep.resetSuccess:
        return true;
    }
  }

  String? get identifierError {
    if (!identifierTouched) return null;
    if (identifier.trim().isEmpty) return 'Champs requis*';
    return null;
  }

  String? get passwordError {
    if (!passwordTouched) return null;
    if (password.trim().isEmpty) return 'Champs requis*';
    if (password.length < 6) return 'Minimum 6 caractères';
    return null;
  }

  String? get confirmPasswordError {
    if (!confirmPasswordTouched) return null;
    if (confirmPassword.trim().isEmpty) return 'Champs requis*';
    if (confirmPassword != password)
      return 'Les mots de passe ne correspondent pas';
    return null;
  }

  ForgotPasswordState copyWith({
    ForgotPasswordStep? step,
    ForgotPasswordStatus? status,
    String? identifier,
    String? code,
    String? resetToken,
    String? password,
    String? confirmPassword,
    bool? identifierTouched,
    bool? codeTouched,
    bool? passwordTouched,
    bool? confirmPasswordTouched,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ForgotPasswordState(
      step: step ?? this.step,
      status: status ?? this.status,
      identifier: identifier ?? this.identifier,
      code: code ?? this.code,
      resetToken: resetToken ?? this.resetToken,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      identifierTouched: identifierTouched ?? this.identifierTouched,
      codeTouched: codeTouched ?? this.codeTouched,
      passwordTouched: passwordTouched ?? this.passwordTouched,
      confirmPasswordTouched:
          confirmPasswordTouched ?? this.confirmPasswordTouched,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
  