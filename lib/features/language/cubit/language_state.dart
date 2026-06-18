import 'package:equatable/equatable.dart';

enum AppLanguage { french, arabic, english }

extension AppLanguageX on AppLanguage {
  String get code {
    switch (this) {
      case AppLanguage.french: return 'fr';
      case AppLanguage.arabic: return 'ar';
      case AppLanguage.english: return 'en';
    }
  }

  bool get isRTL => this == AppLanguage.arabic;
}

class LanguageState extends Equatable {
  final AppLanguage selectedLanguage;
  const LanguageState({required this.selectedLanguage});

  factory LanguageState.initial() =>
      const LanguageState(selectedLanguage: AppLanguage.french);

  LanguageState copyWith({AppLanguage? selectedLanguage}) =>
      LanguageState(selectedLanguage: selectedLanguage ?? this.selectedLanguage);

  @override
  List<Object?> get props => [selectedLanguage];
}