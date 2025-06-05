from sqlalchemy import Column, ForeignKey, DateTime, String
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
from ..database.connection import Base
from datetime import datetime, timezone
import uuid

class Message(Base):
    __tablename__ = 'messages'
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    chat_id = Column(UUID(as_uuid=True), ForeignKey('chats.id'))
    sender_id = Column(UUID(as_uuid=True), ForeignKey('users.id'))
    content = Column(String, nullable=False)
    timestamp = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))

    chat = relationship('Chat', back_populates='messages')
    sender = relationship('User', back_populates='sent_messages', foreign_keys=[sender_id])