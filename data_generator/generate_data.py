import sys
sys.path.append("../backend")
from faker import Faker
import random
from database import students_collection

fake = Faker()

districts = [
    "Chennai", "Coimbatore", "Madurai", "Trichy",
    "Salem", "Erode", "Tirunelveli", "Vellore",
    "Thoothukudi", "Thanjavur"
]

def generate_student():
    attendance = random.randint(40, 100)
    marks = random.randint(30, 100)
    income = random.randint(2000, 20000)
    distance = random.randint(1, 15)

    risk = "Low"

    if attendance < 60 or marks < 50 or income < 5000:
        risk = "High"
    elif attendance < 75 or marks < 65:
        risk = "Medium"

    return {
        "name": fake.name(),
        "age": random.randint(10, 17),
        "district": random.choice(districts),
        "attendance": attendance,
        "marks": marks,
        "family_income": income,
        "distance_to_school": distance,
        "has_toilet": random.choice([True, False]),
        "internet_access": random.choice([True, False]),
        "risk_level": risk
    }

def generate_and_insert(n=100):
    print("Starting data generation...")
    students = [generate_student() for _ in range(n)]
    students_collection.insert_many(students)
    print(f"{n} students inserted successfully!")

if __name__ == "__main__":
    generate_and_insert(200)
