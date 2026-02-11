import os
import re
import requests
import joblib
from datetime import datetime, timedelta
from collections import Counter
from fastapi import FastAPI, HTTPException, Body, Depends, Request
from fastapi.middleware.cors import CORSMiddleware
from pymongo import MongoClient
from dotenv import load_dotenv
from fastapi.security import OAuth2PasswordBearer
from auth import hash_password, verify_password, create_access_token, check_rate_limit, record_failed_attempt, reset_attempts, decode_access_token
from database import users_collection, students_collection, interventions_collection, institutions_collection, classrooms_collection
from ai_service import ai_service

load_dotenv()
# Database is now initialized and imported from database.py

# ----------- FASTAPI APP SETUP -----------

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="api/auth/login")

def get_current_user(token: str = Depends(oauth2_scheme)):
    payload = decode_access_token(token)
    if not payload:
        raise HTTPException(
            status_code=401,
            detail="Invalid or expired token",
            headers={"WWW-Authenticate": "Bearer"},
        )
    return payload

# ----------- TELEGRAM CONFIG -----------

TELEGRAM_TOKEN = "8530020315:AAEDA5oECzm6gF7FaqAiMJ_q55sWUx3wKJc"
TELEGRAM_CHAT_ID = "8494857908"   # your chat ID

def send_telegram_alert(student_name, risk, district):
    message = f"""
🚨 SheStays Official Alert

Student: {student_name}
Risk Level: {risk}
District: {district}

Ref ID: SS-{datetime.now().strftime('%H%M%S')}
Time: {datetime.now().strftime('%d-%b-%Y %H:%M')}
    """.strip()

    url = f"https://api.telegram.org/bot{TELEGRAM_TOKEN}/sendMessage"

    payload = {
        "chat_id": TELEGRAM_CHAT_ID,
        "text": message,
        "parse_mode": "HTML"
    }

    try:
        response = requests.post(url, json=payload)
        if response.status_code != 200:
            print("Telegram failed:", response.text)
        else:
            print("Telegram alert sent successfully")
    except Exception as e:
        print("Telegram alert failed:", e)

# ----------- LOAD AI MODEL (optional - commented if not needed) -----------

# print("Loading AI Model...")
# try:
#     import joblib
#     model = joblib.load("../ml_model/risk_model.pkl")
#     print("Model Loaded Successfully")
# except Exception as e:
#     print("Model loading failed:", e)
#     model = None

# ----------- AUTHENTICATION ROUTES -----------

@app.post("/api/auth/register")
def register(data: dict = Body(...)):
    username = data.get("username")
    password = data.get("password")
    phone = data.get("phone")
    profile_type = data.get("profile_type")

    # Basic Validation
    if not all([username, password, phone, profile_type]):
        raise HTTPException(status_code=400, detail="All fields are required")
    
    if len(password) < 8:
        raise HTTPException(status_code=400, detail="Password must be at least 8 characters")
    
    # Phone validation (10 digits starting with 6-9)
    if not re.match(r"^[6-9]\d{9}$", phone):
        raise HTTPException(status_code=400, detail="Invalid Indian phone number format")

    if profile_type not in ["Teacher", "Principal", "Admin", "Social Worker"]:
        raise HTTPException(status_code=400, detail="Invalid profile type")

    # Check if user exists
    if users_collection.find_one({"username": username}):
        raise HTTPException(status_code=400, detail="Username already exists")

    # Create User
    new_user = {
        "username": username,
        "password_hash": hash_password(password),
        "phone_number": f"+91{phone}",
        "profile_type": profile_type,
        "created_at": datetime.utcnow(),
        "last_login": datetime.utcnow()
    }
    
    users_collection.insert_one(new_user)
    
    # Generate Token
    access_token = create_access_token(data={"sub": username, "role": profile_type})
    return {"status": "success", "access_token": access_token, "token_type": "bearer"}

@app.post("/api/auth/login")
def login(data: dict = Body(...)):
    username = data.get("username")
    password = data.get("password")
    phone = data.get("phone")

    if not all([username, password, phone]):
        raise HTTPException(status_code=400, detail="Username, password, and phone number are required")

    # Check Rate Limit
    limit_msg = check_rate_limit(username)
    if limit_msg:
        raise HTTPException(status_code=429, detail=limit_msg)

    user = users_collection.find_one({"username": username})
    
    # Triple-Match Verification
    stored_phone = user["phone_number"] if user else ""
    phone_with_prefix = f"+91{phone}"
    
    pass_match = verify_password(password, user["password_hash"]) if user else False
    phone_match = (stored_phone == phone or stored_phone == phone_with_prefix) if user else False

    print(f"LOGIN DEBUG: user={username}, found={user is not None}, pass={pass_match}, phone={phone_match}, stored_p='{stored_phone}', input_p='{phone}'", flush=True)

    if not user or not pass_match or not phone_match:
        record_failed_attempt(username)
        raise HTTPException(status_code=401, detail="Invalid credentials. Please check your username, password, and phone number.")

    # Success
    reset_attempts(username)
    users_collection.update_one({"username": username}, {"$set": {"last_login": datetime.utcnow()}})
    
    access_token = create_access_token(data={"sub": username, "role": user["profile_type"]})
    return {"status": "success", "access_token": access_token, "token_type": "bearer"}

