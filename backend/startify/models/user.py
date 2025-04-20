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