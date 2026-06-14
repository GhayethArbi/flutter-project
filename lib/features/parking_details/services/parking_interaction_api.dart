import 'package:dio/dio.dart';

class ParkingInteractionApi {

  ParkingInteractionApi({required this.dio});
  final Dio dio;

  Future<void> logParkingView(String parkingId) async {
    await dio.post(
      '/parking-interactions/view',
      data: {
        'parkingId': parkingId,
      },
    );
  }
}
