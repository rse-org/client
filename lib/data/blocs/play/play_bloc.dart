import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rse/all.dart';

part 'play_event.dart';
part 'play_state.dart';

calculateScore() {}

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

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  int idx = 0;
  List<Question> questions = [];
  Question currentQuestion = Question.defaultQuestion();
  final List<String> answers = [];
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
        final results = [];
        final end = DateTime.now();
        Duration diff = end.difference(event.start);
        String time = formatTimeDifference(diff);

        final correctAnswers = questions.map((q) => q.answer).toList();
        for (int i = 0; i < questions.length; i++) {
          String a = correctAnswers[i];
          final isRight = a == answers[i];
          results.add(isRight);
        }

        final numRight = results.where((r) => r).length;
        final numWrong = results.where((r) => !r).length;

        final score = (numRight / questions.length) * 100;

        final result = Result(
          time: time,
          score: score,
          username: '',
          answers: answers,
          numRight: numRight,
          numWrong: numWrong,
          questions: questions,
          correctAnswers: correctAnswers,
        );

        idx = 0;
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
