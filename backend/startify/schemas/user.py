from pydantic import BaseModel, EmailStr
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

    class Config:
        orm_mode = True

class UserProfile(BaseModel):
    username: str
    bio: str | None = None
    email: EmailStr

    class Config:
        orm_mode = True

class ProfileUpdate(BaseModel):
    bio: str | None = None

class UserOut(BaseModel):
    id: UUID
    username: str
    bio: str | None = None

    class Config:
        orm_mode = True

class LoginResponse(BaseModel):
    access_token: str
    token_type: str = "bearer"
    id: UUID
    username: str
    email: EmailStr