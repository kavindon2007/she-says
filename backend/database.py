import os
from pymongo import MongoClient
from dotenv import load_dotenv

load_dotenv()

MONGODB_URI = os.getenv("MONGODB_URI")

if not MONGODB_URI:
    print("ERROR: MONGODB_URI missing in .env", flush=True)
    # Fallback to Mock logic if needed, but per instructions we should fail or report
    raise ValueError("MONGODB_URI missing in .env")

import certifi

db = None

try:
    # Use a short timeout for the initial connection check
    # Using certifi for up-to-date certificate store
    client = MongoClient(
        MONGODB_URI, 
        serverSelectionTimeoutMS=5000, 
        tlsAllowInvalidCertificates=True,
        tlsCAFile=certifi.where()
    )
    # The ping command is cheap and does not require auth.
    client.admin.command('ping')
    db = client.get_database("shestays_db")
    
    users_collection = db.get_collection("users")
    students_collection = db.get_collection("students")
    interventions_collection = db.get_collection("interventions")
    institutions_collection = db.get_collection("institutions")
    classrooms_collection = db.get_collection("classrooms")
    
    # Create unique index for username
    users_collection.create_index("username", unique=True)
    users_collection.create_index("phone_number")
    
    print("SUCCESS: Connected to MongoDB Atlas (Database: shestays_db)", flush=True)

except Exception as e:
    print(f"WARNING: MongoDB connection failed: {e}", flush=True)
    print("FALLBACK: Initializing Mock Collections to prevent server crash.", flush=True)
    
    # Simple Mock objects to prevent the app from crashing when database is unreachable
    # Updated to support in-memory persistence for testing
    class MockResult:
        def __init__(self, **kwargs):
            self.__dict__.update(kwargs)

    class MockCollection:
        _storage = {} # Class-level storage to share data between instances

        def __init__(self, name="default"):
            self.name = name
            if name not in MockCollection._storage:
                MockCollection._storage[name] = []

        def find_one(self, filter, *args, **kwargs):
            # Special demo user for debugging when DB is down
            if self.name == "users":
                target_user = filter.get("username")
                if target_user and target_user.lower() == "admin":
                    return {
                        "username": "admin",
                        "password_hash": "$2b$12$w8wIre9BmzOcO1thbdIVIetbhTpJGUpcPzp5UE7y9PDoD9mJsUGnq", # Password123
                        "phone_number": "+919876543210",
                        "profile_type": "Admin"
                    }
            
            for item in MockCollection._storage[self.name]:
                match = True
                for k, v in filter.items():
                    if item.get(k) != v:
                        match = False; break
                if match: return item
            return None

        def insert_one(self, doc, *args, **kwargs):
            MockCollection._storage[self.name].append(doc)
            return MockResult(inserted_id='mock_id')

        def update_one(self, filter, update, *args, **kwargs):
            doc = self.find_one(filter)
            if doc and "$set" in update:
                doc.update(update["$set"])
            return MockResult(matched_count=1 if doc else 0)

        def delete_one(self, filter, *args, **kwargs):
            doc = self.find_one(filter)
            if doc:
                MockCollection._storage[self.name].remove(doc)
            return MockResult(deleted_count=1 if doc else 0)

        def find(self, filter={}, projection=None, *args, **kwargs):
            results = []
            for item in MockCollection._storage[self.name]:
                match = True
                for k, v in filter.items():
                    if item.get(k) != v:
                        match = False; break
                if match:
                    # Basic projection simulation (only _id check)
                    if projection and "_id" in projection and projection["_id"] == 0:
                        res = item.copy()
                        if "_id" in res: del res["_id"]
                        results.append(res)
                    else:
                        results.append(item)
            return results

        def create_index(self, *args, **kwargs): return None

    users_collection = MockCollection("users")
    students_collection = MockCollection("students")
    interventions_collection = MockCollection("interventions")
    institutions_collection = MockCollection("institutions")
    classrooms_collection = MockCollection("classrooms")

def get_db():
    return db