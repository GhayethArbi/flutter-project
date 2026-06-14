import 'package:flutter/material.dart';
import 'package:tunipark/features/parking_details/models/parking_review.dart';
import 'package:tunipark/features/parking_map/models/parking_place.dart';

class ParkingDetailsStaticData {
  static List<String> images(ParkingPlace place) {
    final image = place.imageUrl.isNotEmpty
        ? place.imageUrl
        : 'https://picsum.photos/600/400';

    return [image, image, image];
  }

  static const List<ParkingReview> reviews = [
    ParkingReview(
      id: '1',
      userName: 'Julien',
      comment:
          'Très pratique, accès facile et parking globalement sécurisé.',
      rating: 5,
      security: 4.3,
      cleanliness: 3.8,
      access: 4.2,
      accuracy: 4.2,
      date: 'March 2026',
      isVerified: true,
    ),
    ParkingReview(
      id: '2',
      userName: 'Emilie',
      comment: 'Parking sécurisé et facile à trouver.',
      rating: 4,
      security: 4.0,
      cleanliness: 3.8,
      access: 4.2,
      accuracy: 4.1,
      date: 'October 2025',
      isVerified: true,
      badge: 'Subscriber for 7 months',
    ),
  ];

  static const List<Map<String, dynamic>> advantages = [
    {
      'icon': Icons.bookmark_border,
      'title': 'Assigned spot',
      'showInfo': true,
    },
    {
      'icon': Icons.thumb_up_alt_outlined,
      'title': 'Committed subscribers',
      'showInfo': true,
    },
    {
      'icon': Icons.arrow_downward,
      'title': 'Underground parking',
      'showInfo': false,
    },
  ];

  static const List<Map<String, dynamic>> characteristics = [
    {
      'icon': Icons.height,
      'title': 'Maximum height : 1,9m',
      'showInfo': false,
    },
  ];

  static const List<Map<String, dynamic>> howItWorks = [
    {
      'icon': Icons.phone_iphone_outlined,
      'title': 'Opening through the app',
      'showInfo': true,
    },
    {
      'icon': Icons.support_agent,
      'title': '7/7 customer service',
      'showInfo': false,
    },
    {
      'icon': Icons.card_giftcard_outlined,
      'title': '2-days trial',
      'showInfo': false,
    },
    {
      'icon': Icons.lock_outline,
      'title': 'No engagement',
      'showInfo': false,
    },
    {
      'icon': Icons.money_off_csred_outlined,
      'title': 'No deposit',
      'showInfo': false,
    },
    {
      'icon': Icons.vpn_key_outlined,
      'title': 'Access badge option available',
      'showInfo': false,
    },
    {
      'icon': Icons.credit_card,
      'title': 'Secure payments',
      'showInfo': false,
    },
  ];

  static const List<Map<String, String>> faqs = [
    {
      'question': 'How does subscribing to a parking work?',
      'answer':
          'You choose your spot, confirm your subscription, and access the parking using the app.',
    },
    {
      'question': 'Can I visit before subscribing?',
      'answer':
          'For now this is static demo text. Later you can replace it with your real business rule.',
    },
    {
      'question': 'How long is the parking available?',
      'answer':
          'The parking remains available according to the subscription conditions shown on the page.',
    },
  ];

  static const int commentsCount = 49;
  static const double averageAccess = 4.2;
  static const double averageSecurity = 4.3;
  static const double averageCleanliness = 3.8;
  static const double averageAccuracy = 4.2;

  static const bool canReview = false;
}