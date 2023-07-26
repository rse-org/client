import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rse/all.dart';

part 'play_event.dart';
part 'play_state.dart';

calculateScore() {}

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  int idx = 0;
  List<bool> results = [];
  List<String> answers = [];
  List<Question> questions = [];
  Question currentQuestion = Question.defaultQuestion();
  final PlayService playService = PlayService();

  PlayBloc() : super(PlaySetup()) {
    on<PlayInitial>((event, emit) async {
      try {
        emit(PlaySetup());
      } catch (e) {
        p(e);
      }
    });
    on<PlayInitialized>((event, emit) async {
      try {
        await playService.prepareQuiz();
        final qs = playService.quizQuestions;
        questions = qs;
        currentQuestion = qs.first;
        emit(
          QuestionsLoadSuccess(
            idx: idx,
            questions: questions,
            currentQuestion: currentQuestion,
          ),
        );
      } catch (e) {
        p(e);
      }
    });
    on<PickedDifficulty>((event, emit) async {
      try {} catch (e) {
        p(e);
      }
    });
    on<PickedCategory>((event, emit) async {
      try {} catch (e) {
        p(e);
      }
    });
    on<PlayStarted>((event, emit) async {
      try {} catch (e) {
        p(e);
      }
    });
    on<QuestionsRetrieved>((event, emit) async {
      try {} catch (e) {
        p(e);
      }
    });
    on<QuestionAnswered>((event, emit) async {
      try {
        answers.add(event.ans);
        final answerCorrect = questions[idx].answer == event.ans;
        results.add(answerCorrect);
        idx += 1;
        if (idx < questions.length) {
          currentQuestion = questions[idx];
          emit(
            QuestionsLoadSuccess(
              idx: idx,
              questions: questions,
              currentQuestion: currentQuestion,
            ),
          );
        }
      } catch (e) {
        p(e);
      }
    });
    on<HitNext>((event, emit) async {
      try {} catch (e) {
        p(e);
      }
    });
    on<HitPrev>((event, emit) async {
      try {} catch (e) {
        p(e);
      }
    });
    on<PlayDone>((event, emit) async {
      try {
        final result = Result.fromDateTime(
          // results: results,
          answers: answers,
          start: event.start,
          questions: questions,
        );

        idx = 0;
        answers = [];
        results = [];
        questions = [];
        currentQuestion = Question.defaultQuestion();
        playService.clearQuizQuestions();

        emit(PlayRoundFinished(result: result));
      } catch (e) {
        p(e);
      }
    });
    on<ResultsCalculated>((event, emit) async {
      try {} catch (e) {
        p(e);
      }
    });
  }
}
