import 'package:freezed_annotation/freezed_annotation.dart';

part 'question.freezed.dart';
part 'question.g.dart';

@freezed
class Question with _$Question {
  factory Question({
    required String body,
    required String answer,
    required String c1,
    required String c2,
    required String c3,
  }) = _Question;
  factory Question.fromJson(Map<String, Object?> json) =>
      _$QuestionFromJson(json);
}
