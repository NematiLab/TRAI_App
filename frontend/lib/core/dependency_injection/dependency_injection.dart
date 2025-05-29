import 'package:frontend/app/config/data/service/config_service.dart';
import 'package:frontend/app/home/data/services/chat_service.dart';
import 'package:frontend/core/dependency_injection/clients/dio_client.dart';
import 'package:frontend/core/dependency_injection/clients/sharedpreference_client.dart';
import 'package:get_it/get_it.dart';

/// Abstract class to set up dependency injection for the application.
abstract class AppDependencyInjector {
  // Singleton instance of GetIt for dependency injection
  static final getIt = GetIt.instance;

  /// Method to set up all the dependencies required by the application.
  static void setupAppDependencies() {
    _getDioService();
    _getSharedPreferencesManagerClient();
    _getChatService();
    _getConfigService();
  }

  /// Registers DioClient as a lazy singleton.
  /// DioClient will be created only when it is first requested.
  static void _getDioService() {
    getIt.registerLazySingleton<DioClient>(() => DioClient());
  }

  /// Registers SharedPreferencesManagerClient as a lazy singleton.
  /// SharedPreferencesManagerClient will be created only when it is first requested.
  static void _getSharedPreferencesManagerClient() {
    getIt.registerLazySingleton<SharedPreferencesManagerClient>(
      () => SharedPreferencesManagerClient(),
    );
  }

  /// Registers ChatService as a lazy singleton.
  /// ChatService will be created only when it is first requested.
  static void _getChatService() {
    getIt.registerLazySingleton<ChatService>(() => ChatService());
  }

  /// Registers ConfigService as a lazy singleton.
  /// ConfigService will be created only when it is first requested.
  static void _getConfigService() {
    getIt.registerLazySingleton<ConfigService>(() => ConfigService());
  }
}
