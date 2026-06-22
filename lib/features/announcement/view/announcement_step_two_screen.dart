import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:http/http.dart' as http;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapbox;
import 'package:tunipark/core/config/mapbox_config.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';

import '../cubit/announcement_flow_cubit.dart';
import '../cubit/announcement_flow_state.dart';
import '../widgets/announcement_address_field.dart';
import '../widgets/announcement_fixed_bottom_actions.dart';
import '../widgets/announcement_flow_header.dart';
import '../widgets/announcement_single_action_button.dart';
import 'package:tunipark/core/constants/app_strings.dart';
import 'package:tunipark/core/constants/app_strings.dart';

class AnnouncementStepTwoScreen extends StatefulWidget {
  const AnnouncementStepTwoScreen({super.key});

  @override
  State<AnnouncementStepTwoScreen> createState() =>
      _AnnouncementStepTwoScreenState();
}

class _AnnouncementStepTwoScreenState extends State<AnnouncementStepTwoScreen> {
  late final TextEditingController _addressController;

  mapbox.MapboxMap? _mapboxMap;
  mapbox.CircleAnnotationManager? _circleAnnotationManager;

  static const double _defaultLat = 36.8065;
  static const double _defaultLng = 10.1815;

  @override
  void initState() {
    super.initState();
    mapbox.MapboxOptions.setAccessToken(MapboxConfig.publicToken);

    final state = context.read<AnnouncementFlowCubit>().state;
    _addressController = TextEditingController(text: state.address);
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _addMarker(double lat, double lng) async {
    if (_mapboxMap == null) return;

    _circleAnnotationManager ??=
        await _mapboxMap!.annotations.createCircleAnnotationManager();

    await _circleAnnotationManager!.deleteAll();

    await _circleAnnotationManager!.create(
      mapbox.CircleAnnotationOptions(
        geometry: mapbox.Point(coordinates: mapbox.Position(lng, lat)),
        circleRadius: 8.0,
        circleColor: 0xFFB7F000,
        circleStrokeColor: 0xFF173B6C,
        circleStrokeWidth: 3.0,
      ),
    );
  }

  Future<String?> _reverseGeocode({
    required double lat,
    required double lng,
  }) async {
    final uri = Uri.parse(
      'https://api.mapbox.com/search/geocode/v6/reverse'
      '?longitude=$lng'
      '&latitude=$lat'
      '&access_token=${MapboxConfig.publicToken}',
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) return null;

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List features = data['features'] ?? [];
    if (features.isEmpty) return null;

    for (final feature in features) {
      final properties =
          (feature as Map<String, dynamic>)['properties']
              as Map<String, dynamic>?;
      final fullAddress = properties?['full_address'] as String?;

      if (fullAddress != null && fullAddress.trim().isNotEmpty) {
        return '$fullAddress';
      }
    }

    return null;
  }

  Future<void> _setSelectedLocation({
    required double lat,
    required double lng,
  }) async {
    final cubit = context.read<AnnouncementFlowCubit>();

    await _addMarker(lat, lng);

    final address = await _reverseGeocode(lat: lat, lng: lng);

    if (!mounted) return;

    cubit.updateAddressAndLocation(
      address: address ?? '',
      latitude: lat,
      longitude: lng,
    );
  }

  Future<void> _goToCurrentLocation() async {
    geo.LocationPermission permission = await geo.Geolocator.checkPermission();

    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
    }

    if (permission == geo.LocationPermission.denied ||
        permission == geo.LocationPermission.deniedForever) {
      return;
    }

    final geo.Position position = await geo.Geolocator.getCurrentPosition();

    final lat = position.latitude;
    final lng = position.longitude;

    await _mapboxMap?.flyTo(
      mapbox.CameraOptions(
        center: mapbox.Point(coordinates: mapbox.Position(lng, lat)),
        zoom: 15,
      ),
      mapbox.MapAnimationOptions(duration: 1000),
    );

    await _setSelectedLocation(lat: lat, lng: lng);
  }

