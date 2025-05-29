# TRAI App Frontend Flutter

## Overview

This project is the frontend for the TRAI application. It is built using Flutter and follows a structured architecture to separate concerns and improve maintainability.

## Project Structure

The project is organized into several directories, each with a specific responsibility:

### lib

- **app**: Contains specific features of the application.

  - **home**: Manages the home chat screen and related functionalities.
    - **bloc**: Business logic components for the chat feature.
    - **data**: Models and services for the chat feature.
      - **model**: Models the data types for the chat feature.
      - **service**: Interacts with the API for the chat feature.
    - **view**: UI components for the home chat feature.
      - **screens**: Screens related to the home chat feature.
      - **widgets**: Widgets specific to the home chat feature.

  - **config**: Manages the config config screen and related functionalities.
    - **bloc**: Business logic components for the config feature.
    - **data**: Models and services for the config feature.
      - **model**: Models the data types for the config feature.
      - **service**: Interacts with the API for the config feature.
    - **view**: UI components for the config config feature.
      - **screens**: Screens related to the config config feature.
      - **widgets**: Widgets specific to the config config feature.

- **core**: Contains core dependencies and utilities.

  - **dependency_injection**: Manages dependency injection.
  - **routing**: Manages application routing.
  - **clients**: Contains clients for API interactions.
  - **shared_preference_manager**: Manages shared preferences.

- **design**: Stores design-related components such as themes and styles.

- **logger**: Provides logging functionalities for better debugging and monitoring.

- **config**: Contains configuration files and settings.

- **main.dart**: The entry point of the application.

### Setup

1. **Install dependencies**:
   ```
   flutter pub get
   ```

2. **Configure the Environment Variables**

   - Copy the sample file to create your own `dev.env`:
     ```sh
     cp .env.sample dev.env
     ```

3. **Run the application**:
   ```
   flutter run lib/main_development.dart 
   ```

### Conclusion

This frontend project for TRAI app is structured to ensure separation of concerns, maintainability, and scalability. Each component has a specific responsibility, making it easier to manage and extend the application.
