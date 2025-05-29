// Importing Container and Service from typedi for dependency injection
import Container, { Service } from "typedi";

// Importing the necessary models from the project
import { ChatModel, ReturnMessageModel } from "../models";
import ChatFilterInputModel from "../models/api-models/chat-filter-input.model";
import ChatInputModel from "../models/api-models/chat-input.model";

// Importing dbContext for database operations
import { dbContext } from "./db-context";

// Importing the ChatMapper for mapping chat data
import { ChatMapper } from "./db-model-mappers";

@Service({ transient: true })
export class ChatRepository {
  private readonly _chatMapper: ChatMapper;

  constructor() {
    this._chatMapper = Container.get(ChatMapper);
  }

  /**
   * Method to get chat messages based on filter criteria.
   * @param filter - The filter criteria for retrieving chat messages.
   * @returns A promise that resolves to an array of ChatModel instances.
   */
  async getChats(filter: ChatFilterInputModel): Promise<ChatModel[]> {
    // Initialize the query and sort objects
    let query = {};
    let sort = {};

    // Adding filter criteria to the query object

    if (filter.id) {
      query = {
        ...query,
        id: filter.id,
      };
    }

    if (filter.patientId) {
      query = {
        ...query,
        patientId: filter.patientId,
      };
    }

    if (filter.sender) {
      query = {
        ...query,
        sender: filter.sender,
      };
    }

    // Adding sorting criteria to the sort object
    if (filter.sortBy && filter.sortOrder) {
      sort = {
        [filter.sortBy]: filter.sortOrder,
      };
    }

    // Querying the database to find chat messages based on the filter criteria
    const Chats: any = await dbContext.prisma.chat.findMany({
      where: query,
      orderBy: sort,
    });

    // Mapping the raw chat data to ChatModel instances and returning them
    return this._chatMapper.mapArray(Chats);
  }

  /**
   * Method to create a new chat message.
   * @param body - The input model containing the chat message details.
   * @returns A promise that resolves to the created ChatModel instance.
   */
  async createChat(body: ChatInputModel): Promise<ChatModel> {
    // Generating the input object for the database operation
    const inputData = await this._generateInputObject(body);

    // Creating a new chat message in the database
    const Chat = await dbContext.prisma.chat.create({
      data: inputData,
    });

    // Mapping the raw chat data to a ChatModel instance and returning it
    return this._chatMapper.map(Chat);
  }

  /**
   * Method to initiate a new chat message.
   * @param body - The input model containing the chat message details.
   * @returns A promise that resolves to the created ChatModel instance.
   */
  async initiateChat(body: ChatInputModel): Promise<ChatModel> {
    // Generating the input object for the database operation
    const inputData = await this._generateInputObject(body);

    // Creating a new chat message in the database
    const Chat = await dbContext.prisma.chat.create({
      data: inputData,
    });

    // Mapping the raw chat data to a ChatModel instance and returning it
    return this._chatMapper.map(Chat);
  }

  /**
   * Method to update an existing chat message.
   * @param body - The input model containing the updated chat message details.
   * @param ChatId - The ID of the chat message to be updated.
   * @returns A promise that resolves to the updated ChatModel instance.
   */
  async updateChat(body: ChatInputModel, ChatId: number): Promise<ChatModel> {
    // Generating the input object for the database operation
    const inputData = await this._generateInputObject(body);

    // Updating the chat message in the database
    const Chat = await dbContext.prisma.chat.update({
      where: {
        id: ChatId,
      },
      data: inputData,
    });

    // Mapping the raw chat data to a ChatModel instance and returning it
    return this._chatMapper.map(Chat);
  }

  /**
   * Method to delete a chat message by its ID.
   * @param ChatId - The ID of the chat message to be deleted.
   * @returns A promise that resolves to a ReturnMessageModel containing the deletion status message.
   */
  async deleteChat(ChatId: number): Promise<ReturnMessageModel> {
    // Deleting the chat message from the database
    const Chat = await dbContext.prisma.chat.delete({
      where: {
        id: ChatId,
      },
    });

    // Returning a success message if the chat was deleted, otherwise a not found message
    if (Chat) {
      return {
        message: "Chat deleted successfully",
      };
    }

    return {
      message: "Chat not found",
    };
  }

  /**
   * Method to delete chat messages by case ID.
   * @param userId - The ID of the user whose chat messages are to be deleted.
   * @param caseId - The ID of the case whose chat messages are to be deleted.
   * @returns A promise that resolves to a ReturnMessageModel containing the deletion status message.
   */
  async clearChat(): Promise<ReturnMessageModel> {
    // Deleting chat messages from the database by user ID
    const Chat = await dbContext.prisma.chat.deleteMany({});

    // Returning a success message if the chats were deleted, otherwise a not found message
    if (Chat) {
      return {
        message: "Chat deleted successfully",
      };
    }

    return {
      message: "Chat not found",
    };
  }

  /**
   * Private method to generate the input object for database operations.
   * @param body - The input model containing the chat message details.
   * @returns The generated input object.
   */
  private async _generateInputObject(body: ChatInputModel) {
    // Creating the input object with the provided chat message details
    let inputData: any = {
      message: body.message,
      sender: body.sender,
      comment: body.comment,
      rating: body.rating,
      updatedAt: new Date(),
    };

    // Returning the generated input object
    return inputData;
  }
}
