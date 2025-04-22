from fastapi import FastAPI
from startify.database.connection import engine, Base
from startify.routes import auth
from startify.routes import startup
from startify.routes import user
from startify.routes import chat

Base.metadata.create_all(bind=engine)

app = FastAPI()
app.include_router(auth.router, tags=["Auth"])
app.include_router(startup.router, tags=["Startups"])
app.include_router(user.router, tags=["User"])
app.include_router(chat.router, tags=["Chat"])