from sqlalchemy import Column, ForeignKey, DateTime
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
from startify.database.connection import Base
from datetime import datetime, timezone
import uuid

class Chat(Base):
    __tablename__ = 'chats'
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user1_id = Column(UUID(as_uuid=True), ForeignKey('users.id'))
    user2_id = Column(UUID(as_uuid=True), ForeignKey('users.id'))
    created_at = Column(DateTime, default=datetime.now(timezone.utc))

    user1 = relationship('User', back_populates='chats_user1', foreign_keys=[user1_id])
    user2 = relationship('User', back_populates='chats_user2', foreign_keys=[user2_id])
    messages = relationship('Message', back_populates='chat', cascade='all, delete')