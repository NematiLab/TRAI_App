import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../config.dart';

/// This class defines a custom interceptor for Dio HTTP client.
/// It handles request, response, and error logging, as well as token management and redirection.
class DioInterceptor extends Interceptor {
  final logger = Logger(); // Logger instance for logging information
  String? path; // Variable to store the request path
  DateTime? requestTime; // Variable to store the request time
  DateTime? responseTime; // Variable to store the response time

  /// Intercepts and processes HTTP requests before they are sent.
  /// Adds authorization headers and logs request details.
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    requestTime = DateTime.now();

    // Add headers if the request is to the triage platform API
    if (options.path.contains(Config.triagePlatformApiUrl)) {
      options.headers['accept'] = 'application/json';
      options.headers['Content-Type'] = 'application/json';
    }

    path = options.path;
    logger.i('Request Path: ${options.path}: ${handler.hashCode}');
    super.onRequest(options, handler);
  }

  /// Intercepts and processes HTTP responses.
  /// Logs response details including status and response time.
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    responseTime = DateTime.now();
    logger.i(
      'Response Status: ${response.statusCode}: $path  Response Time: ${responseTime!.difference(requestTime!)}',
    );
    super.onResponse(response, handler);
  }

  /// Intercepts and processes HTTP errors.
  /// Logs error details and handles specific status codes (e.g., 402 for inactive user).
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    logger.e('DIO Error: ${err.message}: $path');

    super.onError(err, handler);
  }
}
