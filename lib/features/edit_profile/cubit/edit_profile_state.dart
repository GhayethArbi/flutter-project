import 'package:equatable/equatable.dart';

class EditProfileState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String currentPassword;
  final String newPassword;
  final bool isLoading;

  const EditProfileState({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.currentPassword,
    required this.newPassword,
    required this.isLoading,
  });

  factory EditProfileState.initial() {
    return const EditProfileState(
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      currentPassword: '',
      newPassword: '',
      isLoading: false,
    );
  }

  bool get isValid =>
      firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      email.isNotEmpty &&
      phone.isNotEmpty;

  EditProfileState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? currentPassword,
    String? newPassword,
    bool? isLoading,
  }) {
    return EditProfileState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phone,
        currentPassword,
        newPassword,
        isLoading,
      ];
}