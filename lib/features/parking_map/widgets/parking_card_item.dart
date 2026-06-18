import 'package:flutter/material.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_map/models/parking_place.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class ParkingCardItem extends StatelessWidget {
  final ParkingPlace parking;
  final bool isSelected;
  final bool isBestRecommendation;

  const ParkingCardItem({
    super.key,
    required this.parking,
    required this.isSelected,
    this.isBestRecommendation = false,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;
    final ai = parking.ai;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.parkingDetails,
          arguments: parking,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: rs.adaptive(mobile: 340, tablet: 390, desktop: 430),
        height: rs.adaptive(mobile: 215, tablet: 230, desktop: 245),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
          ),
          border: Border.all(
            color: isSelected ? AppColors.colorBtn : Colors.transparent,
            width: 1.2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: rs.adaptive(mobile: 112, tablet: 125, desktop: 140),
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(
                    rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
                  ),
                ),
                child: Image.network(
                  parking.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(
                  rs.adaptive(mobile: 10, tablet: 12, desktop: 14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isBestRecommendation) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF4D6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(AppStrings.bestMatch,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF9A6B00),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          parking.rating.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: rs.adaptive(
                              mobile: 12,
                              tablet: 13,
                              desktop: 14,
                            ),
                            color: const Color(0xFF173B6C),
                          ),
                        ),
                        const Spacer(),
                        if (ai != null) _AiMatchBadge(ai: ai),
                      ],
                    ),
                    SizedBox(height: rs.hp(0.005)),
                    Text(
                      parking.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: rs.adaptive(
                          mobile: 14,
                          tablet: 15,
                          desktop: 16,
                        ),
                        color: const Color(0xFF173B6C),
                      ),
                    ),
                    SizedBox(height: rs.hp(0.003)),
                    Text(
                      parking.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: rs.adaptive(
                          mobile: 12,
                          tablet: 13,
                          desktop: 14,
                        ),
                      ),
                    ),
                    if (ai != null) ...[
                      SizedBox(height: rs.hp(0.006)),
                      _AiReasonLine(
                        icon: Icons.near_me_outlined,
                        text: '${ai.distanceLabel} • ${ai.availabilityLabel}',
                      ),
                    ],
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.local_parking,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${parking.spots} places',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: rs.adaptive(
                                mobile: 12,
                                tablet: 13,
                                desktop: 14,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          '${parking.price.toInt()} DT/mois',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: rs.adaptive(
                              mobile: 16,
                              tablet: 18,
                              desktop: 20,
                            ),
                            color: const Color(0xFF173B6C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AiMatchBadge extends StatelessWidget {
  final ParkingAiInfo ai;

  const _AiMatchBadge({required this.ai});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF7F1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF1D9E75).withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, size: 13, color: Color(0xFF1D9E75)),
          const SizedBox(width: 4),
          Text(
            'AI Match ${ai.matchPercent}%',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1D9E75),
            ),
          ),
        ],
      ),
    );
  }
}

class _AiReasonLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _AiReasonLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF1D9E75)),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4D5B6A),
            ),
          ),
        ),
      ],
    );
  }
}
