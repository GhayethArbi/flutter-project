import 'package:tunipark/core/constants/app_constants.dart';

class ApiEndpoints {
  ApiEndpoints._();
  static const String baseUrlNest = AppConstants.baseUrlNest;

  // ── Auth ──────────────────────────────────────────────────────────────────
  static const String login = '$baseUrlNest/auth/login';
  static const String signup = '$baseUrlNest/auth/signup';
  static const String refresh = '$baseUrlNest/auth/refresh';

  // ── Users ─────────────────────────────────────────────────────────────────
  static const String users = '$baseUrlNest/users';
  static const String me = '$baseUrlNest/users/me';
  static String userById(String id) => '$baseUrlNest/users/$id';
  static String changePassword(String userId) =>
      '$baseUrlNest/users/$userId/change-password';
  // ── parkings ─────────────────────────────────────────────────────────────────
  static const parkings = '$baseUrlNest/parkings';
  static const createParking = '$baseUrlNest/parkings';
  static const recommendedParkings = '$baseUrlNest/parkings/recommended';

  static const uploadParkingPictures = '$baseUrlNest/parkings/upload-pictures';
  static const createTariff = '$baseUrlNest/tariffs';
  static const tariffs = '$baseUrlNest/tariffs';

  static String tariffByParking(String parkingId) =>
      '$tariffs/by-parking/$parkingId';
  // ── Parking Sessions ─────────────────────────────────────────────
  static const parkingSessions = '$baseUrlNest/parking-sessions';
  static const myparkingSessions = '$baseUrlNest/parking-sessions/me';

  // ── Payments ─────────────────────────────────────────────────────
  static const payments = '$baseUrlNest/payments';
  static const initFlouciPayment = '$baseUrlNest/payments/init/flouci';

  // ── Notifications ──────────────────────────────────────────────────
  static const notifications = '$baseUrlNest/notifications';
  static const registerFcmToken = '$baseUrlNest/notifications/fcm-token';
  static String markNotificationAsRead(String id) =>
      '$baseUrlNest/notifications/$id/read';
}
