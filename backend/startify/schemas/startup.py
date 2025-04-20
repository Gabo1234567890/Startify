from pydantic import BaseModel
from datetime import datetime

class StartupBase(BaseModel):
    name: str
    desciption: str | None = None
    image_url: str | None = None

class StartupCreate(BaseModel):
    pass

class StartupResponse(BaseModel):
    id: int
    owner_id: int
    created_at: datetime

    class Config:
        orm_mode = True