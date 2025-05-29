# TRAI App Backend Node

## Overview

This project is the backend for the TRAI application, providing the backend logic for chat functionalities. It is built using Node.js, Express, and TypeScript while following a structured architecture to ensure separation of concerns, maintainability, and scalability. The database is managed via Prisma using SQLite.

## Features

- **Chat**: Manages chat messages between users and the chatbot – including message storage, retrieval, and business logic processing.
- **Config**: Stores default configuration values such as the triage note and patient history, making them easily accessible throughout the application.

## Project Structure

The project is organized into several directories, each serving a distinct purpose:

- **controllers**: Handles routes and HTTP requests.
- **services**: Contains the business logic and interacts with repositories.
- **repositories**: Performs database operations and data access.
  - **db-model-mappers**: Converts database models to domain models.
- **models**:
  - **api-models**: Defines input structures for API requests.
  - **domain-models**: Defines output models for API responses.
- **middlewares**: Contains middleware for authentication and error handling.
- **utils**: Utility functions used across the application.
- **custom-errors**: Defines custom error classes for specific status codes.
- **schema.prisma**: The Prisma schema file defining the database models and migrations.
- **server.ts**: Initializes the server and sets up routing, middleware, and dependency injection.

## Brief Documentation

### Controllers

- **chat.controller.ts**: Manages routes for chat functionalities.
- **config.controller.ts**: Handles routes for retrieving and updating configuration values.

### Services

- **chat.service.ts**: Implements the business logic for handling chat functionalities.
- **config.service.ts**: Implements logic for retrieving default configuration values such as the triage note and patient history.

### Repositories

- **chat.repository.ts**: Handles database operations for chat messages.
- **config.repository.ts**: Handles database operations for configuration values.
- **db-model-mappers**: Contains mappers that convert database models to domain models.

### Models

- **api-models**: Defines input models for API requests.
- **domain-models**: Defines output models for API responses.

### Middlewares

- **exception-handler.middleware.ts**: Handles exceptions using custom error classes.

### Custom Errors

- **business.error.ts**: Custom error class for business logic errors.
- **not-found.error.ts**: Custom error class for "not found" errors.
- **permission.error.ts**: Custom error class for permission-related errors.

### Server Initialization

- **server.ts**: Bootstraps the server, sets up routing, middleware, and dependency injection.

### Database Schema

- **schema.prisma**: Defines the database schema, models, and migrations for Prisma using SQLite.

## Getting Started

1. **Install dependencies**  
   Install the necessary Node.js packages:

   ```sh
   npm install
   ```

2. **Run Prisma Migrations**  
   Apply the database migrations using Prisma:

   ```sh
   npx prisma migrate dev
   ```

3. **Generate Prisma Client**  
   Generate the Prisma client to be used in the project:

   ```sh
   npx prisma generate
   ```

4. **Configure the Environment Variables**

   - Copy the sample file to create your own `.env`:
     ```sh
     cp .env.sample .env
     ```

5. **Run the Application**  
   Start the server in debug mode:
   ```sh
   npm run debug
   ```

## Conclusion

This backend project for the TRAI App is designed with a focus on clean code organization and scalability. With the database powered by Prisma using SQLite, a clear separation between controllers, services, repositories, and middleware, and the introduction of a config feature for default values like the triage note and patient history, the project is both maintainable and easy to extend.
