import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'package:rse/all.dart';

part 'question.freezed.dart';

@freezed
class Question with _$Question {
  factory Question({
    @Default('') String sym,
    @Default(null) double? lo,
    @Default(null) double? hi,
    @Default([]) List<Point>? data,
    @Default([]) List<Point>? newData,
    @Default('') String context,
    required String body,
    required String answer,
    required String explanation,
    @Default([]) List<String> answerBank,
    @Default([]) List<String> explanationBank,
    required String type,
    @Default('') String c1,
    @Default('') String c2,
    @Default('') String c3,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      sym: json['sym'] as String? ?? '',
      lo: json['lo'] as double?,
      hi: json['hi'] as double?,
      data: json['data'] as List<Point>?,
      newData: json['newData'] as List<Point>?,
      context: json['context'] as String? ?? '',
      body: json['body'] as String,
      answer: json['answer'] as String,
      explanation: json['explanation'] as String,
      answerBank: json['answerBank'] as List<String>,
      explanationBank: json['explanationBank'] as List<String>,
      type: json['type'] as String,
      c1: json['c1'] as String? ?? '',
      c2: json['c2'] as String? ?? '',
      c3: json['c3'] as String? ?? '',
    );
  }
  factory Question.defaultQuestion() => Question(
        sym: '',
        lo: null,
        hi: null,
        data: [],
        newData: [],
        context: '',
        body: '',
        answer: '',
        explanation: '',
        answerBank: ['', '', '', ''],
        explanationBank: ['', '', '', ''],
        type: '',
        c1: '',
        c2: '',
        c3: '',
      );
}
