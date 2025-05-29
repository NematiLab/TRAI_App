// Importing Joi for validation error handling
import Joi from "joi";

// Importing necessary interfaces and decorators from routing-controllers and typedi
import {
  ExpressErrorMiddlewareInterface,
  Middleware,
} from "routing-controllers";
import { Service } from "typedi";

// Importing custom error classes for handling specific types of errors
import {
  BusinessError,
  NotFoundError,
  PermissionError,
} from "../custom-errors";

// Middleware decorator to define this class as an error-handling middleware
@Middleware({ type: "after" })
@Service()
export class ExceptionHandlerMiddleware
  implements ExpressErrorMiddlewareInterface
{
  /**
   * Error handling middleware function.
   * @param error - The error object thrown in the application.
   * @param request - The request object.
   * @param response - The response object.
   * @param next - The next middleware function in the stack.
   */
  error(
    error: any,
    request: any,
    response: any,
    next: (err?: any) => any
  ): void {
    // Check if the error is a PermissionError and send a 402 status code
    if ((<PermissionError>error).isPermissionError) {
      response.status(402).json({ message: error.message });
      return;
    }

    // Check if the error is a NotFoundError and send a 404 status code
    if ((<NotFoundError>error).isNotFoundError) {
      response.status(404).json({ message: error.message });
      return;
    }

    // Check if the error is a BusinessError and send a 400 status code
    if ((<BusinessError>error).isBusinessError) {
      response.status(400).json({ message: error.message });
      return;
    }

    // Check if the error is a Joi validation error and send a 400 status code
    if ((<Joi.ValidationError>error).isJoi) {
      response.status(400).json({ message: error });
      return;
    }

    // For all other errors, respond with the error status or 500 (Internal Server Error)
    response.status(error.status || 500);

    if (process.env.NODE_ENV !== "production") {
      response.json({
        message: error.message,
        stack: error.stack,
      });
    } else {
      response.json({
        message: "An error occured.",
      });
    }

    // Call the next middleware function in the stack
    next();
  }
}
