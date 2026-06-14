import 'package:dio/dio.dart';
import 'package:tunipark/core/network/auth_interceptor.dart';
import 'package:tunipark/core/storage/auth_storage_service.dart';

class DioClient {
  DioClient._();

  /// Creates a fully configured [Dio] instance.
  ///
  /// [onSessionExpired] — pass a callback to navigate to login when the
  /// refresh token is also invalid (e.g. `() => router.go('/login')`).
  static Dio create({
    required String baseUrl,
    required AuthStorageService authStorageService,
    void Function()? onSessionExpired,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(
        dio: dio,
        authStorageService: authStorageService,
        onSessionExpired: onSessionExpired,
      ),

      // Uncomment in debug builds for request/response logging.
      // if (kDebugMode)
      //   LogInterceptor(requestBody: true, responseBody: true),
    ]);

    return dio;
  }
}