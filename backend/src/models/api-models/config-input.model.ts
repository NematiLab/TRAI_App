// Importing AutoMap decorator from @automapper/classes for automatic mapping of properties
import { AutoMap } from "@automapper/classes";

// Importing Joi for validation of input properties
import * as Joi from "joiful";

// ConfigInputModel class with properties for Config messages
export default class ConfigInputModel {
  // id property for the id of the Config message
  @AutoMap()
  @(Joi.number().optional())
  id?: number;

  // description property for storing the patient history
  @AutoMap()
  @(Joi.string().optional())
  patientHistory?: string;

  // patientName property for storing the name of the patient
  @AutoMap()
  @(Joi.string().optional())
  patientName?: string;

  // triageNote property for storing the triage note
  @AutoMap()
  @(Joi.string().optional())
  triageNote?: string;
}
