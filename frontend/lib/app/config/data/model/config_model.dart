/// Model class representing a Config message.
class ConfigModel {
  final int id;
  final String patientHistory;
  final String triageNote;
  final String patientName;

  /// Constructor for creating a ConfigModel instance.
  ConfigModel({
    required this.id,
    required this.patientHistory,
    required this.triageNote,
    required this.patientName,
  });

  /// Factory method for creating a ConfigModel instance from a JSON map.
  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      id: json['id'],
      patientHistory: json['patientHistory'],
      triageNote: json['triageNote'],
      patientName: json['patientName'],
    );
  }

  /// Method for converting a ConfigModel instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientHistory': patientHistory,
      'triageNote': triageNote,
      'patientName': patientName,
    };
  }
}
