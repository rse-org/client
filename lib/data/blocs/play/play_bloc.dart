import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rse/all.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  int idx = 0;
  bool dev = kDebugMode;
  List<bool> results = [];
  List<String> answers = [];
  List<Question> questions = [];
  final PlayService playService = PlayService();
  Question currentQuestion = Question.defaultQuestion();

  PlayBloc() : super(PlaySetup()) {
    on<SetDev>((event, emit) async {
      try {
        dev = true;
      } catch (e) {
        p(e);
      }
    });
    on<PlayInitial>((event, emit) async {
      try {
        emit(PlaySetup());
      } catch (e) {
        p(e);
      }
    });
    on<PlayInitialized>((event, emit) async {
      try {
        await playService.prepareQuiz(dev);
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
        logEvent({'name': 'play_answer_select'});
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
        logPlayEnd(event.start);
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
        playService.clearQuizQuestions();
        LocalStorageService.playUpdateStreak();
        currentQuestion = Question.defaultQuestion();
        emit(PlayRoundFinished(result: result));
      } catch (e) {
        p(e);
      }
    });
    on<PlayResultCalculated>((event, emit) async {
      try {
        emit(ResultShow(event.result));
      } catch (e) {
        p(e);
      }
    });
  }
}
