import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  static const _key = 'app_language';

  LanguageCubit() : super(LanguageState.initial());

  /// Call this once at startup before runApp
  Future<void> loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code == null) return;

    final language = AppLanguage.values.firstWhere(
      (l) => l.code == code,
      orElse: () => AppLanguage.french,
    );
    AppStrings.setLanguage(language.code);
    emit(state.copyWith(selectedLanguage: language));
  }

  Future<void> selectLanguage(AppLanguage language) async {
    AppStrings.setLanguage(language.code);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, language.code);
    emit(state.copyWith(selectedLanguage: language));
  }
}