import 'package:flutter/material.dart';
import 'package:tunipark/core/router/app_routes.dart';
import 'package:tunipark/core/theme/app_colors.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_map/models/parking_place.dart';

class ParkingCardItem extends StatelessWidget {
  final ParkingPlace parking;
  final bool isSelected;

  const ParkingCardItem({
    super.key,
    required this.parking,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

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
        width: rs.adaptive(mobile: 330, tablet: 380, desktop: 420),
        height: rs.adaptive(mobile: 150, tablet: 165, desktop: 180),
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
              width: rs.adaptive(mobile: 105, tablet: 120, desktop: 135),
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
                    Row(
                      mainAxisSize: MainAxisSize.min,
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
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.local_parking,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
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
                      ],
                    ),
                    SizedBox(height: rs.hp(0.004)),
                    Text(
                      '${parking.price.toInt()} DT/mois',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: rs.adaptive(
                          mobile: 20,
                          tablet: 22,
                          desktop: 24,
                        ),
                        color: const Color(0xFF173B6C),
                      ),
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
