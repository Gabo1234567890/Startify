from pydantic import BaseModel
from datetime import datetime
from uuid import UUID

class ChatResponse(BaseModel):
    id: UUID
    user1_id: UUID
    user2_id: UUID
    created_at: datetime

    class Config:
        orm_mode = True

class CreateChatRequest(BaseModel):
    user_id: UUID