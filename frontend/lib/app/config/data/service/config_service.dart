import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/app/config/data/model/config_model.dart';
import 'package:frontend/config.dart';
import 'package:frontend/core/dependency_injection/clients/dio_client.dart';
import 'package:frontend/core/dependency_injection/dependency_injection.dart';
import 'package:logger/logger.dart';

/// Service class for handling Config-related operations.
class ConfigService extends ChangeNotifier {
  final Logger logger = Logger();

  /// Fetches Config messages based on the provided search query.
  ///
  /// [searchQuery] is an optional map of query parameters for filtering the Config messages.
  /// Returns a list of [ConfigModel] instances.
  Future<List<ConfigModel>> get([Map<String, dynamic>? searchQuery]) async {
    try {
      final dio = AppDependencyInjector.getIt.get<DioClient>().dio;

      final response = await dio.get(
        '${Config.triagePlatformApiUrl}/config',
        queryParameters:
            searchQuery != null && searchQuery.isNotEmpty ? searchQuery : null,
      );

      logger.i('Login response: ${response.data}');

      final List<ConfigModel> Configs = (response.data as List)
          .map((item) => ConfigModel.fromJson(item))
          .toList();

      return Configs;
    } on DioException catch (e) {
      logger.e('Failed to login: ${e.message}');
      throw Exception('Failed to login: ${e.message}');
    }
  }

  /// Updates Config for a specific Config message.
  ///
  /// [ConfigId] is the ID of the Config message to be updated.
  /// [comment] is the Config comment.
  /// [rating] is the Config rating.
  Future<void> updateConfig(
      String patientName, String patientHistory, String triageNote) async {
    try {
      final dio = AppDependencyInjector.getIt.get<DioClient>().dio;

      final response = await dio.patch(
        '${Config.triagePlatformApiUrl}/config',
        data: {
          'id': 1,
          'patientName': patientName,
          'patientHistory': patientHistory,
          'triageNote': triageNote,
        },
      );

      logger.i('Login response: ${response.data}');

      return;
    } on DioException catch (e) {
      logger.e('Failed to login: ${e.message}');
      throw Exception('Failed to login: ${e.message}');
    }
  }
}
