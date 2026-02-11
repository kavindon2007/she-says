import 'package:freezed_annotation/freezed_annotation.dart';

part 'student.freezed.dart';
part 'student.g.dart';

@freezed
class Student with _$Student {
  const Student._();
  
  const factory Student({
    required String id,
    required String name,
    required int age,
    required String grade,
    required String schoolLocation, // 'Rural' | 'Urban'
    
    // Attendance (Raw)
    required int totalSchoolDays,
    required int daysPresent,
    required int daysAbsent,
    required int longestAbsence,
    
    // Academic (Raw)
    required double currentTermMarks,
    required double previousTermMarks,
    required int subjectsFailedCurrent,
    required int subjectsFailedPrevious,
    
    // Family & Economic
    required double familyIncome,
    required String parentEducation, // 'None' | 'Primary' | 'Secondary' | 'Higher'
    required bool hasStudyDevice,
    required bool studentWorks,
    
    // Health
    required String nutritionStatus, // 'Normal' | 'Underweight' | 'Malnourished'
    required int healthAbsences,
    required String menstrualHygiene, // 'Adequate' | 'Inadequate' | 'None'
    required bool hasLongTermIllness,
    
    // Home & Social
    required String parentAttitude, // 'Supportive' | 'Neutral' | 'Not supportive'
    required bool earlyMarriageRisk,
    required int householdWorkHours,
    required bool familyMigrates,
    
    // Safety & Access
    required double distanceToSchool,
    required String travelMode, // 'Walk' | 'Public transport' | 'Private'
    required bool routeSafetyConcerns,
    required bool girlsToiletsAvailable,
  }) = _Student;
  
  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
  
  // Computed properties (NOT stored, calculated on-demand)
  double get attendancePercent => totalSchoolDays > 0 
      ? (daysPresent / totalSchoolDays) * 100 
      : 0.0;
      
  double get marksDrop => previousTermMarks - currentTermMarks;
  
  bool get academicDecline => subjectsFailedCurrent > subjectsFailedPrevious;
  
  String get averageGrade {
    if (currentTermMarks >= 90) return 'A';
    if (currentTermMarks >= 80) return 'B';
    if (currentTermMarks >= 70) return 'C';
    if (currentTermMarks >= 60) return 'D';
    return 'F';
  }
  
  // Simplified JSON for SLM (only relevant fields)
  Map<String, dynamic> toSLMJson() => {
    'id': id,
    'name': name,
    'attendance': attendancePercent.toStringAsFixed(1),
    'grade': averageGrade,
    'currentMarks': currentTermMarks,
    'previousMarks': previousTermMarks,
    'absences': daysAbsent,
    'failedSubjects': subjectsFailedCurrent,
  };
}
