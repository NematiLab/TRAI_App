import 'package:dio/dio.dart';
import 'package:frontend/core/interceptors/dio_interceptors.dart';
import 'package:logger/logger.dart';

/// This class provides a configured Dio client for making HTTP requests.
class DioClient {
  final logger = Logger(); // Logger instance for logging information

  final _dio = Dio(); // Dio instance for making HTTP requests

  /// Constructor to initialize the Dio client.
  /// Adds a custom interceptor to handle request, response, and error logging.
  DioClient() {
    logger.i('Got a DioClient'); // Log the creation of the DioClient
    _dio.interceptors.add(DioInterceptor()); // Add the custom interceptor
  }

  /// Getter to access the Dio instance.
  Dio get dio => _dio;
}
