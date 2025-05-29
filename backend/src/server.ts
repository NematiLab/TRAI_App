// Importing express for creating the server
import express from "express";

// Importing reflect-metadata for enabling decorators
import "reflect-metadata";

// Importing functions from routing-controllers for creating the server and using dependency injection container
import { createExpressServer, useContainer } from "routing-controllers";

// Importing typedi for dependency injection
import Container from "typedi";

// Importing custom middlewares for authentication and exception handling
import { ExceptionHandlerMiddleware } from "./middlewares/exception-handler.middleware";

(async () => {
  // Setting typedi as the dependency injection container for routing-controllers
  useContainer(Container);

  // Creating an Express server with routing-controllers
  const app: any = createExpressServer({
    cors: true, // Enabling CORS
    routePrefix: "/api", // Setting the route prefix for all controllers
    controllers: [__dirname + "/controllers/*.js"], // Loading all controllers from the controllers directory
    middlewares: [ExceptionHandlerMiddleware], // Adding custom middlewares
    defaultErrorHandler: false, // Disabling the default error handler
  });

  // Express configuration
  app.set("port", process.env.PORT || 3000); // Setting the port for the server
  app.use(express.json()); // Enabling JSON body parsing
  app.use(express.urlencoded({ extended: true })); // Enabling URL-encoded body parsing

  // Handling unhandled promise rejections
  process.on("unhandledRejection", (error: Error) => {
    throw error;
  });

  // handle uncaught exception
  process.on("uncaughtException", (error: Error) => {
    console.log(error);
  });

  /**
   * Start Express server.
   */
  console.log("process.env.NODE_ENV", process.env.NODE_ENV);
  const server = app.listen(app.get("port"), "0.0.0.0", () => {
    console.log(
      "App is running at http://localhost:%d in %s mode",
      app.get("port"),
      app.get("env")
    );
    console.log("Press CTRL-C to stop\n");
  });

  // Returning the server and app instances
  return { server, app };
})();
