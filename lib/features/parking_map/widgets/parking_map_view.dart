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
  final Map<String, Uint8List> _normalMarkerBytesByPrice = {};
  final Map<String, Uint8List> _selectedMarkerBytesByPrice = {};
  final Map<String, int> _indexByAnnotationId = {};
  bool _styleLoaded = false;
  bool _markersReady = false;
  int? _lastSelectedIndex;
  bool _listenerAdded = false;
  bool _isRenderingMarkers = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParkingMapCubit, ParkingMapState>(
      listenWhen: (previous, current) =>
          previous.selectedIndex != current.selectedIndex ||
          previous.parkings != current.parkings,
      listener: (context, state) async {
        if (!_markersReady) return;

        await _enqueue(() async {
          final parkingsChanged =
              state.parkings.length != _annotationsByIndex.length;

          if (parkingsChanged) {
            await _renderMarkers(state);
          } else {
            await _updateSelectedMarkers(state);
          }

          _lastSelectedIndex = state.selectedIndex;
        });
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

  Future<void> _updateSelectedMarkers(ParkingMapState state) async {
    if (_pointAnnotationManager == null) return;

    final oldIndex = _lastSelectedIndex;
    final newIndex = state.selectedIndex;
    if (oldIndex == newIndex) return;

    if (oldIndex != null && oldIndex >= 0 && oldIndex < state.parkings.length) {
      await _updateMarkerImage(state, oldIndex, selected: false);
    }
    if (newIndex != null && newIndex >= 0 && newIndex < state.parkings.length) {
      await _updateMarkerImage(state, newIndex, selected: true);
    }

    _lastSelectedIndex = newIndex;
  }

  Future<void> _updateMarkerImage(
    ParkingMapState state,
    int index, {
    required bool selected,
  }) async {
    final annotation = _annotationsByIndex[index];
    if (annotation == null) return;

    final parking = state.parkings[index];
    final priceKey = parking.price.toInt().toString();
    final image = selected
        ? _selectedMarkerBytesByPrice[priceKey]
        : _normalMarkerBytesByPrice[priceKey];
    if (image == null) return;

    annotation.image = image;
    await _pointAnnotationManager!.update(annotation);
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

    _normalMarkerBytesByPrice.clear();
    _selectedMarkerBytesByPrice.clear();

    final uniquePrices = state.parkings
        .map((parking) => parking.price.toInt())
        .toSet();

    for (final price in uniquePrices) {
      final key = price.toString();

      _normalMarkerBytesByPrice[key] = await _createMarkerBytes(
        context: context,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
        logicalWidth: markerWidth,
        logicalHeight: markerHeight,
        radius: markerRadius,
        price: price.toDouble(),
      );

      _selectedMarkerBytesByPrice[key] = await _createMarkerBytes(
        context: context,
        backgroundColor: const Color(0xFF173B6C),
        textColor: Colors.white,
        logicalWidth: markerWidth,
        logicalHeight: markerHeight,
        radius: markerRadius,
        price: price.toDouble(),
      );
    }
    _pointAnnotationManager ??= await _mapboxMap!.annotations
        .createPointAnnotationManager();

    await _pointAnnotationManager!.deleteAll();
    _annotationsByIndex.clear();

    if (!_listenerAdded) {
      _pointAnnotationManager!.addOnPointAnnotationClickListener(
        _ParkingMarkerClickListener(
          onClicked: (annotation) async {
            if (_isRenderingMarkers) return true;

            final index = _indexByAnnotationId[annotation.id];
            debugPrint(
              'Tapped annotation ${annotation.id} -> resolved index: $index',
            );

            if (index != null && mounted) {
              await context.read<ParkingMapCubit>().selectParkingFromMarker(
                index,
              );
            }

            return true;
          },
        ),
      );

      _listenerAdded = true;
    }
    await _renderMarkers(state);
    _markersReady = true;
  }

  Future<void> _pendingUpdate = Future.value();

  Future<void> _enqueue(Future<void> Function() task) {
    final result = _pendingUpdate.then((_) => task());
    _pendingUpdate = result.catchError(
      (_) {},
    ); // don't let one failure jam the queue
    return result;
  }

  Future<void> _renderMarkers(ParkingMapState state) async {
    if (_pointAnnotationManager == null) return;
    _isRenderingMarkers = true;

    await _pointAnnotationManager!.deleteAll();
    _annotationsByIndex.clear();
    _indexByAnnotationId.clear(); // ✅ add this

    for (int i = 0; i < state.parkings.length; i++) {
      final parking = state.parkings[i];

      final priceKey = parking.price.toInt().toString();

      final annotation = await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(
            coordinates: Position(parking.longitude, parking.latitude),
          ),
          image: i == state.selectedIndex
              ? _selectedMarkerBytesByPrice[priceKey]!
              : _normalMarkerBytesByPrice[priceKey]!,
          iconAnchor: IconAnchor.BOTTOM,
        ),
      );

      _annotationsByIndex[i] = annotation;
      _indexByAnnotationId[annotation.id] = i;
    }
    _lastSelectedIndex = state.selectedIndex;
    _isRenderingMarkers = false;
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
    // final shadowPaint = Paint()
    //   ..color = Colors.black.withAlpha(35)
    //   ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 12);

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    //canvas.drawRRect(rrect.shift(const Offset(0, 4)), shadowPaint);
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
