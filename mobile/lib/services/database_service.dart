import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import '../models/student.dart';
import '../models/class_data.dart';

class DatabaseService {
  static Database? _database;
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  
  Future<Database> _initDatabase() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else if (defaultTargetPlatform == TargetPlatform.macOS || 
               defaultTargetPlatform == TargetPlatform.linux || 
               defaultTargetPlatform == TargetPlatform.windows) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'girl_dropout.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }
  
  Future<void> _onCreate(Database db, int version) async {
    // Classes table
    await db.execute('''
      CREATE TABLE classes (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        grade TEXT NOT NULL,
        section TEXT NOT NULL,
        total_students INTEGER NOT NULL
      )
    ''');
    
    // Students table
    await db.execute('''
      CREATE TABLE students (
        id TEXT PRIMARY KEY,
        class_id TEXT NOT NULL,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        grade TEXT NOT NULL,
        school_location TEXT NOT NULL,
        
        total_school_days INTEGER NOT NULL,
        days_present INTEGER NOT NULL,
        days_absent INTEGER NOT NULL,
        longest_absence INTEGER NOT NULL,
        
        current_term_marks REAL NOT NULL,
        previous_term_marks REAL NOT NULL,
        subjects_failed_current INTEGER NOT NULL,
        subjects_failed_previous INTEGER NOT NULL,
        
        family_income REAL NOT NULL,
        parent_education TEXT NOT NULL,
        has_study_device INTEGER NOT NULL,
        student_works INTEGER NOT NULL,
        
        nutrition_status TEXT NOT NULL,
        health_absences INTEGER NOT NULL,
        menstrual_hygiene TEXT NOT NULL,
        has_long_term_illness INTEGER NOT NULL,
        
        parent_attitude TEXT NOT NULL,
        early_marriage_risk INTEGER NOT NULL,
        household_work_hours INTEGER NOT NULL,
        family_migrates INTEGER NOT NULL,
        
        distance_to_school REAL NOT NULL,
        travel_mode TEXT NOT NULL,
        route_safety_concerns INTEGER NOT NULL,
        girls_toilets_available INTEGER NOT NULL,
        
        FOREIGN KEY (class_id) REFERENCES classes (id)
      )
    ''');
  }
  
  /// Get all classes
  Future<List<ClassData>> getClasses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('classes');
    
    return List.generate(maps.length, (i) {
      return ClassData.fromJson(maps[i]);
    });
  }
  
  /// Get students by class ID
  Future<List<Student>> getStudentsByClass(String classId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'students',
      where: 'class_id = ?',
      whereArgs: [classId],
    );
    
    return List.generate(maps.length, (i) {
      return Student.fromJson(_mapToStudentJson(maps[i]));
    });
  }
  
  /// Convert DB map to Student JSON (handle boolean conversions)
  Map<String, dynamic> _mapToStudentJson(Map<String, dynamic> map) {
    return {
      ...map,
      'hasStudyDevice': map['has_study_device'] == 1,
      'studentWorks': map['student_works'] == 1,
      'hasLongTermIllness': map['has_long_term_illness'] == 1,
      'earlyMarriageRisk': map['early_marriage_risk'] == 1,
      'familyMigrates': map['family_migrates'] == 1,
      'routeSafetyConcerns': map['route_safety_concerns'] == 1,
      'girlsToiletsAvailable': map['girls_toilets_available'] == 1,
    };
  }
  
  /// Insert a new student
  Future<void> insertStudent(Student student, String classId) async {
    final db = await database;
    await db.insert(
      'students',
      _studentToDbMap(student, classId),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  /// Convert Student to DB map (handle boolean conversions)
  Map<String, dynamic> _studentToDbMap(Student student, String classId) {
    final json = student.toJson();
    return {
      ...json,
      'class_id': classId,
      'has_study_device': student.hasStudyDevice ? 1 : 0,
      'student_works': student.studentWorks ? 1 : 0,
      'has_long_term_illness': student.hasLongTermIllness ? 1 : 0,
      'early_marriage_risk': student.earlyMarriageRisk ? 1 : 0,
      'family_migrates': student.familyMigrates ? 1 : 0,
      'route_safety_concerns': student.routeSafetyConcerns ? 1 : 0,
      'girls_toilets_available': student.girlsToiletsAvailable ? 1 : 0,
    };
  }
  
  void dispose() {
    _database?.close();
  }
}
