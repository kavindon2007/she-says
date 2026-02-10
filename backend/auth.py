import os
import jwt
import time
from datetime import datetime, timedelta
from typing import Optional
import bcrypt
from dotenv import load_dotenv

load_dotenv()

# Password hashing configuration (using direct bcrypt)

# JWT configuration
SECRET_KEY = os.getenv("JWT_SECRET", "supersecretkey")
ALGORITHM = os.getenv("ALGORITHM", "HS256")
ACCESS_TOKEN_EXPIRE_MINUTES = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES", 1440))

# Simple in-memory rate limiter
# { username: { "attempts": count, "locked_until": timestamp } }
login_attempts = {}

def hash_password(password: str) -> str:
    # bcrypt expects bytes. salt is generated automatically.
    salt = bcrypt.gensalt()
    hashed = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed.decode('utf-8')

def verify_password(plain_password: str, hashed_password: str) -> bool:
    try:
        # Checkpw expects bytes for both arguments
        return bcrypt.checkpw(
            plain_password.encode('utf-8'), 
            hashed_password.encode('utf-8')
        )
    except Exception:
        return False

def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def check_rate_limit(username: str) -> Optional[str]:
    now = time.time()
    if username in login_attempts:
        record = login_attempts[username]
        if record["locked_until"] > now:
            remaining = int(record["locked_until"] - now)
            return f"Too many failed attempts. Please try again in {remaining // 60 + 1} minutes."
        
        # Reset if lock period expired
        if record["locked_until"] > 0:
            login_attempts[username] = {"attempts": 0, "locked_until": 0}
            
    return None

def record_failed_attempt(username: str):
    now = time.time()
    if username not in login_attempts:
        login_attempts[username] = {"attempts": 1, "locked_until": 0}
    else:
        login_attempts[username]["attempts"] += 1
        if login_attempts[username]["attempts"] >= 5:
            # Lock for 15 minutes
            login_attempts[username]["locked_until"] = now + (15 * 60)

def reset_attempts(username: str):
    if username in login_attempts:
        login_attempts[username] = {"attempts": 0, "locked_until": 0}

def decode_access_token(token: str) -> Optional[dict]:
    try:
        decoded_token = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return decoded_token if decoded_token["exp"] >= time.time() else None
    except jwt.PyJWTError:
        return None
