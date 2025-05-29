// Importing AutoMap decorator from @automapper/classes for automatic mapping of properties
import { AutoMap } from "@automapper/classes";

// ChatModel class with properties for chat messages
export class ChatModel {
  // id property for the id of the chat message
  @AutoMap()
  id: number;

  // message property for storing the chat message
  @AutoMap()
  message: string;

  // sender property for identifying the sender of the chat message
  @AutoMap()
  sender: string;

  // rating property for rating the chat message
  @AutoMap()
  rating: string;

  // comment property for adding a comment to the chat message
  @AutoMap()
  comment: number;
}
