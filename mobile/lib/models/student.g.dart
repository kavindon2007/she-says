// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      grade: json['grade'] as String,
      schoolLocation: json['schoolLocation'] as String,
      totalSchoolDays: (json['totalSchoolDays'] as num).toInt(),
      daysPresent: (json['daysPresent'] as num).toInt(),
      daysAbsent: (json['daysAbsent'] as num).toInt(),
      longestAbsence: (json['longestAbsence'] as num).toInt(),
      currentTermMarks: (json['currentTermMarks'] as num).toDouble(),
      previousTermMarks: (json['previousTermMarks'] as num).toDouble(),
      subjectsFailedCurrent: (json['subjectsFailedCurrent'] as num).toInt(),
      subjectsFailedPrevious: (json['subjectsFailedPrevious'] as num).toInt(),
      familyIncome: (json['familyIncome'] as num).toDouble(),
      parentEducation: json['parentEducation'] as String,
      hasStudyDevice: json['hasStudyDevice'] as bool,
      studentWorks: json['studentWorks'] as bool,
      nutritionStatus: json['nutritionStatus'] as String,
      healthAbsences: (json['healthAbsences'] as num).toInt(),
      menstrualHygiene: json['menstrualHygiene'] as String,
      hasLongTermIllness: json['hasLongTermIllness'] as bool,
      parentAttitude: json['parentAttitude'] as String,
      earlyMarriageRisk: json['earlyMarriageRisk'] as bool,
      householdWorkHours: (json['householdWorkHours'] as num).toInt(),
      familyMigrates: json['familyMigrates'] as bool,
      distanceToSchool: (json['distanceToSchool'] as num).toDouble(),
      travelMode: json['travelMode'] as String,
      routeSafetyConcerns: json['routeSafetyConcerns'] as bool,
      girlsToiletsAvailable: json['girlsToiletsAvailable'] as bool,
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'grade': instance.grade,
      'schoolLocation': instance.schoolLocation,
      'totalSchoolDays': instance.totalSchoolDays,
      'daysPresent': instance.daysPresent,
      'daysAbsent': instance.daysAbsent,
      'longestAbsence': instance.longestAbsence,
      'currentTermMarks': instance.currentTermMarks,
      'previousTermMarks': instance.previousTermMarks,
      'subjectsFailedCurrent': instance.subjectsFailedCurrent,
      'subjectsFailedPrevious': instance.subjectsFailedPrevious,
      'familyIncome': instance.familyIncome,
      'parentEducation': instance.parentEducation,
      'hasStudyDevice': instance.hasStudyDevice,
      'studentWorks': instance.studentWorks,
      'nutritionStatus': instance.nutritionStatus,
      'healthAbsences': instance.healthAbsences,
      'menstrualHygiene': instance.menstrualHygiene,
      'hasLongTermIllness': instance.hasLongTermIllness,
      'parentAttitude': instance.parentAttitude,
      'earlyMarriageRisk': instance.earlyMarriageRisk,
      'householdWorkHours': instance.householdWorkHours,
      'familyMigrates': instance.familyMigrates,
      'distanceToSchool': instance.distanceToSchool,
      'travelMode': instance.travelMode,
      'routeSafetyConcerns': instance.routeSafetyConcerns,
      'girlsToiletsAvailable': instance.girlsToiletsAvailable,
    };
