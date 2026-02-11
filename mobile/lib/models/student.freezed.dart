// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Student _$StudentFromJson(Map<String, dynamic> json) {
  return _Student.fromJson(json);
}

/// @nodoc
mixin _$Student {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get grade => throw _privateConstructorUsedError;
  String get schoolLocation =>
      throw _privateConstructorUsedError; // 'Rural' | 'Urban'
// Attendance (Raw)
  int get totalSchoolDays => throw _privateConstructorUsedError;
  int get daysPresent => throw _privateConstructorUsedError;
  int get daysAbsent => throw _privateConstructorUsedError;
  int get longestAbsence =>
      throw _privateConstructorUsedError; // Academic (Raw)
  double get currentTermMarks => throw _privateConstructorUsedError;
  double get previousTermMarks => throw _privateConstructorUsedError;
  int get subjectsFailedCurrent => throw _privateConstructorUsedError;
  int get subjectsFailedPrevious =>
      throw _privateConstructorUsedError; // Family & Economic
  double get familyIncome => throw _privateConstructorUsedError;
  String get parentEducation =>
      throw _privateConstructorUsedError; // 'None' | 'Primary' | 'Secondary' | 'Higher'
  bool get hasStudyDevice => throw _privateConstructorUsedError;
  bool get studentWorks => throw _privateConstructorUsedError; // Health
  String get nutritionStatus =>
      throw _privateConstructorUsedError; // 'Normal' | 'Underweight' | 'Malnourished'
  int get healthAbsences => throw _privateConstructorUsedError;
  String get menstrualHygiene =>
      throw _privateConstructorUsedError; // 'Adequate' | 'Inadequate' | 'None'
  bool get hasLongTermIllness =>
      throw _privateConstructorUsedError; // Home & Social
  String get parentAttitude =>
      throw _privateConstructorUsedError; // 'Supportive' | 'Neutral' | 'Not supportive'
  bool get earlyMarriageRisk => throw _privateConstructorUsedError;
  int get householdWorkHours => throw _privateConstructorUsedError;
  bool get familyMigrates =>
      throw _privateConstructorUsedError; // Safety & Access
  double get distanceToSchool => throw _privateConstructorUsedError;
  String get travelMode =>
      throw _privateConstructorUsedError; // 'Walk' | 'Public transport' | 'Private'
  bool get routeSafetyConcerns => throw _privateConstructorUsedError;
  bool get girlsToiletsAvailable => throw _privateConstructorUsedError;

  /// Serializes this Student to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentCopyWith<Student> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentCopyWith<$Res> {
  factory $StudentCopyWith(Student value, $Res Function(Student) then) =
      _$StudentCopyWithImpl<$Res, Student>;
  @useResult
  $Res call(
      {String id,
      String name,
      int age,
      String grade,
      String schoolLocation,
      int totalSchoolDays,
      int daysPresent,
      int daysAbsent,
      int longestAbsence,
      double currentTermMarks,
      double previousTermMarks,
      int subjectsFailedCurrent,
      int subjectsFailedPrevious,
      double familyIncome,
      String parentEducation,
      bool hasStudyDevice,
      bool studentWorks,
      String nutritionStatus,
      int healthAbsences,
      String menstrualHygiene,
      bool hasLongTermIllness,
      String parentAttitude,
      bool earlyMarriageRisk,
      int householdWorkHours,
      bool familyMigrates,
      double distanceToSchool,
      String travelMode,
      bool routeSafetyConcerns,
      bool girlsToiletsAvailable});
}

