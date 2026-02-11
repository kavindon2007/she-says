import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/class_data.dart';
import '../models/student.dart';
import '../services/database_service.dart';
import '../services/api_service.dart';

/// Database Service Provider
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

/// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

/// Class List Provider (Local + Optional Remote Sync)
final classListProvider = FutureProvider<List<ClassData>>((ref) async {
  final db = ref.watch(databaseServiceProvider);
  final api = ref.watch(apiServiceProvider);
  
  // For demo: attempt to sync if local is empty?
  // Or just provide a way to trigger sync from UI
  return await db.getClasses();
});

/// Students by Class Provider (lazy-loaded, with Remote Sync support)
final studentsByClassProvider = FutureProvider.family<List<Student>, String>((ref, classId) async {
  final db = ref.watch(databaseServiceProvider);
  final api = ref.watch(apiServiceProvider);
  
  final localStudents = await db.getStudentsByClass(classId);
  
  // If local is empty, try fetching from API
  if (localStudents.isEmpty) {
    final remoteStudents = await api.fetchStudents(classId);
    if (remoteStudents.isNotEmpty) {
      for (final student in remoteStudents) {
        await db.insertStudent(student, classId);
      }
      return remoteStudents;
    }
  }
  
  return localStudents;
});

/// Expanded Class State Provider (tracks which card is expanded)
final expandedClassProvider = StateProvider<String?>((ref) => null);
