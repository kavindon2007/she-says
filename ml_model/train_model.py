import sys
sys.path.append("../backend")

from database import students_collection
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import joblib

data = list(students_collection.find())

df = pd.DataFrame(data)

df["has_toilet"] = df["has_toilet"].astype(int)
df["internet_access"] = df["internet_access"].astype(int)

X = df[["attendance", "marks", "family_income", "distance_to_school", "has_toilet", "internet_access"]]

y = df["risk_level"]

model = RandomForestClassifier()

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)

model.fit(X_train, y_train)

joblib.dump(model, "risk_model.pkl")

print("Model trained and saved successfully!")
