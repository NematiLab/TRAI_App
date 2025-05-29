// Importing AutoMap decorator from @automapper/classes for automatic mapping of properties
import { AutoMap } from "@automapper/classes";

// Importing Joi for validation of input properties
import * as Joi from "joiful";

// ChatInputModel class with properties for chat messages
export default class ChatInputModel {
  // message property for storing the chat message
  @AutoMap()
  @(Joi.string().optional())
  message?: string;

  // id property for the id of the chat message
  @AutoMap()
  @(Joi.number().optional())
  id?: number;

  // sender property for identifying the sender of the chat message
  @AutoMap()
  @(Joi.string().optional())
  sender?: string;

  // comment property for adding a comment to the chat message
  @AutoMap()
  @(Joi.string().optional())
  comment?: string;

  // rating property for rating the chat message
  @AutoMap()
  @(Joi.number().optional())
  rating?: number;
}
