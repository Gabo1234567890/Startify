import pytest
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from backend.main import app
from backend.startify.database.connection import Base, get_db

SQLALCHEMY_DATABASE_URL = "sqlite:///./test.db"

engine = create_engine(SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False})
TestingSessionLocal = sessionmaker(autoflush=False, bind=engine)

def override_get_db():
    try:
        db = TestingSessionLocal()
        yield db
    finally:
        db.close()

app.dependency_overrides[get_db] = override_get_db
Base.metadata.drop_all(bind=engine)
Base.metadata.create_all(bind=engine)
client = TestClient(app=app)

def test_successfull_register():
    response = client.post("/api/auth/register", json={"username": "testuser", "email": "test@example.com", "password": "securepass"})
    assert response.status_code == 200
    data = response.json()
    assert data["username"] == "testuser"
    assert data["email"] == "test@example.com"
    assert "id" in data

def test_register_existing_email():
    # Register first time
    response = client.post("/api/auth/register", json={
        "username": "user1",
        "email": "test@example.com",
        "password": "pass123"
    })

    assert response.status_code == 400
    assert response.json()["detail"] == "Email already registered"

def test_register_existing_username():
    response = client.post("/api/auth/register", json={
        "username": "testuser",
        "email": "userx@example.com",
        "password": "pass123"
    })

    assert response.status_code == 400
    assert response.json()["detail"] == "Username already taken"

def test_successful_login():
    response = client.post("/api/auth/login", json={
        "email": "test@example.com",
        "password": "securepass"
    })

    assert response.status_code == 200
    data = response.json()
    assert "access_token" in data
    assert data["email"] == "test@example.com"

def test_login_invalid_email():
    response = client.post("/api/auth/login", json={
        "email": "invalid@example.com",
        "password": "doesntmatter"
    })

    assert response.status_code == 401
    assert response.json()["detail"] == "Invalid credentials"

def test_login_wrong_password():
    response = client.post("/api/auth/login", json={
        "email": "test@example.com",
        "password": "wrong"
    })

    assert response.status_code == 401
    assert response.json()["detail"] == "Invalid credentials"
