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
import { ConfigModel, ReturnMessageModel } from "../models";
import ConfigFilterInputModel from "../models/api-models/config-filter-input.model";
import ConfigInputModel from "../models/api-models/config-input.model";
import { ConfigService } from "../services";

// JsonController decorator defines this class as a controller for handling Config-related routes
@JsonController("/config")
@Service()
export class ConfigController {
  // Private member to hold the instance of ConfigService
  private readonly _configService: ConfigService;

  // Using dependency injection's Container to get an instance of ConfigService
  constructor() {
    this._configService = Container.get(ConfigService);
  }

  /**
   * GET /Config
   * Endpoint to get all Configs based on the provided filter.
   * @param req - The request interface containing user session information.
   * @param filter - The Config filter input model containing filter parameters.
   * @returns A promise that resolves to an array of ConfigModel containing Configs of the patient.
   */
  @Get("/")
  async getConfigs(
    @Req() req: RequestInterface,
    @QueryParams() filter: ConfigFilterInputModel
  ): Promise<ConfigModel[]> {
    // Call the getConfigs method of ConfigService
    return await this._configService.getConfigs(req, filter);
  }

  /**
   * POST /Config
   * Endpoint to create a new Config. This will talk to the assistant and get the response.
   * @param req - The request interface containing user session information.
   * @param body - The Config input model containing the Config details.
   * @returns A promise that resolves to a ReturnMessageModel containing the status message.
   */
  @Post("/")
  async createConfig(
    @Req() req: RequestInterface,
    @Body() body: ConfigInputModel
  ): Promise<ConfigModel> {
    // Call the createConfig method of ConfigService
    return await this._configService.createConfig(req, body);
  }

  /**
   * PATCH /Config/:id
   * Endpoint to update an existing Config.
   * @param req - The request interface containing user session information.
   * @param body - The Config input model containing the Config details.
   * @param id - The id of the Config to be updated.
   * @returns A promise that resolves to a ConfigModel containing the updated Config details.
   */
  @Patch("/")
  async updateConfig(
    @Req() req: RequestInterface,
    @Body() body: ConfigInputModel
  ): Promise<ConfigModel> {
    // Call the updateConfig method of ConfigService
    return await this._configService.updateConfig(req, body);
  }

  /**
   * DELETE /Config
   * Endpoint to delete an existing Config.
   * @param req - The request interface containing user session information.
   * @param filter - The Config filter input model containing filter parameters.
   * @returns A promise that resolves to a ReturnMessageModel containing the status message.
   */
  @Delete("/")
  async deleteConfig(
    @Req() req: RequestInterface,
    @QueryParams() filter: ConfigFilterInputModel
  ): Promise<ReturnMessageModel> {
    // Call the deleteConfig method of ConfigService
    return await this._configService.deleteConfig(req, filter);
  }
}
