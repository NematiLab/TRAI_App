# Imports
import os
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List, Dict, Union
import json
import uvicorn
from config import Config
from mistralai import Mistral
import requests

# Initialize FastAPI app
app = FastAPI()

# Load the configuration
cfg = Config()

# Define the Message model for user input
class Message(BaseModel):
    role: str
    content: str

# Define the UserInput model for the API request body
class UserInput(BaseModel):
    messages: List[Message]
    promptType: str
    
# Initialize the Mistral client with the API key from the configuration
client = Mistral(api_key=cfg.MISTRAL_API_KEY)

# Function to load the system prompt from the file
def load_system_prompt(prompt_type: str) -> str:
    """
    A utility function to load system to the Claude API
    """
    
    try:
        with open(os.path.join(os.getcwd(), f"{prompt_type}.txt"), "r") as f:
            system_prompt = f.read()
        return system_prompt
    except FileNotFoundError:
        raise HTTPException(status_code=500, detail="System prompt file not found!")

# Define the API endpoint for chat response
@app.post("/api/v1/chat_response")
async def get_chat_response(user_input: UserInput) -> Dict:
    """
    A POST API endpoint that accepts user_input and returns the result from the model.
    By default, this uses the Mistral AI model.
    """
    try:
        system_prompt = load_system_prompt(user_input.promptType)
    except Exception as e:
        return e

    # Prepend system prompt as a system message if needed
    messages = [{"role": "system", "content": system_prompt}]
    messages += [{"role": message.role, "content": message.content} for message in user_input.messages]

    try:
        # Call Mistral AI using the python client
        mistral_response = client.chat.complete(
            model="mistral-large-latest",
            messages=messages
        )
        
        print(f"Mistral response: {mistral_response}")
        
        # Assuming the API returns choices and each choice contains a message with content.
        response_body = mistral_response.choices[0].message.content
        
        print(f"Response body: {response_body}")
        return {"response": response_body}

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"An error occurred: {str(e)}")

# Define a health check endpoint
@app.get("w")
def health_check():
    print("Health check successful!")
    return {"status": "ok"}

# Run the FastAPI app with Uvicorn
if __name__ == "__main__":
    uvicorn.run("app:app", host=cfg.IP_ADDR, port=cfg.PORT, reload=cfg.RELOAD)
