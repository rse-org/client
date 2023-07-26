// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Result {
  String? get userId => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  int get numRight => throw _privateConstructorUsedError;
  int get numWrong => throw _privateConstructorUsedError;
  List<dynamic> get answers => throw _privateConstructorUsedError;
  List<dynamic> get correctAnswers => throw _privateConstructorUsedError;
  List<Question> get questions => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ResultCopyWith<Result> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultCopyWith<$Res> {
  factory $ResultCopyWith(Result value, $Res Function(Result) then) =
      _$ResultCopyWithImpl<$Res, Result>;
  @useResult
  $Res call(
      {String? userId,
      String time,
      int numRight,
      int numWrong,
      List<dynamic> answers,
      List<dynamic> correctAnswers,
      List<Question> questions,
      double score,
      String name,
      String username});
}

/// @nodoc
class _$ResultCopyWithImpl<$Res, $Val extends Result>
    implements $ResultCopyWith<$Res> {
  _$ResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? time = null,
    Object? numRight = null,
    Object? numWrong = null,
    Object? answers = null,
    Object? correctAnswers = null,
    Object? questions = null,
    Object? score = null,
    Object? name = null,
    Object? username = null,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      numRight: null == numRight
          ? _value.numRight
          : numRight // ignore: cast_nullable_to_non_nullable
              as int,
      numWrong: null == numWrong
          ? _value.numWrong
          : numWrong // ignore: cast_nullable_to_non_nullable
              as int,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ResultCopyWith<$Res> implements $ResultCopyWith<$Res> {
  factory _$$_ResultCopyWith(_$_Result value, $Res Function(_$_Result) then) =
      __$$_ResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? userId,
      String time,
      int numRight,
      int numWrong,
      List<dynamic> answers,
      List<dynamic> correctAnswers,
      List<Question> questions,
      double score,
      String name,
      String username});
}

/// @nodoc
class __$$_ResultCopyWithImpl<$Res>
    extends _$ResultCopyWithImpl<$Res, _$_Result>
    implements _$$_ResultCopyWith<$Res> {
  __$$_ResultCopyWithImpl(_$_Result _value, $Res Function(_$_Result) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? time = null,
    Object? numRight = null,
    Object? numWrong = null,
    Object? answers = null,
    Object? correctAnswers = null,
    Object? questions = null,
    Object? score = null,
    Object? name = null,
    Object? username = null,
  }) {
    return _then(_$_Result(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      numRight: null == numRight
          ? _value.numRight
          : numRight // ignore: cast_nullable_to_non_nullable
              as int,
      numWrong: null == numWrong
          ? _value.numWrong
          : numWrong // ignore: cast_nullable_to_non_nullable
              as int,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      correctAnswers: null == correctAnswers
          ? _value._correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Result implements _Result {
  _$_Result(
      {this.userId,
      required this.time,
      this.numRight = 0,
      this.numWrong = 0,
      required final List<dynamic> answers,
      final List<dynamic> correctAnswers = const [],
      required final List<Question> questions,
      this.score = 0,
      this.name = '',
      this.username = ''})
      : _answers = answers,
        _correctAnswers = correctAnswers,
        _questions = questions;

  @override
  final String? userId;
  @override
  final String time;
  @override
  @JsonKey()
  final int numRight;
  @override
  @JsonKey()
  final int numWrong;
  final List<dynamic> _answers;
  @override
  List<dynamic> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  final List<dynamic> _correctAnswers;
  @override
  @JsonKey()
  List<dynamic> get correctAnswers {
    if (_correctAnswers is EqualUnmodifiableListView) return _correctAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_correctAnswers);
  }

  final List<Question> _questions;
  @override
  List<Question> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  @JsonKey()
  final double score;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String username;

  @override
  String toString() {
    return 'Result(userId: $userId, time: $time, numRight: $numRight, numWrong: $numWrong, answers: $answers, correctAnswers: $correctAnswers, questions: $questions, score: $score, name: $name, username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Result &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.numRight, numRight) ||
                other.numRight == numRight) &&
            (identical(other.numWrong, numWrong) ||
                other.numWrong == numWrong) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            const DeepCollectionEquality()
                .equals(other._correctAnswers, _correctAnswers) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      time,
      numRight,
      numWrong,
      const DeepCollectionEquality().hash(_answers),
      const DeepCollectionEquality().hash(_correctAnswers),
      const DeepCollectionEquality().hash(_questions),
      score,
      name,
      username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ResultCopyWith<_$_Result> get copyWith =>
      __$$_ResultCopyWithImpl<_$_Result>(this, _$identity);
}

abstract class _Result implements Result {
  factory _Result(
      {final String? userId,
      required final String time,
      final int numRight,
      final int numWrong,
      required final List<dynamic> answers,
      final List<dynamic> correctAnswers,
      required final List<Question> questions,
      final double score,
      final String name,
      final String username}) = _$_Result;

  @override
  String? get userId;
  @override
  String get time;
  @override
  int get numRight;
  @override
  int get numWrong;
  @override
  List<dynamic> get answers;
  @override
  List<dynamic> get correctAnswers;
  @override
  List<Question> get questions;
  @override
  double get score;
  @override
  String get name;
  @override
  String get username;
  @override
  @JsonKey(ignore: true)
  _$$_ResultCopyWith<_$_Result> get copyWith =>
      throw _privateConstructorUsedError;
}
