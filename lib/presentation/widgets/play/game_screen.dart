import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:rse/all.dart';
import 'package:rse/data/blocs/play/all.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int idx = 0;
  int qIdx = 0;
  List<Question> questions = [];
  DateTime start = DateTime.now();
  final playService = PlayService();
  Question question = Question.defaultQuestion();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        // color: playBackgroundColors[faker.randomGenerator.integer(4)],
        color: Colors.black,
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<NavBloc>(context).add(EndQuiz());
                      },
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                    const CountDownTimer(time: 60),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Column(
                children: [
                  for (var index = 0; index < questions.length; index++)
                    buildQuestion(questions[index], index),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildPrompt(int i) {
    return Text(
      '${i + 1} of ${questions.length}',
      style: TextStyle(
        fontSize: 15,
        decoration: TextDecoration.none,
        color: Colors.white.withOpacity(0.6),
      ),
    );
  }

  buildQuestion(Question q, int i) {
    if (i != idx) return const SizedBox(width: 0, height: 0);
    final prompt = buildPrompt(i);
    if (q.type == 'mc') {
      return MCQuestion(prompt: prompt, q: q, onAnswer: onAnswer);
    }
    return MCCQuestion(
      q: q,
      prompt: prompt,
      onAnswer: onAnswer,
    );
  }

  getQuestions() async {
    await playService.prepareQuiz();
    try {
      setState(() {
        questions = playService.quizQuestions;
      });
    } catch (e) {
      p('Error: ${e.toString()}');
    }
  }

  @override
  void initState() {
    super.initState();
    setScreenName('/play/game');
    getQuestions();
  }

  onAnswer(a) {
    logPlayAnswerSelect();
    setState(() {
      idx += 1;
      qIdx += 1;
    });
    BlocProvider.of<PlayBloc>(context).add(QuestionAnswered(ans: a));
    if (idx == questions.length) {
      logPlayEnd(start);
      BlocProvider.of<NavBloc>(context).add(EndQuiz());
    }
  }
}
