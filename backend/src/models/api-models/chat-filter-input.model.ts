// Importing AutoMap decorator from @automapper/classes for automatic mapping of properties
import { AutoMap } from "@automapper/classes";

// Importing Joi for validation of input properties
import * as Joi from "joiful";

// ChatFilterInputModel class with properties for filtering chat messages
export default class ChatFilterInputModel {
  // id property for filtering chat messages by id
  @AutoMap()
  @(Joi.number().optional())
  id?: number;

  // userId property for filtering chat messages by user id
  @AutoMap()
  @(Joi.number().optional())
  patientId?: number;

  // sender property for filtering chat messages by sender
  @AutoMap()
  @(Joi.string().optional())
  sender?: string;

  // sortBy property for sorting the chat messages by providing the field to sort on
  @AutoMap()
  @(Joi.string().optional())
  sortBy?: string;

  // sortOrder property for sorting the chat messages in ascending or descending order
  @AutoMap()
  @(Joi.string().optional())
  sortOrder?: string;

  // caseId property for filtering chat messages by case id
  @AutoMap()
  @(Joi.boolean().optional())
  clearChat?: boolean;
}
