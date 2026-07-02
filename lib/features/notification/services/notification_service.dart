import 'package:dio/dio.dart';
import 'package:tunipark/core/network/api_endpoints.dart';
import 'package:tunipark/features/notification/models/notification_item_model.dart';

class NotificationService {
  NotificationService({required this.dio});

  final Dio dio;

  /// GET /notifications — backend infers the user from the auth token.
  Future<List<NotificationItemModel>> fetchMyNotifications() async {
    print('NotificationService.fetchMyNotifications: fetching... 11011');
    print(
      'NotificationService.fetchMyNotifications: ${ApiEndpoints.notifications} 11011',
    );
    final response = await dio.get(ApiEndpoints.notifications);
    print('NotificationService.fetchMyNotifications: fetching... 11011');

    print('NotificationService.fetchMyNotifications: ${response.data} 11011');
    final List<dynamic> raw = response.data as List<dynamic>;
    return raw
        .map(
          (json) =>
              NotificationItemModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  /// PATCH /notifications/:id/read
  Future<void> markAsRead(String notificationId) async {
    await dio.patch(ApiEndpoints.markNotificationAsRead(notificationId));
  }

  /// POST /notifications/fcm-token — registers/updates this device's FCM
  /// token so the backend can push to it via SendNotificationUseCase.
  Future<dynamic> registerFcmToken(String token, {String? platform}) async {
    final response = await dio.post(
      '/notifications/fcm-token',
      data: {'token': token, 'platform': platform},
    );

    return response.data;
  }
}
