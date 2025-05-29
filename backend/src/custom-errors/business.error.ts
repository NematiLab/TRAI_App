// Custom Business Error class created to handle business errors in the application with status code 400
export class BusinessError extends Error {
  // Private member to hold the value of isBusinessError
  private _isBusinessError: boolean;

  get isBusinessError(): boolean {
    return this._isBusinessError;
  }

  // Constructor to create an instance of BusinessError
  constructor(message: string) {
    super(message);
    this._isBusinessError = true;
  }
}
