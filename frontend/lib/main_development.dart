import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/app.dart';
import 'package:frontend/core/bloc_observer/app_bloc_observer.dart';
import 'package:frontend/core/dependency_injection/clients/sharedpreference_client.dart';
import 'package:frontend/core/dependency_injection/dependency_injection.dart';
import 'package:frontend/logger/appshell_logger.dart';
import 'package:frontend/logger/logger_modules/devtools_logger_module.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  // Run the application within a guarded zone to handle errors and stack traces
  await runZonedGuarded<Future<void>>(() async {
    // Ensure that Flutter bindings are initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Set up dependency injection for the application
    AppDependencyInjector.setupAppDependencies();

    // Load environment variables from the 'dev.env' file
    await dotenv.load(fileName: 'dev.env');

    // Initialize the BLoC observer for monitoring BLoC events and transitions
    final blocObserver = AppBlocObserver();
    Bloc.observer = blocObserver;

    // Initialize shared preferences for persistent storage
    await AppDependencyInjector.getIt
        .get<SharedPreferencesManagerClient>()
        .sharedPreferencesManager
        .init();

    // Create an instance of the application logger with the DevTools logger module
    AppShellLogger.createInstance(
      [
        DevToolsLoggerModule(),
      ],
    );

    // Set the preferred device orientation to portrait mode
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Run the application with overlay support
    runApp(const OverlaySupport(child: MyAppShell()));
  }, (error, stackTrace) async {
    // Log any errors that occur during the execution of the application
    AppShellLogger.getInstance.logError(
      error,
      stackTrace: stackTrace,
      fatal: true,
    );
  });
}
