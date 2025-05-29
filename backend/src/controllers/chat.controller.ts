"use strict";

// Importing required modules from routing-controllers and typedi
import {
  Body,
  Delete,
  Get,
  JsonController,
  Param,
  Patch,
  Post,
  QueryParams,
  Req,
} from "routing-controllers";
import Container, { Service } from "typedi";

// Importing interfaces and models used in the controller
import { RequestInterface } from "../interfaces";
import { ChatModel, ReturnMessageModel } from "../models";
import ChatFilterInputModel from "../models/api-models/chat-filter-input.model";
import ChatInputModel from "../models/api-models/chat-input.model";
import { ChatService } from "../services";

// JsonController decorator defines this class as a controller for handling chat-related routes
@JsonController("/chat")
@Service()
export class ChatController {
  // Private member to hold the instance of ChatService
  private readonly _chatService: ChatService;

  // Using dependency injection's Container to get an instance of ChatService
  constructor() {
    this._chatService = Container.get(ChatService);
  }

  /**
   * GET /chat
   * Endpoint to get all chats based on the provided filter.
   * @param req - The request interface containing user session information.
   * @param filter - The chat filter input model containing filter parameters.
   * @returns A promise that resolves to an array of ChatModel containing chats of the patient.
   */
  @Get("/")
  async getChats(
    @Req() req: RequestInterface,
    @QueryParams() filter: ChatFilterInputModel
  ): Promise<ChatModel[]> {
    // Call the getChats method of ChatService
    return await this._chatService.getChats(req, filter);
  }

  /**
   * GET /chat/initiate
   * Endpoint to initiate a chat with the assistant. This will send the first message to the assistant giving it the users input.
   * @param req - The request interface containing user session information.
   * @param body - The chat input model containing the user's initial message.
   * @returns A promise that resolves that the chat has been initiated.
   */
  @Get("/initiate")
  async initiateChat(
    @Req() req: RequestInterface,
    @Body() body: ChatInputModel
  ): Promise<ReturnMessageModel> {
    // Call the initiateChat method of ChatService
    return await this._chatService.initiateChat(req, body);
  }

  /**
   * POST /chat
   * Endpoint to create a new chat. This will talk to the assistant and get the response.
   * @param req - The request interface containing user session information.
   * @param body - The chat input model containing the chat details.
   * @returns A promise that resolves to a ReturnMessageModel containing the status message.
   */
  @Post("/")
  async createChat(
    @Req() req: RequestInterface,
    @Body() body: ChatInputModel
  ): Promise<ReturnMessageModel> {
    // Call the createChat method of ChatService
    return await this._chatService.createChat(req, body);
  }

  /**
   * PATCH /chat/:id
   * Endpoint to update an existing chat.
   * @param req - The request interface containing user session information.
   * @param body - The chat input model containing the chat details.
   * @param id - The id of the chat to be updated.
   * @returns A promise that resolves to a ChatModel containing the updated chat details.
   */
  @Patch("/:id")
  async updateChat(
    @Req() req: RequestInterface,
    @Body() body: ChatInputModel,
    @Param("id") id: number
  ): Promise<ChatModel> {
    // Call the updateChat method of ChatService
    return await this._chatService.updateChat(req, body, id);
  }

  /**
   * DELETE /chat
   * Endpoint to delete an existing chat.
   * @param req - The request interface containing user session information.
   * @param filter - The chat filter input model containing filter parameters.
   * @returns A promise that resolves to a ReturnMessageModel containing the status message.
   */
  @Delete("/")
  async deleteChat(
    @Req() req: RequestInterface,
    @QueryParams() filter: ChatFilterInputModel
  ): Promise<ReturnMessageModel> {
    // Call the deleteChat method of ChatService
    return await this._chatService.deleteChat(req, filter);
  }
}
