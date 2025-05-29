// Importing axios for making HTTP requests

// Importing Container and Service from typedi for dependency injection
import Container, { Service } from "typedi";

// Importing custom error classes for handling specific types of errors
import { BusinessError } from "../custom-errors";

// Importing the necessary interfaces and models from the project
import { RequestInterface } from "../interfaces";
import { ChatModel, ReturnMessageModel } from "../models";
import ChatFilterInputModel from "../models/api-models/chat-filter-input.model";
import ChatInputModel from "../models/api-models/chat-input.model";

// Importing the ChatRepository for database operations
import { ChatRepository, ConfigRepository } from "../repositories";

// Importing the UserService for user-related operations
import axios from "axios";

@Service({ transient: true })
export class ChatService {
  private readonly _chatRepository: ChatRepository;
  private readonly _configRepository: ConfigRepository;

  constructor() {
    this._chatRepository = Container.get(ChatRepository);
    this._configRepository = Container.get(ConfigRepository);
  }

  /**
   * Method to get chat messages based on filter criteria.
   * @param req - The request object containing user session information.
   * @param filter - The filter criteria for retrieving chat messages.
   * @returns A promise that resolves to an array of ChatModel instances.
   */
  async getChats(
    req: RequestInterface,
    filter: ChatFilterInputModel
  ): Promise<ChatModel[]> {
    // Call the getChats method of ChatRepository
    return await this._chatRepository.getChats(filter);
  }

  /**
   * Method to create a new chat message.
   * @param req - The request object containing user session information.
   * @param body - The input model containing the chat message details.
   * @returns A promise that resolves to a ReturnMessageModel containing the created chat message.
   */
  async createChat(
    req: RequestInterface,
    body: ChatInputModel
  ): Promise<ReturnMessageModel> {
    // Fetch existing chat messages for the user, sorted by creation date
    let chatQuery: any = {
      sortBy: "createdAt",
      sortOrder: "asc",
    };

    const chats = await this._chatRepository.getChats(chatQuery);

    // Get the constants used in the application
    const config = await this._configRepository.getConfigs({});

    // Initialize the messages array with the user's introduction and triage note
    let triageNote = config[0]?.triageNote || "";
    let patientHistory = config[0]?.patientHistory || "";
    let patientName = config[0]?.patientName || "";

    // Initialize the messages array with the user's introduction and triage note
    let messages = [
      {
        role: "user",
        content: `My name is ${patientName}. Here is my triage note : ${triageNote}. 
        Here is my pre-existing medical documentation including the discharge summaries and primary care physician notes: ${patientHistory}.
        Ask me one question at a time. 
        Ask for my permission first before asking me questions. Do not ask me more than one question at a time. 
        Now start the conversation by introducing yourself.`,
      },
    ];

    // Add existing chat messages to the messages array
    if (chats.length > 0) {
      chats.forEach((chat) => {
        messages.push({
          role: chat.sender == "BOT" ? "assistant" : "user",
          content: chat.message,
        });
      });
    }

    // Add the new chat message to the messages array
    messages.push({
      role: "user",
      content: body.message,
    });

    // Create a new chat message in the database
    await this._chatRepository.createChat({
      sender: "USER",
      message: body.message,
    });

    try {
      // Send the messages to the external API and get the response
      const LlmResponse = await axios.post(process.env.LLM_API_URL, {
        messages: messages,
        promptType: "sepsis_agent_prompt",
      });

      // Create a new chat message in the database with the response from the API
      await this._chatRepository.createChat({
        sender: "BOT",
        message: LlmResponse.data.response,
      });

      // Return the response message
      return {
        message: LlmResponse.data.response,
      };
    } catch (e) {
      console.log(e);
      throw new BusinessError("Error in chat service");
    }
  }

  /**
   * Method to initiate a new chat message.
   * @param req - The request object containing user session information.
   * @param body - The input model containing the chat message details.
   * @returns A promise that resolves to a ReturnMessageModel containing the initiation status.
   */
  async initiateChat(
    req: RequestInterface,
    body: ChatInputModel
  ): Promise<ReturnMessageModel> {
    // Fetch existing chat messages for the user, sorted by creation date
    let chatQuery: any = {
      sortBy: "createdAt",
      sortOrder: "asc",
    };

    const chats = await this._chatRepository.getChats(chatQuery);

    // If there are existing chat messages, return a message indicating that the chat is already initiated
    if (chats.length > 0) {
      return {
        message: "Chat already initiated",
      };
    }

    // Get the constants used in the application
    const config = await this._configRepository.getConfigs({});

    // Initialize the messages array with the user's introduction and triage note
    let triageNote = config[0]?.triageNote || "";
    let patientHistory = config[0]?.patientHistory || "";
    let patientName = config[0]?.patientName || "";

    try {
      // Send the initial message to the external API and get the response. Here we provide the user's introduction and triage note along with the pre-existing medical documentation.
      const LlmResponse = await axios.post(process.env.LLM_API_URL, {
        messages: [
          {
            role: "user",
            content: `My name is ${patientName}. Here is my triage note : ${triageNote}.
              Here is my pre-existing medical documentation including the discharge summaries and primary care physician notes: ${patientHistory}.
              Ask me one question at a time.
              Ask for my permission first before asking me questions. Do not ask me more than one question at a time.
              Now start the conversation by introducing yourself.`,
          },
        ],
        promptType: "sepsis_agent_prompt",
      });

      // Create a new chat message in the database with the response from the API
      await this._chatRepository.createChat({
        sender: "BOT",
        message: LlmResponse.data.response,
      });

      // Return a message indicating that the chat was initiated successfully
      return {
        message: "Chat initiated successfully",
      };
    } catch (e) {
      console.log(e);
      throw new BusinessError("Error in chat service");
    }
  }

  /**
   * Method to update an existing chat message.
   * @param req - The request object containing user session information.
   * @param body - The input model containing the updated chat message details.
   * @param ChatId - The ID of the chat message to be updated.
   * @returns A promise that resolves to the updated ChatModel instance.
   */
  async updateChat(
    req: RequestInterface,
    body: ChatInputModel,
    ChatId: number
  ): Promise<ChatModel> {
    // Call the updateChat method of ChatRepository
    return await this._chatRepository.updateChat(body, ChatId);
  }

  /**
   * Method to delete a chat message.
   * @param req - The request object containing user session information.
   * @param filter - The filter criteria for deleting chat messages.
   * @returns A promise that resolves to a ReturnMessageModel containing the deletion status message.
   */
  async deleteChat(
    req: RequestInterface,
    filter: ChatFilterInputModel
  ): Promise<ReturnMessageModel> {
    // Call the deleteChatByCaseId method of ChatRepository which clears all chat messages for a case for a User
    if (filter.clearChat) {
      return await this._chatRepository.clearChat();
    }

    // Call the deleteChat method of ChatRepository which deletes a particular chat message by ID
    return await this._chatRepository.deleteChat(filter.id);
  }
}
