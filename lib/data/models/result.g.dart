// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Result _$$_ResultFromJson(Map<String, dynamic> json) => _$_Result(
      userId: json['userId'] as String?,
      time: json['time'] as String,
      answers: json['answers'] as List<dynamic>,
      numRight: json['numRight'] as int? ?? 0,
      numWrong: json['numWrong'] as int? ?? 0,
      score: (json['score'] as num?)?.toDouble() ?? 0,
      name: json['name'] as String? ?? '',
      grade: json['grade'] as String? ?? '',
      username: json['username'] as String? ?? '',
      correctAnswers: json['correctAnswers'] as List<dynamic>? ?? const [],
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ResultToJson(_$_Result instance) => <String, dynamic>{
      'userId': instance.userId,
      'time': instance.time,
      'answers': instance.answers,
      'numRight': instance.numRight,
      'numWrong': instance.numWrong,
      'score': instance.score,
      'name': instance.name,
      'grade': instance.grade,
      'username': instance.username,
      'correctAnswers': instance.correctAnswers,
      'questions': instance.questions,
    };
