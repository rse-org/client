import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rse/all.dart';

part 'result.freezed.dart';

String getScore(val) {
  var outcome = '';
  if (val >= 90) {
    outcome = 'A';
  } else if (val >= 80) {
    outcome = 'B';
  } else if (val >= 70) {
    outcome = 'C';
  } else if (val >= 60) {
    outcome = 'D';
  } else {
    outcome = 'F';
  }
  return outcome;
}

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
    @Default('') String username,
    @Default([]) List correctAnswers,
    required List<Question> questions,
  }) = _Result;

  factory Result.fromDateTime({
    String? userId,
    String name = '',
    String username = '',
    required List answers,
    // required List results,
    required DateTime start,
    required List<Question> questions,
  }) {
    final end = DateTime.now();
    Duration diff = end.difference(start);
    String time = formatTimeDifference(diff);
    final correctAnswers = [];
    final results = [];
    for (int i = 0; i < questions.length; i++) {
      final q = questions[i];
      correctAnswers.add(q.answer);
      results.add(q.answer == answers[i]);
    }
    int numRight = 0;
    int numWrong = 0;
    for (final answer in results) {
      answer ? numRight++ : numWrong++;
    }
    return Result(
      name: name,
      time: time,
      userId: userId,
      answers: answers,
      numRight: numRight,
      numWrong: numWrong,
      username: username,
      questions: questions,
      correctAnswers: correctAnswers,
      score: questions.isNotEmpty ? (numRight / questions.length) * 100 : 0,
    );
  }
}
