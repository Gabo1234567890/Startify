from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from startify.schemas.user import UserCreate, UserLogin, UserResponse, UserProfile, ProfileUpdate, UserOut
from startify.models.user import User
from startify.utils.security import hash_password, verify_password, create_access_token, get_current_user
from startify.database.connection import get_db

router = APIRouter()

@router.post("/register", response_model=UserResponse)
def register(user: UserCreate, db: Session = Depends(get_db)):
    if db.query(User).filter(User.email == user.email).first():
        raise HTTPException(status_code=400, detail="Email already registered")
    
    if db.query(User).filter(User.username == user.username).first():
        raise HTTPException(status_code=400, detail="Username already taken")
    
    hashed_pw = hash_password(user.password)
    new_user = User(username=user.username, email=user.email, hashed_password=hashed_pw)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

@router.post("/login")
def login(user: UserLogin, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.email == user.email).first()
    if not db_user or not verify_password(user.password, db_user.hashed_password):
        raise HTTPException(status_code=401, detail="Invalid credentials")
    
    access_token = create_access_token(data={"username": db_user.username})
    return {"access_token": access_token, "token_type": "bearer"}

@router.get("/me", response_model=UserProfile)
def get_me_user(current_user: User = Depends(get_current_user)):
    return current_user

@router.put("/me", response_model=UserProfile)
def update_me(update: ProfileUpdate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if update.bio is not None:
        current_user.bio = update.bio
    db.commit()
    db.refresh(current_user)
    return current_user

@router.get("/users", response_model=list[UserOut])
def get_users(skip: int = Query(0), limit: int = Query(10), db: Session = Depends(get_db)):
    return db.query(User).offset(skip).limit(limit).all()