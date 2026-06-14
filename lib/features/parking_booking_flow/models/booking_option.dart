class BookingOption {
  final String id;
  final String title;
  final String subtitle;
  final String priceLabel;
  final bool isComplete;

  const BookingOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.priceLabel,
    this.isComplete = false,
  });
}