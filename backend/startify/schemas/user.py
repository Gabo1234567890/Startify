from pydantic import BaseModel, EmailStr, ConfigDict
from uuid import UUID

class UserCreate(BaseModel):
    username: str
    email: EmailStr
    password: str

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class UserResponse(BaseModel):
    id: UUID
    username: str
    email: EmailStr

    model_config = ConfigDict(from_attributes=True)

class UserProfile(BaseModel):
    username: str
    bio: str | None = None
    email: EmailStr

    model_config = ConfigDict(from_attributes=True)

class ProfileUpdate(BaseModel):
    bio: str | None = None

class UserOut(BaseModel):
    id: UUID
    username: str
    bio: str | None = None

    model_config = ConfigDict(from_attributes=True)

class LoginResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"
    id: UUID
    username: str
    email: EmailStr