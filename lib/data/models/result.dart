import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rse/all.dart';

part 'result.freezed.dart';

@freezed
class Result with _$Result {
  factory Result({
    String? userId,
    required String time,
    required int numRight,
    required int numWrong,
    required double score,
    required List answers,
    required String username,
    @Default('') String? name,
    required List correctAnswers,
    required List<Question> questions,
  }) = _Result;
}
