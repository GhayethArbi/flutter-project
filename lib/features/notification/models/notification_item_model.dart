import 'package:intl/intl.dart';

/// UI bucket used to pick an icon/color for a notification.
/// The backend just sends a free-form `type` string (e.g. "PAYMENT_CONFIRMED",
/// "PARKING_APPROVED", "APP_UPDATE"...), so we map it heuristically here.
enum NotificationType { success, update, warning, info }

NotificationType _typeFromBackend(String rawType) {
  final normalized = rawType.toUpperCase();

  if (normalized.contains('PAYMENT') ||
      normalized.contains('CONFIRM') ||
      normalized.contains('SUCCESS') ||
      normalized.contains('APPROVED')) {
    return NotificationType.success;
  }
  if (normalized.contains('UPDATE')) {
    return NotificationType.update;
  }
  if (normalized.contains('CANCEL') ||
      normalized.contains('REJECT') ||
      normalized.contains('WARN')) {
    return NotificationType.warning;
  }
  return NotificationType.info;
}

class NotificationItemModel {
  final String id;
  final String title;
  final String message;
  final String rawType;
  final NotificationType type;
  final bool isRead;
  final DateTime createdAt;
  final Map<String, dynamic>? data;

  const NotificationItemModel({
    required this.id,
    required this.title,
    required this.message,
    required this.rawType,
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.data,
  });

  /// Backend shape (see NotificationEntity):
  /// { id, userId, title, body, type, data, isRead, createdAt, readAt }
  factory NotificationItemModel.fromJson(Map<String, dynamic> json) {
    final rawType = (json['type'] ?? '').toString();
    return NotificationItemModel(
      id: json['id'].toString(),
      title: (json['title'] ?? '').toString(),
      message: (json['body'] ?? '').toString(),
      rawType: rawType,
      type: _typeFromBackend(rawType),
      isRead: json['isRead'] == true,
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
              DateTime.now(),
      data: json['data'] is Map
          ? Map<String, dynamic>.from(json['data'] as Map)
          : null,
    );
  }

  /// Simple relative-ish display string, e.g. "Aujourd'hui, 10:45".
  String get formattedDate {
    final now = DateTime.now();
    final isToday = now.year == createdAt.year &&
        now.month == createdAt.month &&
        now.day == createdAt.day;

    final time = DateFormat('HH:mm').format(createdAt);
    if (isToday) return "Aujourd'hui, $time";

    // Uses the default 'en_US' locale data that ships with intl, so it
    // works without calling initializeDateFormatting(). Swap for a
    // locale-aware version if/when the app wires up full i18n for dates.
    final dayName = DateFormat('EEEE').format(createdAt);
    return '$dayName, $time';
  }

  NotificationItemModel copyWith({bool? isRead}) {
    return NotificationItemModel(
      id: id,
      title: title,
      message: message,
      rawType: rawType,
      type: type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
      data: data,
    );
  }
}