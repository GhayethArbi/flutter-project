import 'package:equatable/equatable.dart';
import 'package:tunipark/features/parking_details/models/parking_detail_faq.dart';
import 'package:tunipark/features/parking_details/models/parking_feature_item.dart';
import 'package:tunipark/features/parking_details/models/parking_review.dart';
import 'package:tunipark/features/parking_map/models/parking_place.dart';

class ParkingDetailsState extends Equatable {
  final bool isLoading;
  final ParkingPlace place;
  final List<String> images;
  final int currentImageIndex;
  final List<ParkingReview> reviews;
  final bool canReview;
  final int commentsCount;
  final double averageAccess;
  final double averageSecurity;
  final double averageCleanliness;
  final double averageAccuracy;
  final List<ParkingFeatureItem> advantages;
  final List<ParkingFeatureItem> characteristics;
  final List<ParkingFeatureItem> howItWorks;
  final List<ParkingDetailFaq> faqs;

  const ParkingDetailsState({
    required this.isLoading,
    required this.place,
    required this.images,
    required this.currentImageIndex,
    required this.reviews,
    required this.canReview,
    required this.commentsCount,
    required this.averageAccess,
    required this.averageSecurity,
    required this.averageCleanliness,
    required this.averageAccuracy,
    required this.advantages,
    required this.characteristics,
    required this.howItWorks,
    required this.faqs,
  });

  factory ParkingDetailsState.initial(ParkingPlace place) {
    return ParkingDetailsState(
      isLoading: true,
      place: place,
      images: const [],
      currentImageIndex: 0,
      reviews: const [],
      canReview: false,
      commentsCount: 0,
      averageAccess: 0,
      averageSecurity: 0,
      averageCleanliness: 0,
      averageAccuracy: 0,
      advantages: const [],
      characteristics: const [],
      howItWorks: const [],
      faqs: const [],
    );
  }

  ParkingDetailsState copyWith({
    bool? isLoading,
    ParkingPlace? place,
    List<String>? images,
    int? currentImageIndex,
    List<ParkingReview>? reviews,
    bool? canReview,
    int? commentsCount,
    double? averageAccess,
    double? averageSecurity,
    double? averageCleanliness,
    double? averageAccuracy,
    List<ParkingFeatureItem>? advantages,
    List<ParkingFeatureItem>? characteristics,
    List<ParkingFeatureItem>? howItWorks,
    List<ParkingDetailFaq>? faqs,
  }) {
    return ParkingDetailsState(
      isLoading: isLoading ?? this.isLoading,
      place: place ?? this.place,
      images: images ?? this.images,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
      reviews: reviews ?? this.reviews,
      canReview: canReview ?? this.canReview,
      commentsCount: commentsCount ?? this.commentsCount,
      averageAccess: averageAccess ?? this.averageAccess,
      averageSecurity: averageSecurity ?? this.averageSecurity,
      averageCleanliness: averageCleanliness ?? this.averageCleanliness,
      averageAccuracy: averageAccuracy ?? this.averageAccuracy,
      advantages: advantages ?? this.advantages,
      characteristics: characteristics ?? this.characteristics,
      howItWorks: howItWorks ?? this.howItWorks,
      faqs: faqs ?? this.faqs,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        place,
        images,
        currentImageIndex,
        reviews,
        canReview,
        commentsCount,
        averageAccess,
        averageSecurity,
        averageCleanliness,
        averageAccuracy,
        advantages,
        characteristics,
        howItWorks,
        faqs,
      ];
}