class HistoryItemModel {
  final String id;
  final String title;
  final String address;
  final String date;
  final String duration;
  final String payment;

  const HistoryItemModel({
    required this.id,
    required this.title,
    required this.address,
    required this.date,
    required this.duration,
    required this.payment,
  });
}