@echo off
echo Starting SheStays Application...

:: Start Backend in a new window
start cmd /k "cd backend && venv\Scripts\python.exe -m uvicorn main:app --reload --host 0.0.0.0 --port 8005"

:: Start Frontend in a new window
start cmd /k "cd frontend && python -m http.server 3000"

echo.
echo Application is starting!
echo Backend: http://localhost:8005
echo Frontend: http://localhost:3000
echo.
echo Close the newly opened command windows to stop the servers.
pause
