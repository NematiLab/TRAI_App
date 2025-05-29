// Mapper for mapping database models to domain models and vice versa
import { Service } from "typedi";
import { IMapper } from "../../interfaces";

// Base mapper class for mapping objects from one type to another
@Service({ transient: true })
export abstract class BaseMapper<T, U> implements IMapper<T, U> {
  abstract map(source: T): U;

  // Maps an array of objects from one type to another
  mapArray(sourceArray: T[]): U[] {
    return sourceArray.map(this.map.bind(this));
  }
}
