// Importing AutoMap decorator from @automapper/classes for automatic mapping of properties
import { AutoMap } from "@automapper/classes";

// Importing Joi for validation of input properties
import * as Joi from "joiful";

// ConfigFilterInputModel class with properties for filtering Config messages
export default class ConfigFilterInputModel {
  // id property for filtering Config messages by id
  @AutoMap()
  @(Joi.number().optional())
  id?: number;
}