  @override
  Widget build(BuildContext context) {
    final rs = context.rs;

    return BlocConsumer<AnnouncementFlowCubit, AnnouncementFlowState>(
      listener: (context, state) {
        if (_addressController.text != state.address) {
          _addressController.value = TextEditingValue(
            text: state.address,
            selection: TextSelection.collapsed(offset: state.address.length),
          );
        }
      },
      builder: (context, state) {
        final lat = state.latitude ?? _defaultLat;
        final lng = state.longitude ?? _defaultLng;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state.latitude != null && state.longitude != null) {
            _addMarker(state.latitude!, state.longitude!);
          }
        });

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: rs.adaptive(
                    mobile: rs.w,
                    tablet: 700,
                    desktop: 850,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: rs.adaptive(
                          mobile: 16,
                          tablet: 24,
                          desktop: 32,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: rs.adaptive(
                              mobile: 8,
                              tablet: 12,
                              desktop: 16,
                            ),
                          ),
                          AnnouncementFlowHeader(
                            step: 2,
                            totalSteps: 6,
                            onBack: () {
                              context.read<AnnouncementFlowCubit>().goToStep(1);
                            },
                            onClose: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            height: rs.adaptive(
                              mobile: 18,
                              tablet: 24,
                              desktop: 28,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(AppStrings.ouSeSitueVotreEmplacement,
                              style: TextStyle(
                                fontSize: rs.adaptive(
                                  mobile: 20,
                                  tablet: 22,
                                  desktop: 24,
                                ),
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF222222),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: rs.adaptive(
                              mobile: 16,
                              tablet: 20,
                              desktop: 24,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: rs.adaptive(
                            mobile: 16,
                            tablet: 24,
                            desktop: 32,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            rs.adaptive(
                              mobile: 14,
                              tablet: 18,
                              desktop: 20,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: mapbox.MapWidget(
                                  key: const ValueKey('announcement_map'),
                                  cameraOptions: mapbox.CameraOptions(
                                    center: mapbox.Point(
                                      coordinates: mapbox.Position(lng, lat),
                                    ),
                                    zoom: 11,
                                  ),
                                  onMapCreated: (mapboxMap) {
                                    _mapboxMap = mapboxMap;
                                  },
                                  onTapListener: (tapContext) async {
                                    final point = tapContext.point.coordinates;

                                    final tappedLat = point.lat.toDouble();
                                    final tappedLng = point.lng.toDouble();

                                    await _setSelectedLocation(
                                      lat: tappedLat,
                                      lng: tappedLng,
                                    );

                                    context
                                        .read<AnnouncementFlowCubit>()
                                        .updateLocation(
                                          latitude: tappedLat,
                                          longitude: tappedLng,
                                        );

                                    await _addMarker(tappedLat, tappedLng);
                                  },
                                ),
                              ),
                              Positioned(
                                top: 16,
                                left: 16,
                                right: 16,
                                child: AnnouncementAddressField(
                                  controller: _addressController,
                                  onChanged: (value) {
                                    context
                                        .read<AnnouncementFlowCubit>()
                                        .updateAddress(value);
                                  },
                                ),
                              ),
                              Positioned(
                                right: 16,
                                bottom: 16,
                                child: Material(
                                  color: Colors.white,
                                  shape: const CircleBorder(),
                                  elevation: 4,
                                  child: InkWell(
                                    onTap: _goToCurrentLocation,
                                    customBorder: const CircleBorder(),
                                    child: const SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Icon(
                                        Icons.my_location,
                                        color: Color(0xFF173B6C),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    AnnouncementFixedBottomActions(
                      child: Center(
                        child: AnnouncementSingleActionButton(
                          text: AppStrings.suivant,
                          onPressed: state.address.trim().isEmpty
                              ? null
                              : () {
                                  context
                                      .read<AnnouncementFlowCubit>()
                                      .goToStep(3);
                                },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}