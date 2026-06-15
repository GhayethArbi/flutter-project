import 'package:dio/dio.dart';
import 'package:tunipark/core/network/api_endpoints.dart';
import 'package:tunipark/features/parking_map/models/parking_place.dart';
import 'package:tunipark/features/parking_map/models/tariff_model.dart';

class ParkingMapService {
  ParkingMapService({required this.dio});

  final Dio dio;

  Future<List<ParkingPlace>> getParkings({String? zoneId}) async {
    final response = await dio.get(
      ApiEndpoints.parkings,
      queryParameters: {if (zoneId != null) 'zoneId': zoneId},
    );

    final data = response.data as List;

    final parkings = data
        .map((item) => ParkingPlace.fromJson(item as Map<String, dynamic>))
        .toList();

    return Future.wait(
      parkings.map((parking) async {
        final tariff = await getTariffByParkingId(parking.id);

        return parking.copyWith(
          tariff: tariff,
          price: tariff?.pricePerMonth ?? 0,
        );
      }),
    );
  }

  Future<TariffModel?> getTariffByParkingId(String parkingId) async {
    try {
      final response = await dio.get(ApiEndpoints.tariffByParking(parkingId));

      if (response.data == null) return null;

      return TariffModel.fromJson(response.data as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<List<ParkingPlace>> getRecommendedParkings({
    required double lat,
    required double lng,
  }) async {
    final response = await dio.get(
      ApiEndpoints.recommendedParkings,
      queryParameters: {'lat': lat, 'lng': lng},
    );

    final data = response.data as List;

    final parkings = data
        .map((item) => ParkingPlace.fromJson(item as Map<String, dynamic>))
        .toList();

    return Future.wait(
      parkings.map((parking) async {
        final tariff = await getTariffByParkingId(parking.id);

        return parking.copyWith(
          tariff: tariff,
          price: tariff?.pricePerMonth ?? parking.price,
        );
      }),
    );
  }
}
