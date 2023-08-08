// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Question _$$_QuestionFromJson(Map<String, dynamic> json) => _$_Question(
      type: json['type'] as String,
      body: json['body'] as String,
      answer: json['answer'] as String,
      explanation: json['explanation'] as String,
      c1: json['c1'] as String? ?? '',
      c2: json['c2'] as String? ?? '',
      c3: json['c3'] as String? ?? '',
      sym: json['sym'] as String? ?? '',
      context: json['context'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Point.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      newData: (json['newData'] as List<dynamic>?)
              ?.map((e) => Point.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      answerBank: (json['answerBank'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      explanationBank: (json['explanationBank'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_QuestionToJson(_$_Question instance) =>
    <String, dynamic>{
      'type': instance.type,
      'body': instance.body,
      'answer': instance.answer,
      'explanation': instance.explanation,
      'c1': instance.c1,
      'c2': instance.c2,
      'c3': instance.c3,
      'sym': instance.sym,
      'context': instance.context,
      'data': instance.data,
      'newData': instance.newData,
      'answerBank': instance.answerBank,
      'explanationBank': instance.explanationBank,
    };
