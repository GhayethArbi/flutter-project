import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tunipark/core/di/service_locator.dart';
import 'package:tunipark/core/router/app_router.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'core/theme/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  });

  late final AppRouter router;

  router = AppRouter(
    sl: ServiceLocator.create(
      onSessionExpired: () => router.showSessionExpiredDialog(),
    ),
  );

  runApp(TuniParkApp(router: router));
}

class TuniParkApp extends StatelessWidget {
  const TuniParkApp({super.key, required this.router});

  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: router.navigatorKey,

      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.green,
          selectionColor: Colors.green.withOpacity(0.3),
          selectionHandleColor: Colors.green,
        ),
        textTheme: const TextTheme().apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppTokens.textPrimary),
        ),
      ),

      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}
