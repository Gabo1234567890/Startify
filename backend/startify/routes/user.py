from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from ..schemas.user import UserProfile, ProfileUpdate, UserOut
from ..models.user import User
from ..utils.security import get_current_user
from ..database.connection import get_db

router = APIRouter()

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
def get_users(
    skip: int = Query(0),
    limit: int = Query(10),
    search: str = Query("", description="Search by username"),
    db: Session = Depends(get_db)
):
    query = db.query(User)

    if search:
        query = query.filter(User.username.ilike(f"%{search}%"))
    return query.offset(skip).limit(limit).all()