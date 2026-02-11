import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/student.dart';
import '../models/class_data.dart';

class ApiService {
  // Use 10.0.2.2 for Android Emulator to access localhost
  // Use localhost for iOS Simulator or Desktop
  final String _baseUrl = 'http://10.0.2.2:8005'; 
  String? _accessToken;

  /// Set the access token after login
  void setToken(String token) {
    _accessToken = token;
  }

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_accessToken != null) 'Authorization': 'Bearer $_accessToken',
  };

  /// Login and get access token
  Future<bool> login(String username, String password, String phone) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        body: jsonEncode({
          'username': username,
          'password': password,
          'phone': phone,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _accessToken = data['access_token'];
        return true;
      }
      return false;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  /// Fetch classrooms for the institution
  Future<List<ClassData>> fetchClassrooms(String institutionId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/institutions/$institutionId/classrooms'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => ClassData.fromJson(_mapClassroomBackendToFlutterJson(item))).toList();
      }
      return [];
    } catch (e) {
      print('Fetch classrooms error: $e');
      return [];
    }
  }

  /// Map classroom backend keys to Flutter
  Map<String, dynamic> _mapClassroomBackendToFlutterJson(Map<String, dynamic> item) {
    return {
      'id': item['classroom_id'],
      'name': item['class_name'],
      'grade': item['grade'],
      'section': item['section'],
      'totalStudents': item['total_students'],
      'studentIds': item['student_ids'] ?? [],
    };
  }

  /// Fetch students for a classroom
  Future<List<Student>> fetchStudents(String classroomId) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/classrooms/$classroomId/students'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> studentsList = data['students'];
        return studentsList.map((item) => Student.fromJson(_mapBackendToFlutterJson(item))).toList();
      }
      return [];
    } catch (e) {
      print('Fetch students error: $e');
      return [];
    }
  }

  /// Map backend snake_case keys to Flutter expected keys (if different)
  Map<String, dynamic> _mapBackendToFlutterJson(Map<String, dynamic> item) {
    // This mapping ensures the backend JSON works with our Student.fromJson
    return {
      'id': item['student_id'],
      'name': item['name'],
      'age': item['age'],
      'grade': item['grade'],
      'schoolLocation': item['school_location'],
      'totalSchoolDays': item['total_days'],
      'daysPresent': item['days_present'],
      'daysAbsent': item['days_absent'],
      'longestAbsence': item['longest_absence'],
      'currentTermMarks': item['current_marks'],
      'previousTermMarks': item['previous_marks'],
      'subjectsFailedCurrent': item['failed_subjects'],
      'subjectsFailedPrevious': item['failed_subjects_previous'],
      'familyIncome': item['family_income'],
      'parentEducation': item['parent_education'],
      'hasStudyDevice': item['has_study_device'],
      'studentWorks': item['student_works'],
      'nutritionStatus': item['nutrition_status'],
      'healthAbsences': item['health_absences'],
      'menstrualHygiene': item['menstrual_hygiene'],
      'hasLongTermIllness': item['long_term_illness'],
      'parentAttitude': item['parent_attitude'],
      'earlyMarriageRisk': item['early_marriage_risk'],
      'householdWorkHours': item['household_work_hours'],
      'familyMigrates': item['family_migrates'],
      'distanceToSchool': item['distance_to_school'],
      'travelMode': item['travel_mode'],
      'routeSafetyConcerns': item['route_safety_concerns'],
      'girlsToiletsAvailable': item['girls_toilets_available'],
    };
  }
}
