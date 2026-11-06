from pydantic import BaseModel

# try to convert input to validated string
class ChatBody(BaseModel):
    query: str
