import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/di/service_locator.dart';
import 'package:tunipark/core/router/app_router.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/core/theme/app_tokens.dart';
import 'package:tunipark/features/language/cubit/language_cubit.dart'
    show LanguageCubit;
import 'package:tunipark/features/language/cubit/language_state.dart';
import 'package:tunipark/features/notification/services/fcm_service.dart';
import 'core/theme/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   // No firebase_options.dart / FlutterFire CLI needed: on Android the native
  // Google Services Gradle plugin reads android/app/google-services.json,
  // and on iOS the FirebaseCore pod reads ios/Runner/GoogleService-Info.plist
  // automatically, as long as those two files are added to the project.
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
 
  WidgetsBinding.instance.addPostFrameCallback((_) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  });
  final languageCubit = LanguageCubit();
  await languageCubit.loadSavedLanguage();
  late final AppRouter router;

  router = AppRouter(
    sl: ServiceLocator.create(
      onSessionExpired: () => router.showSessionExpiredDialog(),
    ),
  );

  runApp(
    BlocProvider.value(
      value: languageCubit,
      child: TuniParkApp(router: router),
    ),
  );
}

class TuniParkApp extends StatelessWidget {
  const TuniParkApp({super.key, required this.router});

  final AppRouter router;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
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
              style: TextButton.styleFrom(
                foregroundColor: AppTokens.textPrimary,
              ),
            ),
          ),

          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: router.onGenerateRoute,
           builder: (context, child) {
            return Directionality(
              textDirection: state.selectedLanguage.isRTL
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: KeyedSubtree(
                key: ValueKey(state.selectedLanguage),
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}
