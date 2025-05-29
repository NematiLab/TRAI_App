import 'package:flutter/foundation.dart';
import 'package:frontend/logger/appshell_logger_message_type.dart';
import 'package:frontend/logger/appshell_logger_module_contract.dart';
import 'package:logger/web.dart';

// This class is used to log messages and errors to the console.
class DevToolsLoggerModule implements AppShellLoggerModuleContract {
  final logger = kDebugMode
      ? Logger(
          printer: PrettyPrinter(
            methodCount: 0,
            lineLength: 80,
          ),
        )
      : null;

  @override
  void logMessage(
    String message, {
    AppShellLoggerMessageType messageType = AppShellLoggerMessageType.debug,
  }) {
    if (kDebugMode) {
      switch (messageType) {
        case AppShellLoggerMessageType.info:
          logger?.i(message);
        case AppShellLoggerMessageType.warning:
          logger?.w(message);
        case AppShellLoggerMessageType.debug:
          logger?.d(message);
      }
    }
  }

  @override
  void logError(Exception exception, StackTrace? stackTrace, bool? fatal) {
    if (kDebugMode) {
      logger?.f(exception.toString(),
          stackTrace: stackTrace, time: DateTime.now(), error: exception);
    }
  }
}
