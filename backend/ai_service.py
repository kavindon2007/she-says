import requests
import json
from typing import List, Dict, Optional
import logging

logger = logging.getLogger(__name__)

class QwenAIService:
    """
    AI service for student risk analysis using Qwen LLM via Ollama.
    Falls back to rules-based analysis if AI is unavailable.
    """
    
    def __init__(self, base_url: str = "http://localhost:11434"):
        self.base_url = base_url
        self.model = "qwen2.5:1.5b"
        self._check_ollama_status()
    
    def _check_ollama_status(self) -> bool:
        """Check if Ollama is running and model is available"""
        try:
            response = requests.get(f"{self.base_url}/api/tags", timeout=2)
            if response.status_code == 200:
                models = response.json().get('models', [])
                model_names = [m['name'] for m in models]
                if self.model in model_names:
                    logger.info(f"✅ Ollama running with {self.model}")
                    return True
                else:
                    logger.warning(f"⚠️ Ollama running but {self.model} not found")
                    return False
            return False
        except Exception as e:
            logger.warning(f"⚠️ Ollama not available: {e}")
            return False
    
    def analyze_student_risk(self, students: List[Dict]) -> Dict:
        """
        Analyze students and identify high-risk cases using Qwen LLM.
        
        Args:
            students: List of student data dicts with fields:
                - student_id, name, attendance data, marks, etc.
            
        Returns:
            Dict with 'highRiskStudents' list containing id and reason
        """
        if not students:
            return {'highRiskStudents': []}
        
        # Prepare minified JSON for LLM
        student_data = []
        for s in students:
            student_data.append({
                'id': s.get('student_id', s.get('_id')),
                'name': s.get('name', 'Unknown'),
                'attendance': self._calc_attendance(s),
                'currentMarks': s.get('current_marks', s.get('currentTermMarks', 0)),
                'previousMarks': s.get('previous_marks', s.get('previousTermMarks', 0)),
                'absences': s.get('absences', s.get('daysAbsent', 0)),
                'failedSubjects': s.get('failed_subjects', s.get('subjectsFailedCurrent', 0)),
            })
        
        # Try AI analysis first
        try:
            return self._ai_analysis(student_data)
        except Exception as e:
            logger.error(f"AI analysis failed: {e}, using fallback")
            return self._fallback_analysis(student_data)
    
    def _ai_analysis(self, students: List[Dict]) -> Dict:
        """Use Qwen LLM for analysis"""
        # System prompt (exact as specified)
        prompt = f"""Analyze this JSON. Identify students with 'High Risk' (Attendance < 70% OR Grades 'D' or below, which means marks < 60%). 
Return a JSON listing only their IDs and a 1-sentence 'Reason' based on the data. 
Do not use markdown.

Data:
{json.dumps(students)}

Return format:
{{"highRiskStudents": [{{"id": "...", "reason": "..."}}]}}"""
        
        # Call Ollama API
        response = requests.post(
            f"{self.base_url}/api/generate",
            json={
                "model": self.model,
                "prompt": prompt,
                "stream": False,
                "options": {
                    "temperature": 0.3,  # Low for consistent output
                    "num_predict": 512,
                }
            },
            timeout=30
        )
        
        if response.status_code != 200:
            raise Exception(f"Ollama API error: {response.status_code}")
        
        result = response.json()
        llm_output = result.get('response', '{}')
        
        # Parse JSON from LLM response (handle markdown code blocks)
        llm_output = llm_output.strip()
        if llm_output.startswith('```'):
            # Remove markdown code blocks
            lines = llm_output.split('\n')
            llm_output = '\n'.join([l for l in lines if not l.startswith('```')])
        
        try:
            parsed = json.loads(llm_output)
            logger.info(f"✅ AI analysis successful: {len(parsed.get('highRiskStudents', []))} high-risk students")
            return parsed
        except json.JSONDecodeError:
            logger.error(f"Failed to parse LLM output: {llm_output}")
            raise
    
    def _calc_attendance(self, student: Dict) -> float:
        """Calculate attendance percentage from student data"""
        total = student.get('total_days', student.get('totalSchoolDays', 0)) or 0
        present = student.get('days_present', student.get('daysPresent', 0)) or 0
        
        if total > 0:
            return round((present / total) * 100, 1)
        return 0.0
    
    def _fallback_analysis(self, students: List[Dict]) -> Dict:
        """Rules-based fallback when AI is unavailable"""
        high_risk = []
        
        for s in students:
            attendance = s.get('attendance', 100)
            marks = s.get('currentMarks', 100)
            failed_subjects = s.get('failedSubjects', 0)
            
            reasons = []
            if attendance < 70:
                reasons.append(f"Attendance below 70% ({attendance}%)")
            if marks < 60:  # D grade or below
                reasons.append(f"Failing grades ({marks}%)")
            if failed_subjects > 0:
                reasons.append(f"{failed_subjects} failed subjects")
            
            if reasons:
                high_risk.append({
                    'id': s['id'],
                    'reason': '; '.join(reasons)
                })
        
        logger.info(f"📊 Fallback analysis: {len(high_risk)} high-risk students")
        return {'highRiskStudents': high_risk}


# Global instance
ai_service = QwenAIService()
