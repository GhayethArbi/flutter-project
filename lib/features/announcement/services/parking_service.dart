import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tunipark/core/network/api_endpoints.dart';

class ParkingService {
  ParkingService({required this.dio});

  final Dio dio;

  Future<List<String>> uploadParkingPictures({
    required List<File> photos,
  }) async {
    try {
      if (photos.length < 3) {
        throw Exception('Please upload at least 3 pictures');
      }

      final formData = FormData();

      for (final photo in photos) {
        formData.files.add(
          MapEntry(
            'pictures',
            await MultipartFile.fromFile(
              photo.path,
              filename: photo.path.split('/').last,
            ),
          ),
        );
      }

      final response = await dio.post(
        ApiEndpoints.uploadParkingPictures,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      final pictures = response.data['pictures'];

      if (pictures is! List) {
        throw Exception('Invalid upload response');
      }

      return List<String>.from(pictures);
    } on DioException catch (e) {
      final data = e.response?.data;

      final message = data is Map && data['message'] != null
          ? data['message'].toString()
          : 'Image upload failed';

      throw Exception(message);
    }
  }

  Future<Map<String, dynamic>> createParking({
    required Map<String, dynamic> data,
  }) async {
    try {
      print("data  :${data.toString()}");
      final response = await dio.post(ApiEndpoints.createParking, data: data);

      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      final data = e.response?.data;
      print("response is :${e.response}");

      final message = data is Map && data['message'] != null
          ? data['message'].toString()
          : 'Parking creation failed';
      print("message  :" + message);
      throw Exception(message);
    }
  }

  Future<void> createTariff({required Map<String, dynamic> data}) async {
    try {
      await dio.post(ApiEndpoints.createTariff, data: data);
    } on DioException catch (e) {
      final responseData = e.response?.data;
      print("responseData   price :$responseData");

      final message = responseData is Map && responseData['message'] != null
          ? responseData['message'].toString()
          : 'Tariff creation failed';
      print("message  :" + message);
      throw Exception(message);
    }
  }
}
