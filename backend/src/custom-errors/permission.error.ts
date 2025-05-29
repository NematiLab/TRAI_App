// Custom Permission Error class created to handle permission errors in the application with status code 402
export class PermissionError extends Error {
    get isPermissionError(): boolean {
        return true;
    }

    // Constructor to create an instance of PermissionError
    constructor(message: string) {
        super(message);
    }
}
