import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:tunipark/core/utils/responsive_extension.dart';
import 'package:tunipark/features/parking_map/cubit/parking_map_cubit.dart';
import 'package:tunipark/features/parking_map/cubit/parking_map_state.dart';

class ParkingMapView extends StatefulWidget {
  const ParkingMapView({super.key});

  @override
  State<ParkingMapView> createState() => _ParkingMapViewState();
}

class _ParkingMapViewState extends State<ParkingMapView> {
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;

  final Map<int, PointAnnotation> _annotationsByIndex = {};
  final Map<int, Uint8List> _normalMarkerBytesByIndex = {};
  final Map<int, Uint8List> _selectedMarkerBytesByIndex = {};
  bool _styleLoaded = false;
  bool _markersReady = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParkingMapCubit, ParkingMapState>(
      listenWhen: (previous, current) =>
          previous.selectedIndex != current.selectedIndex ||
          previous.parkings != current.parkings,
      listener: (context, state) async {
        if (!_markersReady) return;
        await _renderMarkers(state);
      },
      builder: (context, state) {
        return MapWidget(
          key: const ValueKey('parking_map'),
          styleUri: MapboxStyles.MAPBOX_STREETS,
          cameraOptions: state.selectedPlace == null
              ? null
              : CameraOptions(
                  center: Point(
                    coordinates: Position(
                      state.selectedPlace!.longitude,
                      state.selectedPlace!.latitude,
                    ),
                  ),
                  zoom: 14,
                ),
          onMapCreated: (mapboxMap) async {
            _mapboxMap = mapboxMap;
            await context.read<ParkingMapCubit>().onMapCreated(mapboxMap);
          },
          onStyleLoadedListener: (_) async {
            _styleLoaded = true;
            await _setupMarkers();
          },
        );
      },
    );
  }

  Future<void> _setupMarkers() async {
    if (_mapboxMap == null || !_styleLoaded) return;

    final state = context.read<ParkingMapCubit>().state;
    if (state.parkings.isEmpty) return;

    final rs = context.rs;

    final markerWidth = rs
        .adaptive(mobile: 70, tablet: 76, desktop: 82)
        .toInt();

    final markerHeight = rs
        .adaptive(mobile: 36, tablet: 40, desktop: 44)
        .toInt();

    final markerRadius = rs.adaptive(mobile: 18, tablet: 20, desktop: 22);

    _normalMarkerBytesByIndex.clear();
    _selectedMarkerBytesByIndex.clear();

    for (int i = 0; i < state.parkings.length; i++) {
      final parking = state.parkings[i];

      _normalMarkerBytesByIndex[i] = await _createMarkerBytes(
        context: context,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
        logicalWidth: markerWidth,
        logicalHeight: markerHeight,
        radius: markerRadius,
        price: parking.price,
      );

      _selectedMarkerBytesByIndex[i] = await _createMarkerBytes(
        context: context,
        backgroundColor: const Color(0xFF173B6C),
        textColor: Colors.white,
        logicalWidth: markerWidth,
        logicalHeight: markerHeight,
        radius: markerRadius,
        price: parking.price,
      );
    }

    _pointAnnotationManager ??= await _mapboxMap!.annotations
        .createPointAnnotationManager();

    await _pointAnnotationManager!.deleteAll();
    _annotationsByIndex.clear();

    _pointAnnotationManager!.addOnPointAnnotationClickListener(
      _ParkingMarkerClickListener(
        onClicked: (annotation) async {
          final entry = _annotationsByIndex.entries
              .where((e) => e.value.id == annotation.id)
              .firstOrNull;

          if (entry != null) {
            await context.read<ParkingMapCubit>().selectParkingFromMarker(
              entry.key,
            );
          }
          return true;
        },
      ),
    );

    await _renderMarkers(state);
    _markersReady = true;
  }

  Future<void> _renderMarkers(ParkingMapState state) async {
    if (_pointAnnotationManager == null) return;

    await _pointAnnotationManager!.deleteAll();
    _annotationsByIndex.clear();

    for (int i = 0; i < state.parkings.length; i++) {
      final parking = state.parkings[i];

      final annotation = await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(
            coordinates: Position(parking.longitude, parking.latitude),
          ),
          image: i == state.selectedIndex
              ? _selectedMarkerBytesByIndex[i]!
              : _normalMarkerBytesByIndex[i]!,
          iconAnchor: IconAnchor.BOTTOM,
        ),
      );

      _annotationsByIndex[i] = annotation;
    }
  }

  Future<Uint8List> _createMarkerBytes({
    required BuildContext context,
    required Color backgroundColor,
    required Color textColor,
    required int logicalWidth,
    required int logicalHeight,
    required double radius,
    required double price,
  }) async {
    final dpr = MediaQuery.of(context).devicePixelRatio;

    final pixelWidth = (logicalWidth * dpr).round();
    final pixelHeight = (logicalHeight * dpr).round();

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    canvas.scale(dpr, dpr);

    final rect = Rect.fromLTWH(
      0,
      0,
      logicalWidth.toDouble(),
      logicalHeight.toDouble(),
    );

    final paint = Paint()..color = backgroundColor;
    final shadowPaint = Paint()
      ..color = Colors.black.withAlpha(35)
      ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 12);

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    canvas.drawRRect(rrect.shift(const Offset(0, 4)), shadowPaint);
    canvas.drawRRect(rrect, paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: '${price.toInt()} DT',
        style: TextStyle(
          color: textColor,
          fontSize: context.rs.adaptive(mobile: 13, tablet: 14, desktop: 15),
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();

    final textOffset = Offset(
      (logicalWidth - textPainter.width) / 2,
      (logicalHeight - textPainter.height) / 2,
    );

    textPainter.paint(canvas, textOffset);

    final picture = recorder.endRecording();
    final image = await picture.toImage(pixelWidth, pixelHeight);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  @override
  void dispose() {
    _pointAnnotationManager?.deleteAll();
    super.dispose();
  }
}

class _ParkingMarkerClickListener extends OnPointAnnotationClickListener {
  _ParkingMarkerClickListener({required this.onClicked});

  final Future<bool> Function(PointAnnotation annotation) onClicked;

  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    onClicked(annotation);
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
