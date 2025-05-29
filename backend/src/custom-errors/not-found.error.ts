// Custom NotFound Error class created to handle not found errors in the application with status code 404
export class NotFoundError extends Error {
    // Private member to hold the value of isNotFoundError
    private _isNotFoundError: boolean;

    get isNotFoundError(): boolean {
        return this._isNotFoundError;
    }

    // Constructor to create an instance of NotFoundError
    constructor(message: string) {
        super(message);

        this._isNotFoundError = true;
    }
}
