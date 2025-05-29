// Importing the Service decorator from typedi for dependency injection
import { Service } from "typedi";

// Importing the necessary models from the project
import { ConfigModel } from "../../models";
import { BaseMapper } from "./base-mapper";

@Service({ transient: true })
export class ConfigMapper extends BaseMapper<any, ConfigModel> {
  /**
   * Maps the raw Config data to the ConfigModel.
   * @param Config - The raw Config data to be mapped.
   * @returns The mapped ConfigModel instance.
   */
  map(config: any): ConfigModel {
    // Creating a new instance of ConfigModel
    const configModel = new ConfigModel();

    // Mapping properties from the raw Config data to the ConfigModel instance
    configModel.id = config.id;
    configModel.patientHistory = config.patientHistory;
    configModel.patientName = config.patientName;
    configModel.triageNote = config.triageNote;

    // Returning the mapped ConfigModel instance
    return configModel;
  }
}