/// @nodoc
class _$StudentCopyWithImpl<$Res, $Val extends Student>
    implements $StudentCopyWith<$Res> {
  _$StudentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? grade = null,
    Object? schoolLocation = null,
    Object? totalSchoolDays = null,
    Object? daysPresent = null,
    Object? daysAbsent = null,
    Object? longestAbsence = null,
    Object? currentTermMarks = null,
    Object? previousTermMarks = null,
    Object? subjectsFailedCurrent = null,
    Object? subjectsFailedPrevious = null,
    Object? familyIncome = null,
    Object? parentEducation = null,
    Object? hasStudyDevice = null,
    Object? studentWorks = null,
    Object? nutritionStatus = null,
    Object? healthAbsences = null,
    Object? menstrualHygiene = null,
    Object? hasLongTermIllness = null,
    Object? parentAttitude = null,
    Object? earlyMarriageRisk = null,
    Object? householdWorkHours = null,
    Object? familyMigrates = null,
    Object? distanceToSchool = null,
    Object? travelMode = null,
    Object? routeSafetyConcerns = null,
    Object? girlsToiletsAvailable = null,
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
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String,
      schoolLocation: null == schoolLocation
          ? _value.schoolLocation
          : schoolLocation // ignore: cast_nullable_to_non_nullable
              as String,
      totalSchoolDays: null == totalSchoolDays
          ? _value.totalSchoolDays
          : totalSchoolDays // ignore: cast_nullable_to_non_nullable
              as int,
      daysPresent: null == daysPresent
          ? _value.daysPresent
          : daysPresent // ignore: cast_nullable_to_non_nullable
              as int,
      daysAbsent: null == daysAbsent
          ? _value.daysAbsent
          : daysAbsent // ignore: cast_nullable_to_non_nullable
              as int,
      longestAbsence: null == longestAbsence
          ? _value.longestAbsence
          : longestAbsence // ignore: cast_nullable_to_non_nullable
              as int,
      currentTermMarks: null == currentTermMarks
          ? _value.currentTermMarks
          : currentTermMarks // ignore: cast_nullable_to_non_nullable
              as double,
      previousTermMarks: null == previousTermMarks
          ? _value.previousTermMarks
          : previousTermMarks // ignore: cast_nullable_to_non_nullable
              as double,
      subjectsFailedCurrent: null == subjectsFailedCurrent
          ? _value.subjectsFailedCurrent
          : subjectsFailedCurrent // ignore: cast_nullable_to_non_nullable
              as int,
      subjectsFailedPrevious: null == subjectsFailedPrevious
          ? _value.subjectsFailedPrevious
          : subjectsFailedPrevious // ignore: cast_nullable_to_non_nullable
              as int,
      familyIncome: null == familyIncome
          ? _value.familyIncome
          : familyIncome // ignore: cast_nullable_to_non_nullable
              as double,
      parentEducation: null == parentEducation
          ? _value.parentEducation
          : parentEducation // ignore: cast_nullable_to_non_nullable
              as String,
      hasStudyDevice: null == hasStudyDevice
          ? _value.hasStudyDevice
          : hasStudyDevice // ignore: cast_nullable_to_non_nullable
              as bool,
      studentWorks: null == studentWorks
          ? _value.studentWorks
          : studentWorks // ignore: cast_nullable_to_non_nullable
              as bool,
      nutritionStatus: null == nutritionStatus
          ? _value.nutritionStatus
          : nutritionStatus // ignore: cast_nullable_to_non_nullable
              as String,
      healthAbsences: null == healthAbsences
          ? _value.healthAbsences
          : healthAbsences // ignore: cast_nullable_to_non_nullable
              as int,
      menstrualHygiene: null == menstrualHygiene
          ? _value.menstrualHygiene
          : menstrualHygiene // ignore: cast_nullable_to_non_nullable
              as String,
      hasLongTermIllness: null == hasLongTermIllness
          ? _value.hasLongTermIllness
          : hasLongTermIllness // ignore: cast_nullable_to_non_nullable
              as bool,
      parentAttitude: null == parentAttitude
          ? _value.parentAttitude
          : parentAttitude // ignore: cast_nullable_to_non_nullable
              as String,
      earlyMarriageRisk: null == earlyMarriageRisk
          ? _value.earlyMarriageRisk
          : earlyMarriageRisk // ignore: cast_nullable_to_non_nullable
              as bool,
      householdWorkHours: null == householdWorkHours
          ? _value.householdWorkHours
          : householdWorkHours // ignore: cast_nullable_to_non_nullable
              as int,
      familyMigrates: null == familyMigrates
          ? _value.familyMigrates
          : familyMigrates // ignore: cast_nullable_to_non_nullable
              as bool,
      distanceToSchool: null == distanceToSchool
          ? _value.distanceToSchool
          : distanceToSchool // ignore: cast_nullable_to_non_nullable
              as double,
      travelMode: null == travelMode
          ? _value.travelMode
          : travelMode // ignore: cast_nullable_to_non_nullable
              as String,
      routeSafetyConcerns: null == routeSafetyConcerns
          ? _value.routeSafetyConcerns
          : routeSafetyConcerns // ignore: cast_nullable_to_non_nullable
              as bool,
      girlsToiletsAvailable: null == girlsToiletsAvailable
          ? _value.girlsToiletsAvailable
          : girlsToiletsAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentImplCopyWith<$Res> implements $StudentCopyWith<$Res> {
  factory _$$StudentImplCopyWith(
          _$StudentImpl value, $Res Function(_$StudentImpl) then) =
      __$$StudentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int age,
      String grade,
      String schoolLocation,
      int totalSchoolDays,
      int daysPresent,
      int daysAbsent,
      int longestAbsence,
      double currentTermMarks,
      double previousTermMarks,
      int subjectsFailedCurrent,
      int subjectsFailedPrevious,
      double familyIncome,
      String parentEducation,
      bool hasStudyDevice,
      bool studentWorks,
      String nutritionStatus,
      int healthAbsences,
      String menstrualHygiene,
      bool hasLongTermIllness,
      String parentAttitude,
      bool earlyMarriageRisk,
      int householdWorkHours,
      bool familyMigrates,
      double distanceToSchool,
      String travelMode,
      bool routeSafetyConcerns,
      bool girlsToiletsAvailable});
}

