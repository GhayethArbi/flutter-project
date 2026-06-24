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
        print(
          ' 1101 Parking ID: ${parking.id}, Tariff: ${tariff?.pricePerMonth}',
        );
        return parking.copyWith(tariff: tariff, price: tariff?.pricePerMonth);
      }),
    );
  }

  Future<TariffModel?> getTariffByParkingId(String parkingId) async {
    try {
      final response = await dio.get(ApiEndpoints.tariffByParking(parkingId));
      print(' 1101 Tariff data for parking ID: $parkingId: ${response.data.toString()}');
      if (response.data == null)
        print(' 1101 No tariff data found for parking ID: $parkingId');

      return TariffModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      print('1011 Tariff error for parking $parkingId: $e');
      return null;
    }
  }

  Future<List<ParkingPlace>> getRecommendedParkings({
    required double lat,
    required double lng,
  }) async {
    print('1000 getRecommendedParkings called');

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
          print('1000 getTariffByParkingId called');

        final tariff = await getTariffByParkingId(parking.id);

        return parking.copyWith(
          tariff: tariff,
          price: tariff?.pricePerMonth ?? parking.price,
        );
      }),
    );
  }
}
