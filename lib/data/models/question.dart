import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rse/all.dart';

part 'question.freezed.dart';

@freezed
class Question with _$Question {
  factory Question({
    required String type,
    required String body,
    required String answer,
    required String explanation,
    @Default('') String c1,
    @Default('') String c2,
    @Default('') String c3,
    @Default('') String sym,
    @Default('') String? context,
    @Default([]) List<Point>? data,
    @Default([]) List<Point>? newData,
    @Default([]) List<String>? answerBank,
    @Default([]) List<String>? explanationBank,
  }) = _Question;

  factory Question.defaultQuestion() => Question(
        sym: '',
        data: [],
        newData: [],
        context: '',
        body: '',
        answer: '',
        answerBank: ['', '', ''],
        explanation: '',
        explanationBank: ['', '', '', ''],
        type: '',
        c1: '',
        c2: '',
        c3: '',
      );
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      body: json['body'] as String,
      answer: json['answer'] as String,
      c1: json['c1'] as String? ?? '',
      c2: json['c2'] as String? ?? '',
      c3: json['c3'] as String? ?? '',
      sym: json['sym'] as String? ?? '',
      data: json['data'] as List<Point>?,
      type: json['type'] as String? ?? '',
      newData: json['newData'] as List<Point>?,
      context: json['context'] as String? ?? '',
      explanation: json['explanation'] as String,
      answerBank: json['answerBank'] as List<String>?,
      explanationBank: json['explanationBank'] as List<String>?,
    );
  }
}
