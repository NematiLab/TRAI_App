# TRAI App

Demo code for TRAI: An AI-Driven Mobile Application to Reduce the Gap Between Triage and Care

This repository contains three main components:

- **Backend**: Built with Node.js, Express, and TypeScript, managing chat functionalities and config control like the triage note, patient history and the database via Prisma (using SQLite).
- **LLM Service**: A Python service that connects to a language model (Mistral AI or Claude) for processing.
- **Frontend**: A Flutter application that provides the user interface for the TRAI application.

## Running the Entire Application

Follow these steps to run the complete application. It is recommended to execute each component in a separate terminal window.

1. **Run the Backend**

   - Navigate to the `backend` directory:
     ```sh
     cd backend
     ```
   - Follow the steps in the [Backend README](./backend/README.md) to install dependencies, apply migrations, generate the Prisma client, and start the server:
     ```sh
     npm install
     npx prisma migrate dev
     npx prisma generate
     cp .env.sample .env  # Configure your environment variables
     npm run debug
     ```

2. **Run the LLM Service**

   - Open a new terminal window and navigate to the `llm_service` directory:
     ```sh
     cd llm_service
     ```
   - Follow the steps in the [LLM Service README](./llm_service/README.md) to set up and run the service:
     ```sh
     python -m venv venv
     source venv/bin/activate  # (or use the Windows equivalent)
     cp .env.sample .env  # Update the API key in the .env file as needed
     pip install -r requirements.txt
     python app.py
     ```

3. **Run the Frontend**

   - Open another terminal window and navigate to the `frontend` directory:
     ```sh
     cd frontend
     ```
   - Ensure that Flutter is installed on your device. For installation help, refer to the [Flutter installation guide](https://docs.flutter.dev/get-started/install).

   - Follow the steps in the [Frontend README](./frontend/README.md) to install dependencies and launch the application:
     ```sh
     flutter pub get
     cp .env.sample dev.env
     flutter run lib/main_development.dart
     ```

Ensure that the backend is running first, then start the LLM service and the frontend simultaneously to allow the complete application to function correctly.
