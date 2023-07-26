part of 'play_bloc.dart';

class HitNext extends PlayEvent {
  HitNext();
}

class HitPrev extends PlayEvent {
  HitPrev();
}

class PickedCategory extends PlayEvent {
  PickedCategory();
}

class PickedDifficulty extends PlayEvent {
  PickedDifficulty();
}

class PlayDone extends PlayEvent {
  final DateTime start;
  PlayDone(this.start);
}

abstract class PlayEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlayInitial extends PlayEvent {
  PlayInitial();
}

class PlayInitialized extends PlayEvent {
  PlayInitialized();
}

class PlayStarted extends PlayEvent {
  PlayStarted();
}

class QuestionAnswered extends PlayEvent {
  final String ans;
  QuestionAnswered({required this.ans});
  @override
  List<String> get props => [ans];
}

class QuestionsRetrieved extends PlayEvent {
  final List<Question> questions;
  QuestionsRetrieved({required this.questions});
  @override
  List<Question> get props => questions;
}

class ResultsCalculated extends PlayEvent {
  ResultsCalculated();
}
