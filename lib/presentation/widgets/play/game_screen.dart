import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/all.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int idx = 0;
  DateTime start = DateTime.now();

  List<Question> questions = [];

  @override
  void initState() {
    super.initState();
    getQuestions();
    setScreenName('/play/game');
  }

  onAnswer() {
    logPlayAnswerSelect();
    setState(() {
      idx += 1;
    });
    if (idx + 1 == 11) {
      logPlayEnd(start);
      BlocProvider.of<NavBloc>(context).add(EndQuiz());
    }
  }

  getQuestions() async {
    try {
      // ignore: await_only_futures
      final playService = await PlayService();
      setState(() {
        questions = playService.questions;
      });
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  buildQuestion(Question q, int i) {
    if (i != idx) return const SizedBox(width: 0, height: 0);
    List<Widget> answers = [
      buildAnswerButton(q.c1),
      buildAnswerButton(q.c2),
      buildAnswerButton(q.answer),
      buildAnswerButton(q.c3),
    ];
    answers.shuffle();
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  q.body,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${i + 1} of 10',
                  style: TextStyle(
                    fontSize: 15,
                    decoration: TextDecoration.none,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: answers,
            ),
          )
        ],
      ),
    );
  }

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

  Widget buildAnswerButton(a) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 100,
        child: TextButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 50),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.blue,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ),
          ),
          onPressed: () {
            onAnswer();
          },
          child: SingleChildScrollView(child: Text(a)),
        ),
      ),
    );
  }
}
