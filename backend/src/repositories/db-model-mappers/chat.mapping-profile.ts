// Importing the Service decorator from typedi for dependency injection
import { Service } from "typedi";

// Importing the necessary models from the project
import { ChatModel } from "../../models";
import { BaseMapper } from "./base-mapper";

@Service({ transient: true })
export class ChatMapper extends BaseMapper<any, ChatModel> {
  /**
   * Maps the raw chat data to the ChatModel.
   * @param chat - The raw chat data to be mapped.
   * @returns The mapped ChatModel instance.
   */
  map(chat: any): ChatModel {
    // Creating a new instance of ChatModel
    const chatModel = new ChatModel();

    // Mapping properties from the raw chat data to the ChatModel instance
    chatModel.id = chat.id;
    chatModel.message = chat.message;
    chatModel.sender = chat.sender;
    chatModel.comment = chat.comment;
    chatModel.rating = chat.rating;

    // Returning the mapped ChatModel instance
    return chatModel;
  }
}
