from fastapi import APIRouter, Depends, Query
from sqlalchemy.orm import Session
from startify.database.connection import get_db
from startify.models.user import User
from startify.models.startup import Startup
from startify.schemas.startup import StartupResponse
from startify.utils.security import get_current_user

router = APIRouter()

@router.get("/startups/my", response_model=list[StartupResponse])
def get_my_startups(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
    search: str = Query("", description="Search by name")
):
    query = db.query(Startup).filter(Startup.user_id == current_user.id)
    if search:
        query = query.filter(Startup.name.ilike(f"%{search}%"))
    return query.all()

@router.get("/startups", response_model=list[StartupResponse])
def get_startups(
    skip: int = Query(0),
    limit: int = Query(10),
    search: str = Query("", description="Search by name"),
    db: Session = Depends(get_db)
):
    query = db.query(Startup)

    if search:
        query = query.filter(Startup.name.ilike(f"%{search}%"))
    return query.offset(skip).limit(limit).all()