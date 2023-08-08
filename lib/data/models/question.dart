import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rse/all.dart';

part 'question.freezed.dart';
part 'question.g.dart';

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
        c1: '',
        c2: '',
        c3: '',
        sym: '',
        type: '',
        body: '',
        answer: '',
        context: '',
        explanation: '',
        answerBank: ['', '', ''],
        explanationBank: ['', '', '', ''],
        data: [Point(x: 0, y: 0)],
        newData: [Point(x: 0, y: 0)],
      );
  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
