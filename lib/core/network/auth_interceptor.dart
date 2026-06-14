import 'dart:async';

import 'package:dio/dio.dart';
import 'package:tunipark/core/network/api_endpoints.dart';
import 'package:tunipark/core/storage/auth_storage_service.dart';


class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.dio,
    required this.authStorageService,
    this.onSessionExpired,
  });

  final Dio dio;
  final AuthStorageService authStorageService;

  final void Function()? onSessionExpired;

  Completer<String>? _refreshCompleter;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await authStorageService.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

 @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final isUnauthorized = err.response?.statusCode == 401;
    final isRefreshEndpoint = err.requestOptions.path.contains(ApiEndpoints.refresh);

    if (!isUnauthorized || isRefreshEndpoint) return handler.next(err);

    // Another refresh is already in progress — wait for it
    if (_refreshCompleter != null) {
      try {
        final newToken = await _refreshCompleter!.future;
        final retryOptions = err.requestOptions;
        retryOptions.headers['Authorization'] = 'Bearer $newToken';
        final retryResponse = await dio.fetch(retryOptions);
        return handler.resolve(retryResponse);
      } catch (_) {
        return handler.next(err);
      }
    }

    _refreshCompleter = Completer<String>();

    try {
      final refreshToken = await authStorageService.getRefreshToken();
      if (refreshToken == null) {
        _refreshCompleter!.completeError('no_refresh_token');
        await _onExpired(handler, err);
        return;
      }

      final refreshDio = Dio(BaseOptions(baseUrl: dio.options.baseUrl));
      final refreshResponse = await refreshDio.post(
        ApiEndpoints.refresh,
        data: {'refreshToken': refreshToken},
      );

      final newAccessToken = refreshResponse.data['accessToken']?.toString();
      final newRefreshToken = refreshResponse.data['refreshToken']?.toString();

      if (newAccessToken == null) {
        _refreshCompleter!.completeError('no_access_token');
        await _onExpired(handler, err);
        return;
      }

      await authStorageService.saveAccessToken(newAccessToken);
      if (newRefreshToken != null) {
        await authStorageService.saveRefreshToken(newRefreshToken);
      }

      _refreshCompleter!.complete(newAccessToken); // ✅ unblocks all waiting requests

      final retryOptions = err.requestOptions;
      retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
      final retryResponse = await dio.fetch(retryOptions);
      handler.resolve(retryResponse);
    } catch (_) {
      _refreshCompleter?.completeError('refresh_failed');
      await _onExpired(handler, err);
    } finally {
      _refreshCompleter = null; // ✅ always reset
    }
  }

  Future<void> _onExpired(
  ErrorInterceptorHandler handler,
  DioException err,
) async {
  print('SESSION EXPIRED IN FLUTTER');

  await authStorageService.clearAll();

  onSessionExpired?.call();

  handler.next(err);
}
}