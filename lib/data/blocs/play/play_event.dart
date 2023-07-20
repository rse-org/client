part of 'play_bloc.dart';

abstract class PlayEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SwitchQuestionType extends PlayEvent {
  SwitchQuestionType();
}

class GetQuestions extends PlayEvent {
  GetQuestions();
}

class CalculateResults extends PlayEvent {
  CalculateResults();
}

class SubmitResult extends PlayEvent {
  SubmitResult();
}
