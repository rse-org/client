import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rse/all.dart';

part 'result.freezed.dart';
part 'result.g.dart';

@freezed
class Result with _$Result {
  factory Result({
    String? userId,
    required String time,
    required List answers,
    @Default(0) int numRight,
    @Default(0) int numWrong,
    @Default(0) double score,
    @Default('') String name,
    @Default('') String grade,
    @Default('') String username,
    @Default([]) List correctAnswers,
    required List<Question> questions,
  }) = _Result;

  factory Result.fromDateTime({
    String? userId,
    String name = '',
    String username = '',
    required List answers,
    required DateTime start,
    required List<Question> questions,
  }) {
    final results = [];
    final correctAnswers = [];
    final end = DateTime.now();
    Duration diff = end.difference(start);
    String time = formatTimeDifference(diff);
    for (int i = 0; i < questions.length; i++) {
      final q = questions[i];
      correctAnswers.add(q.answer);
      results.add(q.answer == answers[i]);
    }
    int right = 0;
    int wrong = 0;
    for (final answer in results) {
      answer ? right++ : wrong++;
    }
    final score = questions.isNotEmpty ? (right / questions.length) * 100 : 0;
    return Result(
      name: name,
      time: time,
      userId: userId,
      numRight: right,
      numWrong: wrong,
      answers: answers,
      username: username,
      questions: questions,
      grade: getGrade(score),
      score: score.toDouble(),
      correctAnswers: correctAnswers,
    );
  }

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}
