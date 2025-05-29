// Importing AutoMap decorator from @automapper/classes for automatic mapping of properties
import { AutoMap } from "@automapper/classes";

// ReturnMessageModel class with properties for return messages
export class ReturnMessageModel {
  // message property for storing the return message
  @AutoMap()
  message: string;
}
