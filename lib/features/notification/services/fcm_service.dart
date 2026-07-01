import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tunipark/features/notification/services/notification_service.dart';

/// Must stay a top-level (or static) function — Firebase requires this for
/// background message handling on Android. Firebase.initializeApp() runs
/// again here because this handler executes in its own isolate.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Nothing to do here for now: the backend already persisted the
  // notification (SendNotificationUseCase creates the row before pushing),
  // so the app just needs to have a token registered. If you later want to
  // e.g. update a local badge count while the app is killed/backgrounded,
  // do it here — but keep it fast and side-effect light.
}

class FcmService {
  FcmService({required this.notificationService});

  final NotificationService notificationService;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Call once the user is authenticated (Dio already carries the auth
  /// token at that point) — e.g. right after login, or on app start if a
  /// session already exists. Safe to call multiple times.
  Future<void> initAndRegister() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // iOS needs the APNs token to be available before getToken() resolves
    // reliably; this is a no-op on Android.
    if (Platform.isIOS) {
      await _messaging.getAPNSToken();
    }

    final token = await _messaging.getToken();
    if (token != null) {
      await _safeRegister(token);
    }

    _messaging.onTokenRefresh.listen(_safeRegister);
  }

  Future<void> _safeRegister(String token) async {
    try {
      await notificationService.registerFcmToken(
        token,
        platform: Platform.isIOS ? 'ios' : 'android',
      );
    } catch (_) {
      // Best-effort: don't block app usage on this. It'll retry on the next
      // initAndRegister() call (e.g. next login) or the next token refresh.
    }
  }
}