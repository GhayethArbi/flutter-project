import 'package:dio/dio.dart';
import 'package:tunipark/core/network/api_endpoints.dart';
import '../models/my_lot_model.dart';

class MyLotsService {
  MyLotsService({required this.dio});

  final Dio dio;

  /// GET /parkings  → owner's own parkings (JWT identifies owner)
  Future<List<MyLotModel>> fetchMyLots() async {
    try {
      final response = await dio.get(ApiEndpoints.parkings);
      final list = response.data as List<dynamic>;
      return list
          .map((e) => MyLotModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _parseError(e, 'Failed to load your parkings');
    }
  }

  /// GET /parkings/:id
  Future<MyLotModel> fetchLotById(String id) async {
    try {
      final response = await dio.get('${ApiEndpoints.parkings}/$id');
      return MyLotModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _parseError(e, 'Failed to load parking');
    }
  }

  /// PATCH /parkings/:id  — update parking info
  Future<MyLotModel> updateLot(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await dio.patch(
        '${ApiEndpoints.parkings}/$id',
        data: data,
      );
      
      return MyLotModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _parseError(e, 'Failed to update parking');
    }
  }

  /// PATCH /tariffs/by-parking/:id  — update tariff
  Future<void> updateTariff(
    String parkingId,
    Map<String, dynamic> data,
  ) async {
    try {
      await dio.patch(
        ApiEndpoints.tariffByParking(parkingId),
        data: data,
      );
    } on DioException catch (e) {
      throw _parseError(e, 'Failed to update tariff');
    }
  }

  /// DELETE /parkings/:id  — soft archive
  Future<void> archiveLot(String id) async {
    try {
      await dio.delete('${ApiEndpoints.parkings}/$id');
    } on DioException catch (e) {
      throw _parseError(e, 'Failed to archive parking');
    }
  }

  Exception _parseError(DioException e, String fallback) {
    final data = e.response?.data;
    final message = data is Map && data['message'] != null
        ? data['message'].toString()
        : fallback;
    return Exception(message);
  }
}