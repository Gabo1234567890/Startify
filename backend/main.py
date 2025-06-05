from fastapi import FastAPI
from startify.database.connection import engine, Base, get_db
from startify.routes import auth
from startify.routes import startup
from startify.routes import user
from startify.routes import chat


import os

# If TESTING is set, use the test override
TESTING = os.getenv("TESTING", "").lower() == "true"

app = FastAPI()

# Only import override if in test mode
if TESTING:
    from sqlalchemy import create_engine
    from sqlalchemy.orm import sessionmaker

    TEST_DB_URL = "sqlite:///./test.db"
    test_engine = create_engine(TEST_DB_URL, connect_args={"check_same_thread": False})
    TestingSessionLocal = sessionmaker(autoflush=False, bind=test_engine)

    def override_get_db():
        try:
            db = TestingSessionLocal()
            yield db
        finally:
            db.close()

    # Override BEFORE route registration
    app.dependency_overrides[get_db] = override_get_db
    Base.metadata.drop_all(bind=test_engine)
    Base.metadata.create_all(bind=test_engine)
else:
    # Production: use original engine
    Base.metadata.create_all(bind=engine)

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
app.include_router(chat.router, prefix="/api/chats", tags=["Chat"])


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