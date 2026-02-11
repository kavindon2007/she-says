import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_data.freezed.dart';
part 'class_data.g.dart';

@freezed
class ClassData with _$ClassData {
  const factory ClassData({
    required String id,
    required String name, // e.g., "Class 9B"
    required String grade,
    required String section,
    required int totalStudents,
    @Default([]) List<String> studentIds, // References to Student IDs
  }) = _ClassData;
  
  factory ClassData.fromJson(Map<String, dynamic> json) => _$ClassDataFromJson(json);
}
