// Importing Container and Service from typedi for dependency injection
import Container, { Service } from "typedi";

// Importing the necessary models from the project
import { ConfigModel, ReturnMessageModel } from "../models";

// Importing dbContext for database operations
import { dbContext } from "./db-context";

// Importing the ConfigMapper for mapping Config data
import { ConfigMapper } from "./db-model-mappers";
import ConfigFilterInputModel from "../models/api-models/config-filter-input.model";
import ConfigInputModel from "../models/api-models/config-input.model";

@Service({ transient: true })
export class ConfigRepository {
  private readonly _configMapper: ConfigMapper;

  constructor() {
    this._configMapper = Container.get(ConfigMapper);
  }

  /**
   * Method to get Config messages based on filter criteria.
   * @param filter - The filter criteria for retrieving Config messages.
   * @returns A promise that resolves to an array of ConfigModel instances.
   */
  async getConfigs(filter: ConfigFilterInputModel): Promise<ConfigModel[]> {
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

    // Querying the database to find Config messages based on the filter criteria
    const Configs: any = await dbContext.prisma.config.findMany({
      where: query,
      orderBy: sort,
    });

    // Mapping the raw Config data to ConfigModel instances and returning them
    return this._configMapper.mapArray(Configs);
  }

  /**
   * Method to create a new Config message.
   * @param body - The input model containing the Config message details.
   * @returns A promise that resolves to the created ConfigModel instance.
   */
  async createConfig(body: ConfigInputModel): Promise<ConfigModel> {
    // Generating the input object for the database operation
    const inputData = await this._generateInputObject(body);

    // Creating a new Config message in the database
    const Config = await dbContext.prisma.config.create({
      data: inputData,
    });

    // Mapping the raw Config data to a ConfigModel instance and returning it
    return this._configMapper.map(Config);
  }

  /**
   * Method to update an existing Config message.
   * @param body - The input model containing the updated Config message details.
   * @param ConfigId - The ID of the Config message to be updated.
   * @returns A promise that resolves to the updated ConfigModel instance.
   */
  async updateConfig(body: ConfigInputModel): Promise<ConfigModel> {
    // Generating the input object for the database operation
    const inputData = await this._generateInputObject(body);

    // Updating the Config message in the database
    const Config = await dbContext.prisma.config.update({
      where: {
        id: body.id,
      },
      data: inputData,
    });

    // Mapping the raw Config data to a ConfigModel instance and returning it
    return this._configMapper.map(Config);
  }

  /**
   * Method to delete a Config message by its ID.
   * @param ConfigId - The ID of the Config message to be deleted.
   * @returns A promise that resolves to a ReturnMessageModel containing the deletion status message.
   */
  async deleteConfig(ConfigId: number): Promise<ReturnMessageModel> {
    // Deleting the Config message from the database
    const Config = await dbContext.prisma.config.delete({
      where: {
        id: ConfigId,
      },
    });

    // Returning a success message if the Config was deleted, otherwise a not found message
    if (Config) {
      return {
        message: "Config deleted successfully",
      };
    }

    return {
      message: "Config not found",
    };
  }

  /**
   * Private method to generate the input object for database operations.
   * @param body - The input model containing the Config message details.
   * @returns The generated input object.
   */
  private async _generateInputObject(body: ConfigInputModel) {
    // Creating the input object with the provided Config message details
    let inputData: any = {
      patientHistory: body.patientHistory,
      patientName: body.patientName,
      triageNote: body.triageNote,
      updatedAt: new Date(),
    };

    // Returning the generated input object
    return inputData;
  }
}
