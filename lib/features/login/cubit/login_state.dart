enum LoginStatus { initial, loading, success, failure }

class LoginState {
  final String identifier;
  final String password;
  final bool passwordVisible;
  final LoginStatus status;
  final String? errorMessage;
  final String? accessToken;
  final String? refreshToken;

  // NEW
  final bool identifierTouched;
  final bool passwordTouched;
  final bool showValidationErrors;

  const LoginState({
    this.identifier = '',
    this.password = '',
    this.passwordVisible = false,
    this.status = LoginStatus.initial,
    this.errorMessage,
    this.accessToken,
    this.refreshToken,
    this.identifierTouched = false,
    this.passwordTouched = false,
    this.showValidationErrors = false,
  });

  bool get isIdentifierValid {
    final value = identifier.trim();

    final isEmail = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
    final isPhone = RegExp(r'^\+?[0-9]{6,15}$').hasMatch(value);
    return isEmail || isPhone;
  }

  bool get isPasswordValid {
    return password.trim().isNotEmpty;
  }

  bool get isValid {
    return isIdentifierValid && isPasswordValid;
  }

  String? get identifierError {
    final shouldShow = showValidationErrors || identifierTouched;
    if (!shouldShow) return null;

    if (identifier.trim().isEmpty) {
      return 'Champs requis*';
    }

    if (!isIdentifierValid) {
      return 'Email ou numéro invalide';
    }

    return null;
  }

  String? get passwordError {
    final shouldShow = showValidationErrors || passwordTouched;
    if (!shouldShow) return null;

    if (password.trim().isEmpty) {
      return 'Champs requis*';
    }

    return null;
  }

  LoginState copyWith({
    String? identifier,
    String? password,
    bool? passwordVisible,
    LoginStatus? status,
    String? errorMessage,
    String? accessToken,
    String? refreshToken,
    bool? identifierTouched,
    bool? passwordTouched,
    bool? showValidationErrors,
    bool clearErrorMessage = false,
    bool clearAccessToken = false,
    bool clearRefreshToken = false,
  }) {
    return LoginState(
      identifier: identifier ?? this.identifier,
      password: password ?? this.password,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      status: status ?? this.status,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
      accessToken: clearAccessToken ? null : (accessToken ?? this.accessToken),
      refreshToken: clearRefreshToken
          ? null
          : (refreshToken ?? this.refreshToken),
      identifierTouched: identifierTouched ?? this.identifierTouched,
      passwordTouched: passwordTouched ?? this.passwordTouched,
      showValidationErrors: showValidationErrors ?? this.showValidationErrors,
    );
  }
}
