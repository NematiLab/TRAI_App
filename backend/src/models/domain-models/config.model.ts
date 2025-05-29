// Importing AutoMap decorator from @automapper/classes for automatic mapping of properties
import { AutoMap } from "@automapper/classes";

// ConfigModel class with properties for Config messages
export class ConfigModel {
  // id property for the id of the Config message
  @AutoMap()
  id: number;

  // key property for storing the patient history
  @AutoMap()
  patientHistory: string;

  // value property for storing the name of the patient
  @AutoMap()
  patientName: string;

  // triageNote property for storing the triage note
  @AutoMap()
  triageNote: string;
}
