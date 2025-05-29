part of 'config_bloc.dart';

@immutable
sealed class ConfigState {}

final class ConfigInitial extends ConfigState {}

abstract class ConfigActionState extends ConfigState {}

final class ConfigLoadedState extends ConfigState {
  final String patientHistory;
  final String patientName;
  final String triageNote;

  ConfigLoadedState({
    required this.patientHistory,
    required this.patientName,
    required this.triageNote,
  });
}

final class ConfigErrorState extends ConfigState {
  final String error;

  ConfigErrorState(this.error);
}

final class ConfigPageInitiateState extends ConfigActionState {}
