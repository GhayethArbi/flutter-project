// TODO: handle errors

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tunipark/features/notification/services/notification_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Backend already saves notification in DB.
}

class FcmService {
  FcmService({required this.notificationService});

  final NotificationService notificationService;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  bool _isListening = false;

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'tunipark_notifications',
    'TuniPark Notifications',
    description: 'Notifications for parking and sessions',
    importance: Importance.high,
  );

  Future<void> initAndRegister() async {
    final permission = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('FCM permission: ${permission.authorizationStatus}');

    await _initLocalNotifications();

    // await _localNotifications.show(
    //   id: 999,
    //   title: 'Test TuniPark',
    //   body: 'Local notification works',
    //   notificationDetails: const NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       'tunipark_notifications',
    //       'TuniPark Notifications',
    //       channelDescription: 'Notifications for parking and sessions',
    //       importance: Importance.high,
    //       priority: Priority.high,
    //       playSound: true,
    //     ),
    //   ),
    // );

    final token = await _messaging.getToken();
    print('FCM TOKEN: $token');

    if (token != null) {
      await _safeRegister(token);
    }

    _messaging.onTokenRefresh.listen(_safeRegister);
    _listenToForegroundMessages();
  }

  Future<void> _initLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(settings: settings);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  void _listenToForegroundMessages() {
    if (_isListening) return;
    _isListening = true;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      final notification = message.notification;

      await _localNotifications.show(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: notification?.title ?? message.data['title'] ?? 'TuniPark',
        body: notification?.body ?? message.data['body'] ?? '',
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'tunipark_notifications',
            'TuniPark Notifications',
            channelDescription: 'Notifications for parking and sessions',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
          ),
        ),
      );
    });
  }

  Future<void> _safeRegister(String token) async {
    try {
      print('FCM TOKEN: $token');
      print('REGISTERING FCM TOKEN...');

      final result = await notificationService.registerFcmToken(
        token,
        platform: Platform.isIOS ? 'ios' : 'android',
      );

      print('FCM TOKEN REGISTERED OK: $result');
    } on DioException catch (e) {
      print('FCM TOKEN REGISTER STATUS: ${e.response?.statusCode}');
      print('FCM TOKEN REGISTER DATA: ${e.response?.data}');
    } catch (e) {
      print('FCM TOKEN REGISTER ERROR: $e');
    }
  }
}
