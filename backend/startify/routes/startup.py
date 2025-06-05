from fastapi import APIRouter, Depends, Query, HTTPException
from sqlalchemy.orm import Session
from ..database.connection import get_db
from ..models.user import User
from ..models.startup import Startup
from ..schemas.startup import StartupResponse, StartupCreate
from ..utils.security import get_current_user
from uuid import UUID

router = APIRouter()

@router.get("/my", response_model=list[StartupResponse])
def get_my_startups(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
    search: str = Query("", description="Search by name")
):
    query = db.query(Startup).filter(Startup.user_id == current_user.id)
    if search:
        query = query.filter(Startup.name.ilike(f"%{search}%"))
    return query.all()

@router.get("", response_model=list[StartupResponse])
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


@router.post("", response_model=StartupResponse)
def create_startup(startup: StartupCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    new_startup = Startup(
        user_id=current_user.id,
        name=startup.name,
        description=startup.description,
        goal_amount=startup.goal_amount
    )
    db.add(new_startup)
    db.commit()
    db.refresh(new_startup)
    return new_startup

@router.get("/{startup_id}", response_model=StartupResponse)
def get_startup(startup_id: UUID, db: Session = Depends(get_db)):
    startup = db.query(Startup).filter(Startup.id == startup_id).first()
    if not startup:
        raise HTTPException(status_code=404, detail="Startup not found")
    return startup

@router.delete("/{startup_id}")
def delete_startup(startup_id: UUID, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    startup = db.query(Startup).filter(Startup.id == startup_id, Startup.user_id == current_user.id).first()
    if not startup:
        raise HTTPException(status_code=404, detail="Startup not found")
    db.delete(startup)
    db.commit()
    return {"message": "Startup deleted successfully"}