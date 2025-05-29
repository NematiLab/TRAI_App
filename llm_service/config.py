import os
from dotenv import load_dotenv

class Config:
    def __init__(self):
        # FastAPI App Specific
        self.IP_ADDR = "localhost"
        self.PORT = 8000
        self.RELOAD = True
        
        # Paths        
        self.curr_path = os.getcwd()
        self.prompt_path = os.path.join(self.curr_path, "prompt.txt")
        
        # BedRock/Claude Specific
        self.MAX_TOKENS: int = 1500
        self.ANTHROPIC_VERSION: str = "bedrock-2023-05-31"
        self.MODEL_ID: str = "anthropic.claude-3-5-sonnet-20240620-v1:0"

        self.MAX_HISTORY_LENGTH: int = 10000
        
        load_dotenv()
        self.MISTRAL_API_KEY: str = os.getenv("MISTRAL_API_KEY")
