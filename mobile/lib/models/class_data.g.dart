// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClassDataImpl _$$ClassDataImplFromJson(Map<String, dynamic> json) =>
    _$ClassDataImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      grade: json['grade'] as String,
      section: json['section'] as String,
      totalStudents: (json['totalStudents'] as num).toInt(),
      studentIds: (json['studentIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ClassDataImplToJson(_$ClassDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'grade': instance.grade,
      'section': instance.section,
      'totalStudents': instance.totalStudents,
      'studentIds': instance.studentIds,
    };
