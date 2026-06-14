import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunipark/core/models/user_model.dart';

class AuthStorageService {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userKey = 'user_data';
  static const _onboardingSeenKey = 'onboarding_seen';

  final FlutterSecureStorage storage;

  const AuthStorageService({required this.storage});

  Future<void> saveAccessToken(String token) async {
    await storage.write(key: _accessTokenKey, value: token);
  }

  Future<void> saveRefreshToken(String token) async {
    await storage.write(key: _refreshTokenKey, value: token);
  }

  Future<void> saveUserData(String userJson) async {
    await storage.write(key: _userKey, value: userJson);
  }

  Future<String?> getAccessToken() async {
    return storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return storage.read(key: _refreshTokenKey);
  }

  Future<String?> getUserData() async {
    return storage.read(key: _userKey);
  }

  Future<void> setOnboardingSeen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingSeenKey, value);
  }

  Future<UserModel?> getUser() async {
    final userJson = await getUserData();

    if (userJson == null) return null;

    try {
      final Map<String, dynamic> decoded = jsonDecode(userJson);
      return UserModel.fromJson(decoded);
    } catch (e) {
      return null;
    }
  }

  Future<bool> isOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingSeenKey) ?? false;
  }

  Future<void> clearAll() async {
    await storage.delete(key: _accessTokenKey);
    await storage.delete(key: _refreshTokenKey);
    await storage.delete(key: _userKey);
    //await storage.delete(key: _onboardingSeenKey);
  }
}