# ----------- PREDICTION ROUTE -----------

@app.post("/predict")
def predict(data: dict, current_user: dict = Depends(get_current_user)):
    # Extract fields (with defaults)
    student_name = data.get("name", "Unknown Student")
    district = data.get("district", "Unknown District")
    
    # You can keep simple rule-based risk for demo
    attendance = data.get("attendance", 0)
    marks = data.get("marks", 0)
    
    if attendance < 70 or marks < 50:
        risk = "High"
    else:
        risk = "Low"

    # Send Telegram alert if high risk
    if risk == "High":
        send_telegram_alert(student_name, risk, district)

    return {
        "student_name": student_name,
        "district": district,
        "predicted_risk": risk,
        "message": "High risk alert sent to Telegram" if risk == "High" else "No alert needed"
    }

# ----------- DASHBOARD STATS -----------

@app.get("/dashboard/stats")
def dashboard_stats(current_user: dict = Depends(get_current_user)):
    # Use real data from interventions for dashboard stats
    interventions = list(interventions_collection.find({}, {"_id": 0}))
    
    total = len(interventions)
    risk_levels = Counter([i.get("risk", "Unknown") for i in interventions])
    districts = Counter([i.get("district", "Unknown") for i in interventions])
    
    # If no data, use some realistic defaults or the existing mock structure
    if total == 0:
        return {
            "total_students": 7,
            "risk_distribution": {"High": 3, "Low": 3, "Medium": 1},
            "district_distribution": {"Colombo": 3, "Kandy": 2, "Galle": 1, "Jaffna": 1}
        }
    
    return {
        "total_students": total,
        "risk_distribution": dict(risk_levels),
        "district_distribution": dict(districts)
    }

# ----------- INTERVENTION TRACKING -----------

@app.post("/add_intervention")
def add_intervention(data: dict, current_user: dict = Depends(get_current_user)):
    student_name = data.get("student_name", "Unknown")
    risk = data.get("risk", "Low")
    district = data.get("district", "Unknown")

    data["date"] = datetime.now().strftime("%d-%m-%Y")
    interventions_collection.insert_one(data)
    
    # Actually trigger the Telegram alert for High Risk
    if risk == "High":
        send_telegram_alert(student_name, risk, district)
        
    return {"message": "Intervention stored and alert sent"}

@app.get("/interventions")
def get_interventions(current_user: dict = Depends(get_current_user)):
    data = list(interventions_collection.find({}, {"_id": 0}))
    return {"interventions": data}

# ----------- INSTITUTION MANAGEMENT -----------

