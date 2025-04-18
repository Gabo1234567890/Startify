from fastapi import FastAPI
from startify.database.connection import engine, Base
from startify.routes import auth

Base.metadata.create_all(bind=engine)

app = FastAPI()
app.include_router(auth.router, tags=["Auth"])