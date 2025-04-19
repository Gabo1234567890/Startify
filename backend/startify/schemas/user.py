from pydantic import BaseModel, EmailStr

class UserCreate(BaseModel):
    username: str
    email: EmailStr
    password: str

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class UserResponse(BaseModel):
    id: int
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