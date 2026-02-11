// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClassData _$ClassDataFromJson(Map<String, dynamic> json) {
  return _ClassData.fromJson(json);
}

/// @nodoc
mixin _$ClassData {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError; // e.g., "Class 9B"
  String get grade => throw _privateConstructorUsedError;
  String get section => throw _privateConstructorUsedError;
  int get totalStudents => throw _privateConstructorUsedError;
  List<String> get studentIds => throw _privateConstructorUsedError;

  /// Serializes this ClassData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClassData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClassDataCopyWith<ClassData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassDataCopyWith<$Res> {
  factory $ClassDataCopyWith(ClassData value, $Res Function(ClassData) then) =
      _$ClassDataCopyWithImpl<$Res, ClassData>;
  @useResult
  $Res call(
      {String id,
      String name,
      String grade,
      String section,
      int totalStudents,
      List<String> studentIds});
}

/// @nodoc
class _$ClassDataCopyWithImpl<$Res, $Val extends ClassData>
    implements $ClassDataCopyWith<$Res> {
  _$ClassDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClassData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? grade = null,
    Object? section = null,
    Object? totalStudents = null,
    Object? studentIds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      studentIds: null == studentIds
          ? _value.studentIds
          : studentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClassDataImplCopyWith<$Res>
    implements $ClassDataCopyWith<$Res> {
  factory _$$ClassDataImplCopyWith(
          _$ClassDataImpl value, $Res Function(_$ClassDataImpl) then) =
      __$$ClassDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String grade,
      String section,
      int totalStudents,
      List<String> studentIds});
}

/// @nodoc
class __$$ClassDataImplCopyWithImpl<$Res>
    extends _$ClassDataCopyWithImpl<$Res, _$ClassDataImpl>
    implements _$$ClassDataImplCopyWith<$Res> {
  __$$ClassDataImplCopyWithImpl(
      _$ClassDataImpl _value, $Res Function(_$ClassDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClassData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? grade = null,
    Object? section = null,
    Object? totalStudents = null,
    Object? studentIds = null,
  }) {
    return _then(_$ClassDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      studentIds: null == studentIds
          ? _value._studentIds
          : studentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassDataImpl implements _ClassData {
  const _$ClassDataImpl(
      {required this.id,
      required this.name,
      required this.grade,
      required this.section,
      required this.totalStudents,
      final List<String> studentIds = const []})
      : _studentIds = studentIds;

  factory _$ClassDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassDataImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
// e.g., "Class 9B"
  @override
  final String grade;
  @override
  final String section;
  @override
  final int totalStudents;
  final List<String> _studentIds;
  @override
  @JsonKey()
  List<String> get studentIds {
    if (_studentIds is EqualUnmodifiableListView) return _studentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_studentIds);
  }

  @override
  String toString() {
    return 'ClassData(id: $id, name: $name, grade: $grade, section: $section, totalStudents: $totalStudents, studentIds: $studentIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents) &&
            const DeepCollectionEquality()
                .equals(other._studentIds, _studentIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, grade, section,
      totalStudents, const DeepCollectionEquality().hash(_studentIds));

  /// Create a copy of ClassData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassDataImplCopyWith<_$ClassDataImpl> get copyWith =>
      __$$ClassDataImplCopyWithImpl<_$ClassDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassDataImplToJson(
      this,
    );
  }
}

abstract class _ClassData implements ClassData {
  const factory _ClassData(
      {required final String id,
      required final String name,
      required final String grade,
      required final String section,
      required final int totalStudents,
      final List<String> studentIds}) = _$ClassDataImpl;

  factory _ClassData.fromJson(Map<String, dynamic> json) =
      _$ClassDataImpl.fromJson;

  @override
  String get id;
  @override
  String get name; // e.g., "Class 9B"
  @override
  String get grade;
  @override
  String get section;
  @override
  int get totalStudents;
  @override
  List<String> get studentIds;

  /// Create a copy of ClassData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClassDataImplCopyWith<_$ClassDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
