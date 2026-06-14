import 'package:flutter/material.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/core/storage/auth_storage_service.dart';

class LogoutHandler {
  const LogoutHandler({
    required this.authStorageService,
    required this.navigatorKey,
  });

  final AuthStorageService authStorageService;
  final GlobalKey<NavigatorState> navigatorKey;

  Future<void> logout() async {
    await authStorageService.clearAll();

    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      AppRoutes.login,
      (route) => false,
    );
  }
}