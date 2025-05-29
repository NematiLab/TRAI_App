// Importing Container and Service from typedi for dependency injection
import Container, { Service } from "typedi";

// Importing custom error classes for handling specific types of errors
import { BusinessError } from "../custom-errors";

// Importing the necessary interfaces and models from the project
import { RequestInterface } from "../interfaces";

// Importing axios for making HTTP requests
import ConfigFilterInputModel from "../models/api-models/config-filter-input.model";
import { ConfigModel, ReturnMessageModel } from "../models";
import ConfigInputModel from "../models/api-models/config-input.model";
import { ConfigRepository } from "../repositories";

@Service({ transient: true })
export class ConfigService {
  private readonly _configRepository: ConfigRepository;

  constructor() {
    this._configRepository = Container.get(ConfigRepository);
  }

  /**
   * Method to get Config messages based on filter criteria.
   * @param req - The request object containing user session information.
   * @param filter - The filter criteria for retrieving Config messages.
   * @returns A promise that resolves to an array of ConfigModel instances.
   */
  async getConfigs(
    req: RequestInterface,
    filter: ConfigFilterInputModel
  ): Promise<ConfigModel[]> {
    // Call the getConfigs method of ConfigRepository
    return await this._configRepository.getConfigs(filter);
  }

  /**
   * Method to create a new Config message.
   * @param req - The request object containing user session information.
   * @param body - The input model containing the Config message details.
   * @returns A promise that resolves to a ReturnMessageModel containing the created Config message.
   */
  async createConfig(
    req: RequestInterface,
    body: ConfigInputModel
  ): Promise<ConfigModel> {
    try {
      // Call the createConfig method of ConfigRepository which creates a new Config message
      const config = await this._configRepository.createConfig(body);

      // Return a success message with the created Config message
      return config;
    } catch (e) {
      console.log(e);
      throw new BusinessError("Error in Config service");
    }
  }

  /**
   * Method to update an existing Config message.
   * @param req - The request object containing user session information.
   * @param body - The input model containing the updated Config message details.
   * @param ConfigId - The ID of the Config message to be updated.
   * @returns A promise that resolves to the updated ConfigModel instance.
   */
  async updateConfig(
    req: RequestInterface,
    body: ConfigInputModel
  ): Promise<ConfigModel> {
    // Call the updateConfig method of ConfigRepository
    return await this._configRepository.updateConfig(body);
  }

  /**
   * Method to delete a Config message.
   * @param req - The request object containing user session information.
   * @param filter - The filter criteria for deleting Config messages.
   * @returns A promise that resolves to a ReturnMessageModel containing the deletion status message.
   */
  async deleteConfig(
    req: RequestInterface,
    filter: ConfigFilterInputModel
  ): Promise<ReturnMessageModel> {
    // Call the deleteConfig method of ConfigRepository which deletes a particular Config message by ID
    return await this._configRepository.deleteConfig(filter.id);
  }
}
