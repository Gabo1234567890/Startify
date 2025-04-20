from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from startify.database.connection import get_db
from startify.models.user import User
from startify.models.startup import Startup
from startify.schemas.startup import StartupResponse
from startify.utils.security import get_current_user

router = APIRouter(prefix="/startups")

@router.get("/my", response_model=list[StartupResponse])
def get_my_startups(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return db.query(Startup).filter(Startup.user_id == current_user.id).all()