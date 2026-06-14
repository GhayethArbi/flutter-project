import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tunipark/core/config/mapbox_config.dart';

import '../../parking_map/models/selected_place.dart';

class LocationSearchService {
  static const String _baseUrl = 'https://api.mapbox.com/search/geocode/v6';

  Future<List<SelectedPlace>> searchPlaces({
    required String query,
    String language = 'fr',
    int limit = 6,
    String? proximity,
    String? countryCode,
  }) async {
    final uri = Uri.parse('$_baseUrl/forward').replace(
      queryParameters: {
        'q': query,
        'access_token': MapboxConfig.publicToken,
        'autocomplete': 'true',
        'language': language,
        'limit': '$limit',
        'types': 'address,street,place,locality,neighborhood,region,country',
        if (proximity != null) 'proximity': proximity,
        if (countryCode != null) 'country': countryCode,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Erreur de recherche de lieu.');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final List features = (data['features'] as List?) ?? [];

    return features
        .map((feature) {
          final properties = feature['properties'] as Map<String, dynamic>? ?? {};
          final coordinates =
              properties['coordinates'] as Map<String, dynamic>? ?? {};
          final geometry = feature['geometry'] as Map<String, dynamic>? ?? {};
          final geometryCoords = geometry['coordinates'] as List?;

          final longitude = (coordinates['longitude'] ??
                  (geometryCoords != null && geometryCoords.isNotEmpty
                      ? geometryCoords[0]
                      : null))
              ?.toDouble();

          final latitude = (coordinates['latitude'] ??
                  (geometryCoords != null && geometryCoords.length > 1
                      ? geometryCoords[1]
                      : null))
              ?.toDouble();

          if (longitude == null || latitude == null) {
            return null;
          }

          final fullAddress = properties['full_address']?.toString();
          final name = properties['name']?.toString();
          final placeFormatted = properties['place_formatted']?.toString();

          final label = (fullAddress != null && fullAddress.trim().isNotEmpty)
              ? fullAddress
              : [
                  if (name != null && name.trim().isNotEmpty) name,
                  if (placeFormatted != null && placeFormatted.trim().isNotEmpty)
                    placeFormatted,
                ].join(', ');

          return SelectedPlace(
            id: feature['id']?.toString() ??
                properties['mapbox_id']?.toString() ??
                '$latitude,$longitude',
            label: label,
            latitude: latitude,
            longitude: longitude,
          );
        })
        .whereType<SelectedPlace>()
        .toList();
  }
Future<SelectedPlace> reverseGeocode({
  required double latitude,
  required double longitude,
  String language = 'fr',
}) async {
  final uri = Uri.parse('$_baseUrl/reverse').replace(
    queryParameters: {
      'longitude': '$longitude',
      'latitude': '$latitude',
      'access_token': MapboxConfig.publicToken,
      'language': language,
      'types': 'address,street,place,locality,neighborhood,region,country',
    },
  );

  final response = await http.get(uri);

  if (response.statusCode != 200) {
    throw Exception('Erreur lors de la récupération de la position actuelle.');
  }

  final Map<String, dynamic> data = jsonDecode(response.body);
  final List features = (data['features'] as List?) ?? [];

  if (features.isEmpty) {
    throw Exception('Aucun lieu trouvé pour votre position actuelle.');
  }

  final feature = features.first as Map<String, dynamic>;
  final properties = feature['properties'] as Map<String, dynamic>? ?? {};
  final coordinates =
      properties['coordinates'] as Map<String, dynamic>? ?? {};
  final geometry = feature['geometry'] as Map<String, dynamic>? ?? {};
  final geometryCoords = geometry['coordinates'] as List?;

  final resolvedLongitude = (coordinates['longitude'] ??
          (geometryCoords != null && geometryCoords.isNotEmpty
              ? geometryCoords[0]
              : longitude))
      .toDouble();

  final resolvedLatitude = (coordinates['latitude'] ??
          (geometryCoords != null && geometryCoords.length > 1
              ? geometryCoords[1]
              : latitude))
      .toDouble();

  final fullAddress = properties['full_address']?.toString();
  final name = properties['name']?.toString();
  final placeFormatted = properties['place_formatted']?.toString();

  final label = (fullAddress != null && fullAddress.trim().isNotEmpty)
      ? fullAddress
      : [
          if (name != null && name.trim().isNotEmpty) name,
          if (placeFormatted != null && placeFormatted.trim().isNotEmpty)
            placeFormatted,
        ].join(', ');

  return SelectedPlace(
    id: feature['id']?.toString() ??
        properties['mapbox_id']?.toString() ??
        '$resolvedLatitude,$resolvedLongitude',
    label: label.isEmpty ? 'Position actuelle' : label,
    latitude: resolvedLatitude,
    longitude: resolvedLongitude,
  );
}}