@app.post("/api/institutions")
def create_institution(data: dict = Body(...), current_user: dict = Depends(get_current_user)):
    institution_name = data.get("institution_name")
    state = data.get("state")
    district = data.get("district")
    area_region = data.get("area_region")
    pincode = data.get("pincode")
    supervisor_name = data.get("supervisor_name")

    # Validation
    if not all([institution_name, state, district, area_region, pincode, supervisor_name]):
        raise HTTPException(status_code=400, detail="All fields are required")
    
    if not re.match(r"^[1-9][0-9]{5}$", pincode):
        raise HTTPException(status_code=400, detail="Invalid pincode format. Must be 6 digits.")
    
    if len(institution_name) < 3:
        raise HTTPException(status_code=400, detail="Institution name must be at least 3 characters")

    new_inst = {
        "institution_id": f"inst_{int(datetime.utcnow().timestamp())}",
        "institution_name": institution_name,
        "state": state,
        "district": district,
        "area_region": area_region,
        "pincode": pincode,
        "supervisor_name": supervisor_name,
        "created_by": current_user["sub"], # username from JWT
        "created_at": datetime.utcnow()
    }

    try:
        institutions_collection.insert_one(new_inst)
        # Remove _id for JSON response
        if "_id" in new_inst:
            del new_inst["_id"]
        return {
            "success": True,
            "message": "Institution created successfully",
            "data": new_inst
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

@app.get("/api/institutions")
def get_institutions(current_user: dict = Depends(get_current_user)):
    # In a real app, we might filter by current_user["sub"]
    # For this hackathon, we'll fetch all or filter as needed.
    # The prompt says "Fetch all institutions from backend"
    data = list(institutions_collection.find({}, {"_id": 0}))
    return data

@app.patch("/api/institutions/{inst_id}")
def update_institution(inst_id: str, data: dict = Body(...), current_user: dict = Depends(get_current_user)):
    # Basic validation if pincode or name is provided
    if "pincode" in data and not re.match(r"^[1-9][0-9]{5}$", data["pincode"]):
        raise HTTPException(status_code=400, detail="Invalid pincode format. Must be 6 digits.")
    
    if "institution_name" in data and len(data["institution_name"]) < 3:
        raise HTTPException(status_code=400, detail="Institution name must be at least 3 characters")

    # Update the record
    try:
        result = institutions_collection.update_one(
            {"institution_id": inst_id},
            {"$set": data}
        )
        
        if result.matched_count == 0:
            raise HTTPException(status_code=404, detail="Institution not found")
            
        updated_doc = institutions_collection.find_one({"institution_id": inst_id}, {"_id": 0})
        return {
            "success": True,
            "message": "Institution updated successfully",
            "data": updated_doc
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

@app.delete("/api/institutions/{inst_id}")
def delete_institution(inst_id: str, current_user: dict = Depends(get_current_user)):
    try:
        result = institutions_collection.delete_one({"institution_id": inst_id})
        if result.deleted_count == 0:
            raise HTTPException(status_code=404, detail="Institution not found")
            
        return {
            "success": True,
            "message": "Institution deleted successfully"
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

@app.post("/api/classrooms")
def create_classroom(data: dict = Body(...), current_user: dict = Depends(get_current_user)):
    institution_id = data.get("institution_id")
    classroom_name = data.get("classroom_name")
    
    # Validation
    if not institution_id:
        raise HTTPException(status_code=400, detail="Institution ID is required")
        
    new_classroom = {
        "classroom_id": "class_" + datetime.now().strftime("%Y%m%d%H%M%S"),
        "institution_id": institution_id,
        "classroom_name": classroom_name,
        "grade": data.get("grade"),
        "section": data.get("section"),
        "total_students": data.get("total_students"),
        "class_teacher": data.get("class_teacher"),
        "created_at": datetime.utcnow().isoformat(),
        "updated_at": datetime.utcnow().isoformat()
    }
    
    try:
        classrooms_collection.insert_one(new_classroom)
        # Remove _id for JSON response (as it is often ObjectId not serializable)
        new_classroom.pop("_id", None)
            
        return {
            "success": True, 
            "message": "Classroom created", 
            "classroom_id": new_classroom["classroom_id"], 
            "data": new_classroom
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

@app.get("/api/classrooms")
def get_classrooms(institution_id: str, current_user: dict = Depends(get_current_user)):
    try:
        data = list(classrooms_collection.find({"institution_id": institution_id}, {"_id": 0}))
        return {"success": True, "classrooms": data}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

@app.patch("/api/classrooms/{class_id}")
def update_classroom(class_id: str, data: dict = Body(...), current_user: dict = Depends(get_current_user)):
    data["updated_at"] = datetime.utcnow().isoformat()
    try:
        result = classrooms_collection.update_one({"classroom_id": class_id}, {"$set": data})
        if result.matched_count == 0:
             raise HTTPException(status_code=404, detail="Classroom not found")
             
        updated = classrooms_collection.find_one({"classroom_id": class_id}, {"_id": 0})
        return {"success": True, "message": "Classroom updated", "data": updated}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

@app.delete("/api/classrooms/{class_id}")
def delete_classroom(class_id: str, current_user: dict = Depends(get_current_user)):
    try:
        result = classrooms_collection.delete_one({"classroom_id": class_id})
        if result.deleted_count == 0:
            raise HTTPException(status_code=404, detail="Classroom not found")
        return {"success": True, "message": "Classroom deleted"}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

@app.post("/api/classrooms/{classroom_id}/analyze-risk")
def analyze_classroom_risk(classroom_id: str, current_user: dict = Depends(get_current_user)):
    """
    Analyze all students in a classroom for dropout risk using Qwen AI.
    Falls back to rules-based analysis if AI is unavailable.
    """
    try:
        # Get students from database
        students = list(students_collection.find({"classroom_id": classroom_id}, {"_id": 0}))
        
        if not students:
            return {"success": False, "error": "No students found in this classroom"}
        
        # Run AI analysis
        analysis = ai_service.analyze_student_risk(students)
        
        return {
            "success": True,
            "analysis": analysis,
            "total_students": len(students),
            "high_risk_count": len(analysis.get('highRiskStudents', []))
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Analysis error: {str(e)}")

@app.get("/api/classrooms/{classroom_id}/students")
def get_classroom_students(classroom_id: str, current_user: dict = Depends(get_current_user)):
    """
    Get all students in a specific classroom.
    """
    try:
        students = list(students_collection.find({"classroom_id": classroom_id}, {"_id": 0}))
        return {"success": True, "students": students}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

@app.post("/api/students")
def create_student(data: dict = Body(...), current_user: dict = Depends(get_current_user)):
    """
    Create a new student with comprehensive data fields.
    """
    try:
        # Generate student ID
        import uuid
        student_id = str(uuid.uuid4())[:8]
        
        # Prepare student data
        student_data = {
            "student_id": student_id,
            "classroom_id": data.get("classroom_id"),
            "name": data.get("name"),
            "age": int(data.get("age", 0)),
            "grade": data.get("grade", ""),
            "school_location": data.get("school_location", "Urban"),
            
            # Attendance
            "total_days": int(data.get("total_days", 0)),
            "days_present": int(data.get("days_present", 0)),
            "days_absent": int(data.get("days_absent", 0)),
            "longest_absence": int(data.get("longest_absence", 0)),
            
            # Academic
            "current_marks": float(data.get("current_marks", 0)),
            "previous_marks": float(data.get("previous_marks", 0)),
            "failed_subjects": int(data.get("failed_subjects", 0)),
            "failed_subjects_previous": int(data.get("failed_subjects_previous", 0)),
            
            # Family & Economic
            "family_income": float(data.get("family_income", 0)),
            "parent_education": data.get("parent_education", "None"),
            "has_study_device": bool(data.get("has_study_device", False)),
            "student_works": bool(data.get("student_works", False)),
            
            # Health
            "nutrition_status": data.get("nutrition_status", "Normal"),
            "health_absences": int(data.get("health_absences", 0)),
            "menstrual_hygiene": data.get("menstrual_hygiene", "Adequate"),
            "long_term_illness": bool(data.get("long_term_illness", False)),
            
            # Social
            "parent_attitude": data.get("parent_attitude", "Supportive"),
            "early_marriage_risk": bool(data.get("early_marriage_risk", False)),
            "household_work_hours": float(data.get("household_work_hours", 0)),
            "family_migrates": bool(data.get("family_migrates", False)),
            
            # Safety & Access
            "distance_to_school": float(data.get("distance_to_school", 0)),
            "travel_mode": data.get("travel_mode", "Walk"),
            "route_safety_concerns": bool(data.get("route_safety_concerns", False)),
            "girls_toilets_available": bool(data.get("girls_toilets_available", True)),
            
            "created_at": datetime.utcnow().isoformat()
        }
        
        # Calculate attendance percentage
        total_days = student_data["total_days"]
        days_present = student_data["days_present"]
        if total_days > 0:
            student_data["attendance_percent"] = round((days_present / total_days) * 100, 1)
        else:
            student_data["attendance_percent"] = 0.0
        
        # Insert into database
        students_collection.insert_one(student_data)
        
        return {"success": True, "message": "Student created successfully", "student_id": student_id}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error creating student: {str(e)}")

@app.patch("/api/students/{student_id}")
def update_student(student_id: str, data: dict = Body(...), current_user: dict = Depends(get_current_user)):
    """
    Update an existing student's data.
    """
    try:
        # Recalculate attendance if relevant fields changed
        if "total_days" in data or "days_present" in data:
            student = students_collection.find_one({"student_id": student_id})
            if student:
                total = int(data.get("total_days", student.get("total_days", 0)))
                present = int(data.get("days_present", student.get("days_present", 0)))
                if total > 0:
                    data["attendance_percent"] = round((present / total) * 100, 1)
        
        data["updated_at"] = datetime.utcnow().isoformat()
        
        result = students_collection.update_one(
            {"student_id": student_id},
            {"$set": data}
        )
        
        if result.matched_count == 0:
            raise HTTPException(status_code=404, detail="Student not found")
        
        return {"success": True, "message": "Student updated successfully"}
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error updating student: {str(e)}")

@app.delete("/api/students/{student_id}")
def delete_student(student_id: str, current_user: dict = Depends(get_current_user)):
    """
    Delete a student.
    """
    try:
        result = students_collection.delete_one({"student_id": student_id})
        
        if result.deleted_count == 0:
            raise HTTPException(status_code=404, detail="Student not found")
        
        return {"success": True, "message": "Student deleted successfully"}
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error deleting student: {str(e)}")



# @app.get("/intervention/{student_name}")
# def get_intervention_by_student(student_name: str):
#     records = list(intervention_collection.find({"student_name": student_name}, {"_id": 0}))
#     return {"history": records}