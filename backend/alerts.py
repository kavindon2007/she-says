import os
import requests
from fastapi import HTTPException
from dotenv import load_dotenv

load_dotenv()

TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN", "8530020315:AAEDA5oECzm6gF7FaqAiMJ_q55sWUx3wKJc")
TELEGRAM_CHAT_ID = os.getenv("TELEGRAM_CHAT_ID", "8494857908")

def send_telegram_alert(student_id: str, risk_score: int, message: str):
    if not TELEGRAM_BOT_TOKEN or not TELEGRAM_CHAT_ID:
        raise HTTPException(500, "Telegram config missing in .env")

    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendMessage"
    text = (
        f"🚨 RISK ALERT 🚨\n"
        f"Student ID: {student_id}\n"
        f"Risk Score: {risk_score}/100\n"
        f"Message: {message}\n"
        f"Action: Immediate counselling / support needed"
    )

    payload = {"chat_id": TELEGRAM_CHAT_ID, "text": text, "parse_mode": "HTML"}

    response = requests.post(url, json=payload)
    if response.status_code != 200:
        raise HTTPException(500, f"Telegram failed: {response.text}")

    return {"status": "Alert sent"}