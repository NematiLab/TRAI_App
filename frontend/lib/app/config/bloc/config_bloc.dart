import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:frontend/app/config/data/service/config_service.dart';
import 'package:frontend/core/dependency_injection/dependency_injection.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final Logger logger = Logger();

  ConfigService configService = AppDependencyInjector.getIt.get();

  ConfigBloc() : super(ConfigInitial()) {
    on<ConfigPageInitiateEvent>(_configPageInitiateEvent);
    on<UpdateConfigEvent>(_updateConfigEvent);
  }

  // Function to handle the update config event
  Future<void> _updateConfigEvent(
      UpdateConfigEvent event, Emitter<ConfigState> emit) async {
    try {
      // Update the configuration with the provided values
      await configService.updateConfig(
        event.patientName,
        event.patientHistory,
        event.triageNote,
      );

      // Emit a success state after updating the config
      emit(ConfigPageInitiateState());
    } catch (e) {
      // Handle any errors that occur during the update
      emit(ConfigErrorState('Failed to update config: $e'));
    }
  }

  // Function to handle the config page initiate event
  Future<void> _configPageInitiateEvent(
      ConfigPageInitiateEvent event, Emitter<ConfigState> emit) async {
    try {
      // Emit the initial state for the config page
      final config = await configService.get();

      var patientHistory = config[0].patientHistory;
      var patientName = config[0].patientName;
      var triageNote = config[0].triageNote;

      emit(ConfigLoadedState(
        patientHistory: patientHistory,
        patientName: patientName,
        triageNote: triageNote,
      ));
    } catch (e) {
      // Handle any errors that occur during the initiation
      emit(ConfigErrorState('Failed to initiate config page: $e'));
    }
  }
}
