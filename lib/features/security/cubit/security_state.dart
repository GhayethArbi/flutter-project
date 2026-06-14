import 'package:equatable/equatable.dart';

enum SecurityStatus { initial, loading, success, failure }

class SecurityState extends Equatable {
  const SecurityState({
    this.status = SecurityStatus.initial,
    this.errorMessage,
    this.biometricEnabled = false,
    this.twoFactorEnabled = false,
  });

  final SecurityStatus status;
  final String? errorMessage;
  final bool biometricEnabled;
  final bool twoFactorEnabled;

  bool get isLoading => status == SecurityStatus.loading;

  SecurityState copyWith({
    SecurityStatus? status,
    String? errorMessage,
    bool? biometricEnabled,
    bool? twoFactorEnabled,
    bool clearError = false,
  }) {
    return SecurityState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        biometricEnabled,
        twoFactorEnabled,
      ];
}