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
  PlayDone();
}

abstract class PlayEvent extends Equatable {
  @override
  List<Object> get props => [];
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

class ResultsCalculated extends PlayEvent {
  ResultsCalculated();
}
