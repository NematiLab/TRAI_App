import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

/// Custom BlocObserver to observe and log BLoC events, transitions, errors, and state changes.
class AppBlocObserver extends BlocObserver {
  AppBlocObserver();

  final logger = Logger(); // Logger instance for logging information

  /// Called whenever a transition occurs in any BLoC.
  /// Logs the transition details.
  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    logger.i(
      'onTransition ${bloc.runtimeType}: ${transition.runtimeType}',
    ); // Log the transition
    log('onTransition ${bloc.runtimeType}: ${transition.runtimeType}'); // Log the transition using Dart's developer log
  }

  /// Called whenever an error occurs in any BLoC.
  /// Logs the error details and stack trace.
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.e('onError ${bloc.runtimeType}',
        error: error, stackTrace: stackTrace); // Log the error
    log('onError ${bloc.runtimeType}',
        error: error,
        stackTrace: stackTrace); // Log the error using Dart's developer log
  }

  /// Called whenever a state change occurs in any BLoC.
  /// Logs the new state.
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    final dynamic state = change.nextState;
    logger.i('state ${state.runtimeType}'); // Log the new state
    log('state ${state.runtimeType}'); // Log the new state using Dart's developer log
  }

  /// Called whenever an event is added to any BLoC.
  /// Logs the event.
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.i('event ${event.runtimeType}'); // Log the event
    log('event ${event.runtimeType}'); // Log the event using Dart's developer log
  }

  /// Called whenever a BLoC is created.
  /// Logs the creation of the BLoC.
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    logger.i('onCreate ${bloc.runtimeType}'); // Log the creation of the BLoC
    log('onCreate ${bloc.runtimeType}'); // Log the creation using Dart's developer log
  }

  /// Called whenever a BLoC is closed.
  /// Logs the closure of the BLoC.
  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    logger.i('onClose ${bloc.runtimeType}'); // Log the closure of the BLoC
    log('onClose ${bloc.runtimeType}'); // Log the closure using Dart's developer log
  }
}
