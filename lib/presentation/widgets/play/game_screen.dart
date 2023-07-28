import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/all.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  DateTime start = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<PlayBloc, PlayState>(
          listener: (context, state) {},
          builder: (context, state) {
            // Todo: Style dialog for score.
            // return buildResultDialog(context, state);
            if (state is PlayRoundFinished) {
              return buildResultDialog(context, state);
            }
            return buildQuestionContainer(context);
          },
        ),
      ),
    );
  }

  Expanded buildCrossAndTimerBar(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<NavBloc>(context).add(EndQuiz());
            },
            child: const Icon(Icons.close),
          ),
          const CountDownTimer(time: 60),
        ],
      ),
    );
  }

  buildPrompt(length, int i) {
    return Text(
      '${i + 1} of $length',
      style: const TextStyle(
        fontSize: 15,
        decoration: TextDecoration.none,
      ),
    );
  }

  buildQuestion(state) {
    final i = state.idx;
    final q = state.currentQuestion;
    final questions = state.questions;
    final length = questions.length;
    final prompt = buildPrompt(length, i);
    final last = length == 1 + i;
    if (q.type == 'mc') {
      return MCQuestion(
        q: q,
        prompt: prompt,
        onAnswer: (a) => onAnswer(a, last),
      );
    }
    return MCCQuestion(
      q: q,
      prompt: prompt,
      key: UniqueKey(),
      onAnswer: (a) => onAnswer(a, last),
    );
  }

  buildQuestionContainer(context) {
    return BlocBuilder<PlayBloc, PlayState>(
      builder: (context, state) {
        if (state is QuestionsLoadSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCrossAndTimerBar(context),
              Expanded(
                flex: 13,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: buildQuestion(state),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Dialog buildResultDialog(BuildContext context, state) {
    final r = state.result;
    final score = r.score;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${getPromptFromGrade(r.grade)} \n$score',
              style: const TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Finish'),
                ),
                OutlinedButton(
                  onPressed: () {
                    BlocProvider.of<PlayBloc>(context).add(PlayInitial());
                    BlocProvider.of<NavBloc>(context).add(EndQuiz());
                  },
                  child: const Text('Finish'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  getPromptFromGrade(grade) {
    String val;
    switch (grade) {
      case 'A':
        val = 'Excellent!';
        break;
      case 'B':
        val = 'Great!';
        break;
      case 'C':
        val = 'A for effort!';
        break;
      case 'D':
        val = 'Needs improvement!';
        break;
      default:
        val = 'Lost a lot of money!';
    }
    return val;
  }

  @override
  void initState() {
    super.initState();
    setScreenName('/play/game');
    BlocProvider.of<PlayBloc>(context).add(PlayInitialized());
  }

  onAnswer(a, last) {
    BlocProvider.of<PlayBloc>(context).add(QuestionAnswered(ans: a));
    if (last) {
      BlocProvider.of<PlayBloc>(context).add(PlayDone(start));
    }
  }
}
