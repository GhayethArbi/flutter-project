part of 'change_password_cubit.dart';

enum ChangePasswordStatus { initial, loading, success, failure }

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.status = ChangePasswordStatus.initial,
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.showCurrent = false,
    this.showNew = false,
    this.showConfirm = false,
    this.errorMessage,
  });

  final ChangePasswordStatus status;
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final bool showCurrent;
  final bool showNew;
  final bool showConfirm;
  final String? errorMessage;

  bool get isLoading => status == ChangePasswordStatus.loading;
  bool get isSuccess => status == ChangePasswordStatus.success;

  // ── Password strength ────────────────────────────────────────────────────
  int get strengthScore {
    int score = 0;
    if (newPassword.length >= 8) score++;
    if (newPassword.contains(RegExp(r'[A-Z]'))) score++;
    if (newPassword.contains(RegExp(r'[0-9]'))) score++;
    if (newPassword.contains(RegExp(r'[!@#\$&*~%^()]'))) score++;
    return score;
  }

  bool get hasMinLength => newPassword.length >= 8;
  bool get hasUppercase => newPassword.contains(RegExp(r'[A-Z]'));
  bool get hasDigit => newPassword.contains(RegExp(r'[0-9]'));
  bool get hasSpecial => newPassword.contains(RegExp(r'[!@#\$&*~%^()]'));
  bool get passwordsMatch =>
      newPassword.isNotEmpty && newPassword == confirmPassword;

  bool get canSubmit =>
      currentPassword.isNotEmpty &&
      hasMinLength &&
      passwordsMatch &&
      !isLoading;

  ChangePasswordState copyWith({
    ChangePasswordStatus? status,
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    bool? showCurrent,
    bool? showNew,
    bool? showConfirm,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ChangePasswordState(
      status: status ?? this.status,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showCurrent: showCurrent ?? this.showCurrent,
      showNew: showNew ?? this.showNew,
      showConfirm: showConfirm ?? this.showConfirm,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentPassword,
        newPassword,
        confirmPassword,
        showCurrent,
        showNew,
        showConfirm,
        errorMessage,
      ];
}