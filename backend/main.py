from fastapi import FastAPI
from .startify.database.connection import engine, Base
from .startify.routes import auth
from .startify.routes import startup
from .startify.routes import user
from .startify.routes import chat

Base.metadata.create_all(bind=engine)

app = FastAPI()

# Add these new endpoints
@app.get("/", tags=["Root"])
async def root():
    return {
        "message": "Welcome to the Startify API",
        "endpoints": {
            "documentation": "/docs",
            "health_check": "/health",
            "auth": "/api/auth/",
            "startups": "/api/startups/",
            "users": "/api/users/",
            "chat": "/api/chat/"
        }
    }

@app.get("/health", tags=["Health"])
async def health_check():
    return {"status": "OK", "database": "Connected"}

# Include your existing routers
# Added prefixes for better API structure
app.include_router(auth.router, prefix="/api/auth", tags=["Auth"])
app.include_router(startup.router, prefix="/api/startups", tags=["Startups"])
app.include_router(user.router, prefix="/api/users", tags=["User"])
app.include_router(chat.router, prefix="/api/chat", tags=["Chat"])


# from fastapi import FastAPI
# from startify.database.connection import engine, Base
# from startify.routes import auth
# from startify.routes import startup
# from startify.routes import user
# from startify.routes import chat

# Base.metadata.create_all(bind=engine)

# app = FastAPI()
# app.include_router(auth.router, tags=["Auth"])
# app.include_router(startup.router, tags=["Startups"])
# app.include_router(user.router, tags=["User"])
# app.include_router(chat.router, tags=["Chat"])