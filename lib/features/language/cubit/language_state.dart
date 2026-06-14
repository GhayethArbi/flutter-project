import 'package:equatable/equatable.dart';

enum AppLanguage {
  french,
  arabic,
}

class LanguageState extends Equatable {
  final AppLanguage selectedLanguage;

  const LanguageState({
    required this.selectedLanguage,
  });

  factory LanguageState.initial() {
    return const LanguageState(
      selectedLanguage: AppLanguage.french,
    );
  }

  LanguageState copyWith({
    AppLanguage? selectedLanguage,
  }) {
    return LanguageState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }

  @override
  List<Object?> get props => [selectedLanguage];
}