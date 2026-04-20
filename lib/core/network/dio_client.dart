import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/constants.dart';
import '../error/exceptions.dart';
import '../utils/local_storage.dart';
import '../utils/logger.dart';

@lazySingleton
class DioClient {
  late final Dio _dio;
  final LocalStorage _localStorage;

  DioClient(this._localStorage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: AppConstants.connectionTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        responseType: ResponseType.json,
      ),
    );

    // SSL Certificate Handling (Bypass for Dev/Test)
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient(
          context: SecurityContext(withTrustedRoots: false),
        );
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );

    // Add PrettyDioLogger
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    // Add Retry Interceptor
    _dio.interceptors.add(
      RetryInterceptor(
        dio: _dio,
        logPrint: AppLogger.info,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
        retryEvaluator: (error, attempt) {
          if (error.response != null) {
            final statusCode = error.response?.statusCode;
            if (statusCode != null && statusCode >= 400 && statusCode < 500) {
              return false;
            }
          }
          return true;
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // For Supabase Edge Functions, we always need the ANON KEY in Authorization header
          // Unless we are passing a specific user token for authenticated requests.
          // For login/signup, we use the ANON KEY.

          final token = _localStorage.getToken();
          if (token != null && token.isNotEmpty) {
            // If we have a user token, we use it.
            // Note: Depending on the API, you might need both apikey and Authorization.
            // For these edge functions, the user mentioned passing SUPABASE_ANON_KEY in Authorization.
            options.headers['Authorization'] = 'Bearer $token';
          } else {
            options.headers['Authorization'] =
                'Bearer ${AppConstants.supabaseAnonKey}';
          }

          options.headers['Content-Type'] = 'application/json';
          options.headers['User-Agent'] = 'WorkTraceApp/1.0.0';

          return handler.next(options);
        },
        onError: (error, handler) async {
          final response = error.response;
          if (response?.statusCode == 401 || response?.statusCode == 403) {
            await _localStorage.clearToken();
            await _localStorage.setIsLoggedIn(false);
            // Navigation should be handled by a navigation service or Bloc listener
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return NetworkException(message: 'Connection timed out');
    }

    if (error.response != null) {
      final statusCode = error.response?.statusCode;
      final data = error.response?.data;
      String message = 'Unknown error';

      if (data is Map && data.containsKey('error')) {
        message = data['error'];
      } else if (data is Map && data.containsKey('message')) {
        message = data['message'];
      } else {
        message = error.response?.statusMessage ?? 'Unknown error';
      }

      if (statusCode == 401 || statusCode == 403) {
        return UnauthorizedException(message: message);
      }
      if (statusCode != null && statusCode >= 500) {
        return ServerException(
          message: 'Server error: $statusCode',
          statusCode: statusCode,
        );
      }
      return ApiException(message: message, statusCode: statusCode);
    }

    return NetworkException(
      message: 'No internet connection or server unreachable',
    );
  }
}
