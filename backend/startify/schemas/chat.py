from pydantic import BaseModel, ConfigDict
from datetime import datetime
from uuid import UUID

class ChatResponse(BaseModel):
    id: UUID
    user1_id: UUID
    user2_id: UUID
    created_at: datetime

    model_config = ConfigDict(from_attributes=True)

class CreateChatRequest(BaseModel):
    user_id: UUID