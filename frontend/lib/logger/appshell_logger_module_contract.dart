import 'package:frontend/logger/appshell_logger_message_type.dart';

/// This abstract class defines the contract for logging messages and errors.
/// Implementations of this contract will handle logging to various destinations such as console, files, or remote servers.
abstract class AppShellLoggerModuleContract {
  void logMessage(
    String message, {
    AppShellLoggerMessageType messageType = AppShellLoggerMessageType.debug,
  });

  void logError(
    Exception exception,
    StackTrace? stackTrace,
    bool? fatal,
  );
}
