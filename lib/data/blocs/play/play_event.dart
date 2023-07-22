part of 'play_bloc.dart';

abstract class PlayEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlayInitialized extends PlayEvent {
  PlayInitialized();
}

class PickedDifficulty extends PlayEvent {
  PickedDifficulty();
}

class PickedCategory extends PlayEvent {
  PickedCategory();
}

class PlayStarted extends PlayEvent {
  PlayStarted();
}

class QuestionAnswered extends PlayEvent {
  QuestionAnswered();
}

class HitNext extends PlayEvent {
  HitNext();
}

class HitPrev extends PlayEvent {
  HitPrev();
}

class PlayDone extends PlayEvent {
  PlayDone();
}

class ResultsCalculated extends PlayEvent {
  ResultsCalculated();
}
