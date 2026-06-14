enum NotificationType {
  success,
  update,
  info,
}

class NotificationItemModel {
  final String id;
  final String title;
  final String message;
  final String date;
  final NotificationType type;
  final bool isRead;

  const NotificationItemModel({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.type,
    required this.isRead,
  });

  NotificationItemModel copyWith({
    String? id,
    String? title,
    String? message,
    String? date,
    NotificationType? type,
    bool? isRead,
  }) {
    return NotificationItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      date: date ?? this.date,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }
}