/// @nodoc
class __$$StudentImplCopyWithImpl<$Res>
    extends _$StudentCopyWithImpl<$Res, _$StudentImpl>
    implements _$$StudentImplCopyWith<$Res> {
  __$$StudentImplCopyWithImpl(
      _$StudentImpl _value, $Res Function(_$StudentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? grade = null,
    Object? schoolLocation = null,
    Object? totalSchoolDays = null,
    Object? daysPresent = null,
    Object? daysAbsent = null,
    Object? longestAbsence = null,
    Object? currentTermMarks = null,
    Object? previousTermMarks = null,
    Object? subjectsFailedCurrent = null,
    Object? subjectsFailedPrevious = null,
    Object? familyIncome = null,
    Object? parentEducation = null,
    Object? hasStudyDevice = null,
    Object? studentWorks = null,
    Object? nutritionStatus = null,
    Object? healthAbsences = null,
    Object? menstrualHygiene = null,
    Object? hasLongTermIllness = null,
    Object? parentAttitude = null,
    Object? earlyMarriageRisk = null,
    Object? householdWorkHours = null,
    Object? familyMigrates = null,
    Object? distanceToSchool = null,
    Object? travelMode = null,
    Object? routeSafetyConcerns = null,
    Object? girlsToiletsAvailable = null,
  }) {
    return _then(_$StudentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as String,
      schoolLocation: null == schoolLocation
          ? _value.schoolLocation
          : schoolLocation // ignore: cast_nullable_to_non_nullable
              as String,
      totalSchoolDays: null == totalSchoolDays
          ? _value.totalSchoolDays
          : totalSchoolDays // ignore: cast_nullable_to_non_nullable
              as int,
      daysPresent: null == daysPresent
          ? _value.daysPresent
          : daysPresent // ignore: cast_nullable_to_non_nullable
              as int,
      daysAbsent: null == daysAbsent
          ? _value.daysAbsent
          : daysAbsent // ignore: cast_nullable_to_non_nullable
              as int,
      longestAbsence: null == longestAbsence
          ? _value.longestAbsence
          : longestAbsence // ignore: cast_nullable_to_non_nullable
              as int,
      currentTermMarks: null == currentTermMarks
          ? _value.currentTermMarks
          : currentTermMarks // ignore: cast_nullable_to_non_nullable
              as double,
      previousTermMarks: null == previousTermMarks
          ? _value.previousTermMarks
          : previousTermMarks // ignore: cast_nullable_to_non_nullable
              as double,
      subjectsFailedCurrent: null == subjectsFailedCurrent
          ? _value.subjectsFailedCurrent
          : subjectsFailedCurrent // ignore: cast_nullable_to_non_nullable
              as int,
      subjectsFailedPrevious: null == subjectsFailedPrevious
          ? _value.subjectsFailedPrevious
          : subjectsFailedPrevious // ignore: cast_nullable_to_non_nullable
              as int,
      familyIncome: null == familyIncome
          ? _value.familyIncome
          : familyIncome // ignore: cast_nullable_to_non_nullable
              as double,
      parentEducation: null == parentEducation
          ? _value.parentEducation
          : parentEducation // ignore: cast_nullable_to_non_nullable
              as String,
      hasStudyDevice: null == hasStudyDevice
          ? _value.hasStudyDevice
          : hasStudyDevice // ignore: cast_nullable_to_non_nullable
              as bool,
      studentWorks: null == studentWorks
          ? _value.studentWorks
          : studentWorks // ignore: cast_nullable_to_non_nullable
              as bool,
      nutritionStatus: null == nutritionStatus
          ? _value.nutritionStatus
          : nutritionStatus // ignore: cast_nullable_to_non_nullable
              as String,
      healthAbsences: null == healthAbsences
          ? _value.healthAbsences
          : healthAbsences // ignore: cast_nullable_to_non_nullable
              as int,
      menstrualHygiene: null == menstrualHygiene
          ? _value.menstrualHygiene
          : menstrualHygiene // ignore: cast_nullable_to_non_nullable
              as String,
      hasLongTermIllness: null == hasLongTermIllness
          ? _value.hasLongTermIllness
          : hasLongTermIllness // ignore: cast_nullable_to_non_nullable
              as bool,
      parentAttitude: null == parentAttitude
          ? _value.parentAttitude
          : parentAttitude // ignore: cast_nullable_to_non_nullable
              as String,
      earlyMarriageRisk: null == earlyMarriageRisk
          ? _value.earlyMarriageRisk
          : earlyMarriageRisk // ignore: cast_nullable_to_non_nullable
              as bool,
      householdWorkHours: null == householdWorkHours
          ? _value.householdWorkHours
          : householdWorkHours // ignore: cast_nullable_to_non_nullable
              as int,
      familyMigrates: null == familyMigrates
          ? _value.familyMigrates
          : familyMigrates // ignore: cast_nullable_to_non_nullable
              as bool,
      distanceToSchool: null == distanceToSchool
          ? _value.distanceToSchool
          : distanceToSchool // ignore: cast_nullable_to_non_nullable
              as double,
      travelMode: null == travelMode
          ? _value.travelMode
          : travelMode // ignore: cast_nullable_to_non_nullable
              as String,
      routeSafetyConcerns: null == routeSafetyConcerns
          ? _value.routeSafetyConcerns
          : routeSafetyConcerns // ignore: cast_nullable_to_non_nullable
              as bool,
      girlsToiletsAvailable: null == girlsToiletsAvailable
          ? _value.girlsToiletsAvailable
          : girlsToiletsAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentImpl extends _Student {
  const _$StudentImpl(
      {required this.id,
      required this.name,
      required this.age,
      required this.grade,
      required this.schoolLocation,
      required this.totalSchoolDays,
      required this.daysPresent,
      required this.daysAbsent,
      required this.longestAbsence,
      required this.currentTermMarks,
      required this.previousTermMarks,
      required this.subjectsFailedCurrent,
      required this.subjectsFailedPrevious,
      required this.familyIncome,
      required this.parentEducation,
      required this.hasStudyDevice,
      required this.studentWorks,
      required this.nutritionStatus,
      required this.healthAbsences,
      required this.menstrualHygiene,
      required this.hasLongTermIllness,
      required this.parentAttitude,
      required this.earlyMarriageRisk,
      required this.householdWorkHours,
      required this.familyMigrates,
      required this.distanceToSchool,
      required this.travelMode,
      required this.routeSafetyConcerns,
      required this.girlsToiletsAvailable})
      : super._();

  factory _$StudentImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int age;
  @override
  final String grade;
  @override
  final String schoolLocation;
// 'Rural' | 'Urban'
// Attendance (Raw)
  @override
  final int totalSchoolDays;
  @override
  final int daysPresent;
  @override
  final int daysAbsent;
  @override
  final int longestAbsence;
// Academic (Raw)
  @override
  final double currentTermMarks;
  @override
  final double previousTermMarks;
  @override
  final int subjectsFailedCurrent;
  @override
  final int subjectsFailedPrevious;
// Family & Economic
  @override
  final double familyIncome;
  @override
  final String parentEducation;
// 'None' | 'Primary' | 'Secondary' | 'Higher'
  @override
  final bool hasStudyDevice;
  @override
  final bool studentWorks;
// Health
  @override
  final String nutritionStatus;
// 'Normal' | 'Underweight' | 'Malnourished'
  @override
  final int healthAbsences;
  @override
  final String menstrualHygiene;
// 'Adequate' | 'Inadequate' | 'None'
  @override
  final bool hasLongTermIllness;
// Home & Social
  @override
  final String parentAttitude;
// 'Supportive' | 'Neutral' | 'Not supportive'
  @override
  final bool earlyMarriageRisk;
  @override
  final int householdWorkHours;
  @override
  final bool familyMigrates;
// Safety & Access
  @override
  final double distanceToSchool;
  @override
  final String travelMode;
// 'Walk' | 'Public transport' | 'Private'
  @override
  final bool routeSafetyConcerns;
  @override
  final bool girlsToiletsAvailable;

  @override
  String toString() {
    return 'Student(id: $id, name: $name, age: $age, grade: $grade, schoolLocation: $schoolLocation, totalSchoolDays: $totalSchoolDays, daysPresent: $daysPresent, daysAbsent: $daysAbsent, longestAbsence: $longestAbsence, currentTermMarks: $currentTermMarks, previousTermMarks: $previousTermMarks, subjectsFailedCurrent: $subjectsFailedCurrent, subjectsFailedPrevious: $subjectsFailedPrevious, familyIncome: $familyIncome, parentEducation: $parentEducation, hasStudyDevice: $hasStudyDevice, studentWorks: $studentWorks, nutritionStatus: $nutritionStatus, healthAbsences: $healthAbsences, menstrualHygiene: $menstrualHygiene, hasLongTermIllness: $hasLongTermIllness, parentAttitude: $parentAttitude, earlyMarriageRisk: $earlyMarriageRisk, householdWorkHours: $householdWorkHours, familyMigrates: $familyMigrates, distanceToSchool: $distanceToSchool, travelMode: $travelMode, routeSafetyConcerns: $routeSafetyConcerns, girlsToiletsAvailable: $girlsToiletsAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.schoolLocation, schoolLocation) ||
                other.schoolLocation == schoolLocation) &&
            (identical(other.totalSchoolDays, totalSchoolDays) ||
                other.totalSchoolDays == totalSchoolDays) &&
            (identical(other.daysPresent, daysPresent) ||
                other.daysPresent == daysPresent) &&
            (identical(other.daysAbsent, daysAbsent) ||
                other.daysAbsent == daysAbsent) &&
            (identical(other.longestAbsence, longestAbsence) ||
                other.longestAbsence == longestAbsence) &&
            (identical(other.currentTermMarks, currentTermMarks) ||
                other.currentTermMarks == currentTermMarks) &&
            (identical(other.previousTermMarks, previousTermMarks) ||
                other.previousTermMarks == previousTermMarks) &&
            (identical(other.subjectsFailedCurrent, subjectsFailedCurrent) ||
                other.subjectsFailedCurrent == subjectsFailedCurrent) &&
            (identical(other.subjectsFailedPrevious, subjectsFailedPrevious) ||
                other.subjectsFailedPrevious == subjectsFailedPrevious) &&
            (identical(other.familyIncome, familyIncome) ||
                other.familyIncome == familyIncome) &&
            (identical(other.parentEducation, parentEducation) ||
                other.parentEducation == parentEducation) &&
            (identical(other.hasStudyDevice, hasStudyDevice) ||
                other.hasStudyDevice == hasStudyDevice) &&
            (identical(other.studentWorks, studentWorks) ||
                other.studentWorks == studentWorks) &&
            (identical(other.nutritionStatus, nutritionStatus) ||
                other.nutritionStatus == nutritionStatus) &&
            (identical(other.healthAbsences, healthAbsences) ||
                other.healthAbsences == healthAbsences) &&
            (identical(other.menstrualHygiene, menstrualHygiene) ||
                other.menstrualHygiene == menstrualHygiene) &&
            (identical(other.hasLongTermIllness, hasLongTermIllness) ||
                other.hasLongTermIllness == hasLongTermIllness) &&
            (identical(other.parentAttitude, parentAttitude) ||
                other.parentAttitude == parentAttitude) &&
            (identical(other.earlyMarriageRisk, earlyMarriageRisk) ||
                other.earlyMarriageRisk == earlyMarriageRisk) &&
            (identical(other.householdWorkHours, householdWorkHours) ||
                other.householdWorkHours == householdWorkHours) &&
            (identical(other.familyMigrates, familyMigrates) ||
                other.familyMigrates == familyMigrates) &&
            (identical(other.distanceToSchool, distanceToSchool) ||
                other.distanceToSchool == distanceToSchool) &&
            (identical(other.travelMode, travelMode) ||
                other.travelMode == travelMode) &&
            (identical(other.routeSafetyConcerns, routeSafetyConcerns) ||
                other.routeSafetyConcerns == routeSafetyConcerns) &&
            (identical(other.girlsToiletsAvailable, girlsToiletsAvailable) ||
                other.girlsToiletsAvailable == girlsToiletsAvailable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        age,
        grade,
        schoolLocation,
        totalSchoolDays,
        daysPresent,
        daysAbsent,
        longestAbsence,
        currentTermMarks,
        previousTermMarks,
        subjectsFailedCurrent,
        subjectsFailedPrevious,
        familyIncome,
        parentEducation,
        hasStudyDevice,
        studentWorks,
        nutritionStatus,
        healthAbsences,
        menstrualHygiene,
        hasLongTermIllness,
        parentAttitude,
        earlyMarriageRisk,
        householdWorkHours,
        familyMigrates,
        distanceToSchool,
        travelMode,
        routeSafetyConcerns,
        girlsToiletsAvailable
      ]);

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      __$$StudentImplCopyWithImpl<_$StudentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentImplToJson(
      this,
    );
  }
}

abstract class _Student extends Student {
  const factory _Student(
      {required final String id,
      required final String name,
      required final int age,
      required final String grade,
      required final String schoolLocation,
      required final int totalSchoolDays,
      required final int daysPresent,
      required final int daysAbsent,
      required final int longestAbsence,
      required final double currentTermMarks,
      required final double previousTermMarks,
      required final int subjectsFailedCurrent,
      required final int subjectsFailedPrevious,
      required final double familyIncome,
      required final String parentEducation,
      required final bool hasStudyDevice,
      required final bool studentWorks,
      required final String nutritionStatus,
      required final int healthAbsences,
      required final String menstrualHygiene,
      required final bool hasLongTermIllness,
      required final String parentAttitude,
      required final bool earlyMarriageRisk,
      required final int householdWorkHours,
      required final bool familyMigrates,
      required final double distanceToSchool,
      required final String travelMode,
      required final bool routeSafetyConcerns,
      required final bool girlsToiletsAvailable}) = _$StudentImpl;
  const _Student._() : super._();

  factory _Student.fromJson(Map<String, dynamic> json) = _$StudentImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get age;
  @override
  String get grade;
  @override
  String get schoolLocation; // 'Rural' | 'Urban'
// Attendance (Raw)
  @override
  int get totalSchoolDays;
  @override
  int get daysPresent;
  @override
  int get daysAbsent;
  @override
  int get longestAbsence; // Academic (Raw)
  @override
  double get currentTermMarks;
  @override
  double get previousTermMarks;
  @override
  int get subjectsFailedCurrent;
  @override
  int get subjectsFailedPrevious; // Family & Economic
  @override
  double get familyIncome;
  @override
  String get parentEducation; // 'None' | 'Primary' | 'Secondary' | 'Higher'
  @override
  bool get hasStudyDevice;
  @override
  bool get studentWorks; // Health
  @override
  String get nutritionStatus; // 'Normal' | 'Underweight' | 'Malnourished'
  @override
  int get healthAbsences;
  @override
  String get menstrualHygiene; // 'Adequate' | 'Inadequate' | 'None'
  @override
  bool get hasLongTermIllness; // Home & Social
  @override
  String get parentAttitude; // 'Supportive' | 'Neutral' | 'Not supportive'
  @override
  bool get earlyMarriageRisk;
  @override
  int get householdWorkHours;
  @override
  bool get familyMigrates; // Safety & Access
  @override
  double get distanceToSchool;
  @override
  String get travelMode; // 'Walk' | 'Public transport' | 'Private'
  @override
  bool get routeSafetyConcerns;
  @override
  bool get girlsToiletsAvailable;

  /// Create a copy of Student
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentImplCopyWith<_$StudentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
