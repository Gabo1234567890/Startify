from pydantic import BaseModel
from datetime import datetime
from uuid import UUID

class StartupBase(BaseModel):
    name: str
    description: str | None = None
    image_url: str | None = None

class StartupCreate(BaseModel):
    name: str
    description: str | None = None
    goal_amount: int

class StartupResponse(BaseModel):
    id: UUID
    user_id: UUID
    name: str
    description: str | None = None
    goal_amount: int | None = 0
    raised_amount: int | None = 0
    created_at: datetime

    class Config:
        orm_mode = True