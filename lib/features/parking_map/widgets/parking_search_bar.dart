import 'package:flutter/material.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

class ParkingSearchBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const ParkingSearchBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Row(
      children: [
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(
                rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
              ),
              child: Container(
                height: rs.adaptive(mobile: 56, tablet: 60, desktop: 64),
                padding: EdgeInsets.symmetric(horizontal: rs.wp(0.04)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    rs.adaptive(mobile: 18, tablet: 20, desktop: 22),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: rs.adaptive(mobile: 22, tablet: 24, desktop: 26),
                      color: Colors.blueGrey,
                    ),
                    SizedBox(width: rs.wp(0.025)),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: rs.adaptive(mobile: 15, tablet: 16, desktop: 17),
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF173B6C),
                            ),
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: rs.adaptive(mobile: 12, tablet: 13, desktop: 14),
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: rs.wp(0.03)),
        Container(
          width: rs.adaptive(mobile: 52, tablet: 56, desktop: 60),
          height: rs.adaptive(mobile: 52, tablet: 56, desktop: 60),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.tune,
            color: const Color(0xFF173B6C),
            size: rs.adaptive(mobile: 22, tablet: 24, desktop: 26),
          ),
        ),
      ],
    );
  }
}