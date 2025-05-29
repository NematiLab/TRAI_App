// Mapping interface for mapping objects from one type to another
export interface IMapper<T, U> {
    map(source: T): U;
    mapArray(sourceArray: T[]): U[];
}
