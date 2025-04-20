from fastapi import FastAPI
from startify.database.connection import engine, Base
from startify.routes import auth
from startify.routes import startup

Base.metadata.create_all(bind=engine)

app = FastAPI()
app.include_router(auth.router, tags=["Auth"])
app.include_router(startup.router, tags=["Startups"])