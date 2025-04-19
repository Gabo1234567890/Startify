from sqlalchemy import Column, Integer, String
from startify.database.connection import Base

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, nullable=False)
    email = Column(String, unique=True, nullable=False)
    bio = Column(String, nullable=True)
    hashed_password = Column(String, nullable=False)