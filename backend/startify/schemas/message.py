from pydantic import BaseModel, ConfigDict
from datetime import datetime
from uuid import UUID

class MessageCreate(BaseModel):
    chat_id: UUID
    content: str

class MessageResponse(BaseModel):
    id: UUID
    chat_id: UUID
    sender_id: UUID
    content: str
    timestamp: datetime

    model_config = ConfigDict(from_attributes=True)