from sqlalchemy import Column, String
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
from startify.database.connection import Base
import uuid

class User(Base):
    __tablename__ = "users"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    username = Column(String, unique=True, nullable=False)
    email = Column(String, unique=True, nullable=False)
    bio = Column(String, nullable=True)
    hashed_password = Column(String, nullable=False)

    startups = relationship("Startup", back_populates="owner", cascade="all, delete")
    chats_user1 = relationship("Chat", back_populates="user1", foreign_keys="Chat.user1_id", cascade="all, delete")
    chats_user2 = relationship("Chat", back_populates="user2", foreign_keys="Chat.user2_id", cascade="all, delete")
    sent_messages = relationship("Message", back_populates="sender", foreign_keys="Message.sender_id", cascade="all, delete")