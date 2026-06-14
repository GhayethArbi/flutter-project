import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState.initial());

  void selectLanguage(AppLanguage language) {
    emit(state.copyWith(selectedLanguage: language));
  }
}