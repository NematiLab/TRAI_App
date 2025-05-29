part of 'config_bloc.dart';

@immutable
sealed class ConfigEvent {}

class ConfigPageInitiateEvent extends ConfigEvent {}

class UpdateConfigEvent extends ConfigEvent {
  final String patientName;
  final String patientHistory;
  final String triageNote;

  UpdateConfigEvent({
    required this.patientName,
    required this.patientHistory,
    required this.triageNote,
  });
}
