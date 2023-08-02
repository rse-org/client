part of 'play_bloc.dart';

class PlayError extends PlayState {
  final String error;

  PlayError(this.error);
  @override
  List<Object?> get props => [error];
}

class Playing extends PlayState {
  Playing();
  @override
  List<Object?> get props => [];
}

class PlayRoundFinished extends PlayState {
  final Result result;
  PlayRoundFinished({required this.result});

  @override
  List<Object?> get props => [result];
}

class PlaySetup extends PlayState {
  @override
  List<Object?> get props => [];
}

@immutable
abstract class PlayState extends Equatable {}

class Preparing extends PlayState {
  Preparing();
  @override
  List<Object?> get props => [];
}

class QuestionsLoadSuccess extends PlayState {
  final int idx;
  final List<Question> questions;
  final Question currentQuestion;
  QuestionsLoadSuccess({
    required this.idx,
    required this.questions,
    required this.currentQuestion,
  });
  @override
  List<Object?> get props => [questions, idx, currentQuestion];
}
