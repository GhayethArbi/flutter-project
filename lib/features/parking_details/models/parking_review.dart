class ParkingReview {
  final String id;
  final String userName;
  final String comment;
  final double rating;
  final double security;
  final double cleanliness;
  final double access;
  final double accuracy;
  final String date;
  final bool isVerified;
  final String? badge;

  const ParkingReview({
    required this.id,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.security,
    required this.cleanliness,
    required this.access,
    required this.accuracy,
    required this.date,
    this.isVerified = false,
    this.badge,
  });
}