import 'package:shared_preferences/shared_preferences.dart';

class DevSessionService {
  static const String _devLoggedInKey = 'dev_logged_in';
  static const String _onboardingSeenKey = 'onboarding_seen';

  Future<void> setDevLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_devLoggedInKey, value);
  }

  Future<bool> isDevLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_devLoggedInKey) ?? false;
  }

  Future<void> setOnboardingSeen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingSeenKey, value);
  }

  Future<bool> isOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingSeenKey) ?? false;
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_devLoggedInKey);
    await prefs.remove(_onboardingSeenKey);
  }
}