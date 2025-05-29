import 'package:flutter/foundation.dart';

import 'appshell_logger_public.dart';

// This class is used to log messages and errors to the console.
class AppShellLogger {
  final List<AppShellLoggerModuleContract> _loggerModules;

  AppShellLogger._(this._loggerModules);

  static AppShellLogger? _instance;

  factory AppShellLogger.createInstance(
    List<AppShellLoggerModuleContract> modules,
  ) {
    return _instance ??= AppShellLogger._(modules);
  }

  static AppShellLogger get getInstance {
    if (_instance == null) {
      kDebugMode
          ? throw Exception('App Shell Logger Not Initialized')
          : AppShellLogger.createInstance(
              [
                DevToolsLoggerModule(),
              ],
            );
    }

    return _instance!;
  }

// This method is used to log messages to the console.
  void logMessage(
    String message, {
    AppShellLoggerMessageType messageType = AppShellLoggerMessageType.debug,
  }) {
    for (final module in _loggerModules) {
      module.logMessage(message, messageType: messageType);
    }
  }

// This method is used to log errors to the console.
  void logError(
    Object error, {
    StackTrace? stackTrace,
    bool? fatal,
  }) {
    for (final module in _loggerModules) {
      module.logError(Exception(error), stackTrace, fatal);
    }
  }
}
