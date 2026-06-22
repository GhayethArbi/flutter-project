import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tunipark/core/helpers/vehicle_helper.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_details/widgets/bottom_bar.dart';
import 'package:tunipark/features/parking_details/widgets/hero_image.dart';
import 'package:tunipark/features/parking_details/widgets/parking_actions.dart';
import 'package:tunipark/features/parking_details/widgets/parking_characteristics.dart';
import 'package:tunipark/features/parking_details/widgets/parking_compatibility.dart';
import 'package:tunipark/features/parking_details/widgets/parking_dimensions.dart';
import 'package:tunipark/features/parking_details/widgets/parking_extra_info.dart';
import 'package:tunipark/features/parking_map/models/parking_place.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class ParkingDetailsScreen extends StatefulWidget {
  final ParkingPlace parking;

  const ParkingDetailsScreen({super.key, required this.parking});

  @override
  State<ParkingDetailsScreen> createState() => _ParkingDetailsScreenState();
}

class _ParkingDetailsScreenState extends State<ParkingDetailsScreen> {
  static const _primary = Color(0xFF173B6C);
  static const _amber = Colors.amber;

  final _commentController = TextEditingController();

  static const List<Map<String, dynamic>> _reviews = [
    //todo: must be dynamic
    {
      'initials': 'ML',
      'name': 'Marie L.',
      'date': 'March 2026 · Verified renter',
      'global': 4,
      'security': 5,
      'cleanliness': 3,
      'access': 4,
      'comment':
          'Very easy to access, the gate opens with no issue. A bit dusty inside but nothing serious. Would rent again.',
      'avatarColor': Color(0xFF1D9E75),
    },
    {
      'initials': 'JB',
      'name': 'Jean B.',
      'date': 'February 2026 · Verified renter',
      'global': 5,
      'security': 5,
      'cleanliness': 4,
      'access': 5,
      'comment':
          'Perfect spot, matches the description exactly. The location is ideal for the city center. Highly recommended.',
      'avatarColor': Color(0xFF534AB7),
    },
    {
      'initials': 'SC',
      'name': 'Sophie C.',
      'date': 'January 2026 · Verified renter',
      'global': 4,
      'security': 4,
      'cleanliness': 4,
      'access': 4,
      'comment':
          'Good parking, well located. The app opening works perfectly every time.',
      'avatarColor': Color(0xFFB5173A),
    },
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final p = widget.parking;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: Padding(
          padding: EdgeInsets.only(
            left: rs.adaptive(mobile: 12, tablet: 16, desktop: 20),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.black38,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: rs.adaptive(mobile: 16, tablet: 18, desktop: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: rs.adaptive(mobile: 12, tablet: 16, desktop: 20),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.black38,
              child: IconButton(
                icon: Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                  size: rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
                ),
                onPressed: () {
                  //todo : share feature
                },
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: HeroImage(imageUrl: p.imageUrl, rs: rs),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: rs.adaptive(
                      mobile: 16,
                      tablet: 24,
                      desktop: 32,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: rs.hp(0.02)),

                      Text(
                        p.title,
                        style: TextStyle(
                          fontSize: rs.adaptive(
                            mobile: 22,
                            tablet: 26,
                            desktop: 30,
                          ),
                          fontWeight: FontWeight.w700,
                          color: _primary,
                        ),
                      ),

                      SizedBox(height: rs.hp(0.008)),

                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: _amber,
                            size: rs.adaptive(
                              mobile: 18,
                              tablet: 20,
                              desktop: 22,
                            ),
                          ),
                          SizedBox(width: rs.wp(0.01)),
                          Text(
                            p.rating.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: rs.adaptive(
                                mobile: 14,
                                tablet: 15,
                                desktop: 16,
                              ),
                              color: _primary,
                            ),
                          ),
                          SizedBox(width: rs.wp(0.01)),
                          GestureDetector(
                            onTap: () {
                              if (_reviewsKey.currentContext != null) {
                                Scrollable.ensureVisible(
                                  _reviewsKey.currentContext!,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: Text(
                              '(${_reviews.length * 16} avis)',
                              style: TextStyle(
                                fontSize: rs.adaptive(
                                  mobile: 13,
                                  tablet: 14,
                                  desktop: 15,
                                ),
                                color: _primary,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: rs.hp(0.006)),

                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: _primary,
                            size: rs.adaptive(
                              mobile: 16,
                              tablet: 18,
                              desktop: 20,
                            ),
                          ),
                          SizedBox(width: rs.wp(0.01)),
                          Expanded(
                            child: Text(
                              p.address,
                              style: TextStyle(
                                fontSize: rs.adaptive(
                                  mobile: 13,
                                  tablet: 14,
                                  desktop: 15,
                                ),
                                color: _primary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      //SizedBox(height: rs.hp(0.018)),
                      //FeaturesGrid(rs: rs),
                      SizedBox(
                        height: rs.adaptive(
                          mobile: 20,
                          tablet: 24,
                          desktop: 28,
                        ),
                      ),
                      if (p.ai != null) ...[
                        _WhyRecommendedSection(
                          ai: p.ai!,
                          availablePlaces: p.spots,
                        ),
                        SizedBox(
                          height: rs.adaptive(
                            mobile: 20,
                            tablet: 24,
                            desktop: 28,
                          ),
                        ),
                      ],
                      ParkingCharacteristics(
                        characteristics: widget.parking.characteristics,
                      ),

                      SizedBox(
                        height: rs.adaptive(
                          mobile: 20,
                          tablet: 24,
                          desktop: 28,
                        ),
                      ),
                      ParkingDimensions(),

                      SizedBox(
                        height: rs.adaptive(
                          mobile: 20,
                          tablet: 24,
                          desktop: 28,
                        ),
                      ),
                      ParkingCompatibility(
                        vehicles: buildVehicleCompatibility(p.vehicleTypes),
                      ),

                      SizedBox(
                        height: rs.adaptive(
                          mobile: 20,
                          tablet: 24,
                          desktop: 28,
                        ),
                      ),
                      ParkingActions(),

                      SizedBox(
                        height: rs.adaptive(
                          mobile: 20,
                          tablet: 24,
                          desktop: 28,
                        ),
                      ),
                      ParkingExtraInfo(),

                      SizedBox(
                        height: rs.adaptive(
                          mobile: 140,
                          tablet: 150,
                          desktop: 160,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomBar(parking: widget.parking, rs: rs),
          ),
        ],
      ),
    );
  }

  final GlobalKey _reviewsKey = GlobalKey();
}

class _WhyRecommendedSection extends StatelessWidget {
  final ParkingAiInfo ai;
  final int availablePlaces;

  const _WhyRecommendedSection({
    required this.ai,
    required this.availablePlaces,
  });

  String get _distanceText {
    if (ai.distanceKm <= 0) return 'near your destination';
    return '${ai.distanceKm.toStringAsFixed(1)} km away';
  }

  String get _rankText {
    if (ai.rank != null) return 'ranked #${ai.rank} by AI';
    return 'highly ranked by AI';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4FBF8),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF1D9E75).withValues(alpha: 0.20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Color(0xFF1D9E75)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(AppStrings.aiSummary,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: Color(0xFF173B6C),
                  ),
                ),
              ),
              Text(
                '${ai.matchPercent}%',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Color(0xFF1D9E75),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            'This parking is $_distanceText, has $availablePlaces available places, and is $_rankText.',
            style: const TextStyle(
              fontSize: 14,
              height: 1.45,
              fontWeight: FontWeight.w700,
              color: Color(0xFF173B6C),
            ),
          ),

          const SizedBox(height: 14),

          _AiExplanationRow(
            icon: Icons.near_me_outlined,
            title: AppStrings.distance,
            value: ai.distanceLabel,
          ),
          _AiExplanationRow(
            icon: Icons.local_parking,
            title: AppStrings.availability,
            value: ai.availabilityLabel,
          ),
          _AiExplanationRow(
            icon: Icons.trending_up,
            title: AppStrings.behavior,
            value: ai.conversionRate > 0
                ? 'Drivers often choose this parking'
                : 'New parking with limited history',
          ),
        ],
      ),
    );
  }
}

class _AiExplanationRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _AiExplanationRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF1D9E75)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$title: $value',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4D5B6A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
