import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:tunipark/core/config/mapbox_config.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_map/cubit/parking_map_cubit.dart';
import 'package:tunipark/features/parking_map/cubit/parking_map_state.dart';
import 'package:tunipark/features/parking_map/models/selected_place.dart';
import 'package:tunipark/features/parking_map/services/parking_map_service.dart';
import 'package:tunipark/features/parking_map/widgets/parking_bottom_actions.dart';
import 'package:tunipark/features/parking_map/widgets/parking_cards_section.dart';
import 'package:tunipark/features/parking_map/widgets/parking_list_section.dart';
import 'package:tunipark/features/parking_map/widgets/parking_map_view.dart';
import 'package:tunipark/features/parking_map/widgets/parking_search_bar.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class ParkingMapScreen extends StatefulWidget {
  final SelectedPlace place;
  final ParkingMapService parkingMapService;
  const ParkingMapScreen({
    super.key,
    required this.place,
    required this.parkingMapService,
  });

  @override
  State<ParkingMapScreen> createState() => _ParkingMapScreenState();
}

class _ParkingMapScreenState extends State<ParkingMapScreen> {
  late final PageController _pageController;
  bool _isProgrammaticPageChange = false; // 👈 new

  @override
  void initState() {
    super.initState();
    MapboxOptions.setAccessToken(MapboxConfig.publicToken);
    _pageController = PageController(viewportFraction: 0.88);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocProvider(
      create: (_) =>
          ParkingMapCubit(widget.parkingMapService)
            ..initialize(selectedPlace: widget.place),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: BlocConsumer<ParkingMapCubit, ParkingMapState>(
            listenWhen: (previous, current) =>
                previous.selectedIndex != current.selectedIndex,
            listener: (context, state) async {
              if (_pageController.hasClients && state.isMapMode) {
                final currentPage = _pageController.page?.round();
                if (currentPage == state.selectedIndex) return;

                _isProgrammaticPageChange = true;
                await _pageController.animateToPage(
                  state.selectedIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                _isProgrammaticPageChange = false;
              }
            },
            builder: (context, state) {
              if (state.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.error != null) {
                return Center(child: Text(state.error!));
              }
              return Stack(
                children: [
                  Positioned.fill(
                    child: state.isMapMode
                        ? const ParkingMapView()
                        : const ParkingListSection(),
                  ),

                  Positioned(
                    top: rs.hp(0.015),
                    left: rs.wp(0.04),
                    right: rs.wp(0.04),
                    child: ParkingSearchBar(
                      title: state.selectedPlace?.label ?? '',
                      subtitle: AppStrings.monthly,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),

                  if (state.isMapMode)
                    Positioned(
                      top: rs.hp(0.14),
                      right: rs.wp(0.04),
                      child: _MapCircleButton(
                        icon: Icons.my_location,
                        onTap: () async {
                          await context
                              .read<ParkingMapCubit>()
                              .moveToCurrentLocation(context);
                        },
                      ),
                    ),

                  if (state.isMapMode)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ParkingCardsSection(pageController: _pageController, isProgrammaticPageChange: () => _isProgrammaticPageChange,),
                          SizedBox(height: rs.hp(0.012)),
                          const ParkingBottomActions(),
                          SizedBox(
                            height:
                                MediaQuery.paddingOf(context).bottom +
                                rs.hp(0.01),
                          ),
                        ],
                      ),
                    ),

                  if (state.isListMode)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const ParkingBottomActions(),
                          SizedBox(
                            height:
                                MediaQuery.paddingOf(context).bottom +
                                rs.hp(0.01),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MapCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapCircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: rs.adaptive(mobile: 48, tablet: 52, desktop: 56),
          height: rs.adaptive(mobile: 48, tablet: 52, desktop: 56),
          child: Icon(
            icon,
            color: const Color(0xFF173B6C),
            size: rs.adaptive(mobile: 22, tablet: 24, desktop: 26),
          ),
        ),
      ),
    );
  }
}
