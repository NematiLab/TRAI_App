# TRAI App LLM Service

This service provides a connection to a language model, in this case using [Mistral AI](https://mistral.ai/). The main function in this service initializes and manages the connection to the LLM, allowing your application to interact with it seamlessly. Additionally, the service includes a configuration module (`config.py`) which provides the necessary configuration for the application, and a sepsis agent prompt that the LLM utilizes to perform its tasks. For even better results, it's recommended to try using Claude.

## File Structure

- **.env**  
  Contains environment variables needed to run the service (such as the API key for Mistral AI).
- **.env.sample**  
  A sample environment file you can copy from to create your own `.env` file.
- **requirements.txt**  
  Lists all the Python dependencies required for the application.
- **app.py**  
  Implements the main function that connects to Mistral AI and handles the service logic.
- **config.py**  
  Provides configuration settings needed for the application.
- **sepsis_agent_prompt.txt** (or similar)  
  Contains the prompt that the LLM utilizes to perform the required tasks.

## Setup and Running the Service

Follow these steps to set up and run the service:

1. **Create the Environment**  
   Create a new virtual environment to isolate your dependencies. For example:

   ```sh
   python -m venv venv
   ```

2. **Activate the Environment**

   - On macOS/Linux:
     ```sh
     source venv/bin/activate
     ```
   - On Windows:
     ```sh
     .\venv\Scripts\activate
     ```

3. **Obtain the API Key from Mistral AI**

   - Visit [Mistral API Keys](https://console.mistral.ai/api-keys) to generate your API key.

4. **Configure the Environment Variables**

   - Copy the sample file to create your own `.env`:
     ```sh
     cp .env.sample .env
     ```
   - Open the `.env` file and replace the placeholder value for the API key with the one you obtained:
     ```dotenv
     # .env
     MISTRAL_API_KEY=your_generated_api_key_here
     ```

5. **Install Dependencies**  
   With your virtual environment active, run:

   ```sh
   pip install -r requirements.txt
   ```

6. **Run the Application**  
   Finally, start the application by running its entry point:
   ```sh
   python app.py
   ```

## Additional Notes

- Make sure you have Python installed.
- Review the `config.py` file for details on the configuration needed for the application.
- The sepsis agent prompt provides the instructions for the LLM to perform its tasks, so feel free to update it as needed.
- For troubleshooting or updates, refer to the inline comments within the source files.
