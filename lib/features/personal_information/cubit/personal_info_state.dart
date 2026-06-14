part of 'personal_info_cubit.dart';

enum PersonalInfoStatus { initial, loading, loaded, saving, success, failure }

class PersonalInfoState {
  const PersonalInfoState({
    this.status = PersonalInfoStatus.initial,
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.errorMessage,
  });

  final PersonalInfoStatus status;
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? errorMessage;

  // ── Convenience getters ───────────────────────────────────────────────────

  bool get isLoading => status == PersonalInfoStatus.loading;
  bool get isSaving => status == PersonalInfoStatus.saving;
  bool get isSuccess => status == PersonalInfoStatus.success;
  bool get hasError => status == PersonalInfoStatus.failure;

  String get fullName => '$firstName $lastName'.trim();

  String get avatarInitials {
    final f = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final l = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$f$l';
  }

  // ── copyWith ──────────────────────────────────────────────────────────────

  PersonalInfoState copyWith({
    PersonalInfoStatus? status,
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PersonalInfoState(
      status: status ?? this.status,
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}