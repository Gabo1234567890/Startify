from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session, aliased
from startify.database.connection import get_db
from startify.models.user import User
from startify.models.chat import Chat
from startify.models.message import Message
from startify.schemas.chat import ChatResponse, CreateChatRequest
from startify.schemas.message import MessageCreate
from startify.schemas.message import MessageResponse
from startify.utils.security import get_current_user
from uuid import UUID

router = APIRouter()

@router.get("/chats", response_model=list[ChatResponse])
def get_user_chats(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
    search: str = Query("", description="Search by name")
):
    user1 = aliased(User)
    query = db.query(Chat).join(user1, Chat.user1_id == user1.id).filter((Chat.user2_id == current_user.id) | (Chat.user1_id == current_user.id))
    if search:
        query = query.filter(user1.username.ilike(f"%{search}%"))
    return query.all()

@router.post("/chats", response_model=ChatResponse)
def create_chat(request: CreateChatRequest, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    existing_chat = (
        db.query(Chat)
        .filter(
            ((Chat.user1_id == current_user.id) & (Chat.user2_id == request.user_id))
            | ((Chat.user1_id == request.user_id) & (Chat.user2_id == current_user.id))).first()
    )
    if existing_chat:
        return existing_chat
    
    new_chat = Chat(user1_id=request.user_id, user2_id=current_user.id)
    db.add(new_chat)
    db.commit()
    db.refresh(new_chat)
    return new_chat

@router.get("/chats/{chat_id}/messages", response_model=list[MessageResponse])
def get_chat_messages(chat_id: UUID, db: Session = Depends(get_db)):
    return db.query(Message).filter(Message.chat_id == chat_id).order_by(Message.timestamp.desc()).all()

@router.post("/chats/{chat_id}/messages", response_model=MessageResponse)
def send_messages(chat_id: UUID, message: MessageCreate, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    chat = db.query(Chat).filter(Chat.id == chat_id).first()
    if not chat:
        raise HTTPException(status_code=404, detail="Chat not found")
    if current_user.id not in [chat.user1_id, chat.user2_id]:
        raise HTTPException(status_code=403, detail="You are not part of this chat")
    
    db_message = Message(chat_id=chat_id, sender_id = current_user.id, content = message.content)
    db.add(db_message)
    db.commit()
    db.refresh(db_message)
    return db_message