import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_map/cubit/parking_map_cubit.dart';
import 'package:tunipark/features/parking_map/cubit/parking_map_state.dart';

class ParkingListSection extends StatelessWidget {
  const ParkingListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocBuilder<ParkingMapCubit, ParkingMapState>(
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsets.fromLTRB(
            rs.wp(0.04),
            rs.hp(0.14),
            rs.wp(0.04),
            rs.hp(0.16),
          ),
          itemCount: state.parkings.length,
          separatorBuilder: (_, __) => SizedBox(height: rs.hp(0.02)),
          itemBuilder: (context, index) {
            final parking = state.parkings[index];

            return GestureDetector(
              onTap: () {
                context.read<ParkingMapCubit>().selectParkingFromList(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    rs.adaptive(mobile: 20, tablet: 24, desktop: 28),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          rs.adaptive(mobile: 20, tablet: 24, desktop: 28),
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          parking.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade200,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                size: rs.adaptive(mobile: 30, tablet: 34, desktop: 38),
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(rs.wp(0.04)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              SizedBox(width: rs.wp(0.01)),
                              Text(
                                parking.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: rs.adaptive(
                                    mobile: 13,
                                    tablet: 14,
                                    desktop: 15,
                                  ),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: rs.hp(0.01)),
                          Text(
                            parking.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: rs.adaptive(
                                mobile: 18,
                                tablet: 20,
                                desktop: 22,
                              ),
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF173B6C),
                            ),
                          ),
                          SizedBox(height: rs.hp(0.006)),
                          Text(
                            parking.address,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: rs.adaptive(
                                mobile: 13,
                                tablet: 14,
                                desktop: 15,
                              ),
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: rs.hp(0.01)),
                          Row(
                            children: [
                              Icon(
                                Icons.local_parking_outlined,
                                size: 16,
                                color: Colors.grey.shade600,
                              ),
                              SizedBox(width: rs.wp(0.01)),
                              Text(
                                '${parking.spots} spots',
                                style: TextStyle(
                                  fontSize: rs.adaptive(
                                    mobile: 13,
                                    tablet: 14,
                                    desktop: 15,
                                  ),
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: rs.hp(0.012)),
                          Text(
                            '${parking.price.toStringAsFixed(0)} DT / mois',
                            style: TextStyle(
                              fontSize: rs.adaptive(
                                mobile: 16,
                                tablet: 17,
                                desktop: 18,
                              ),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF173B6C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}