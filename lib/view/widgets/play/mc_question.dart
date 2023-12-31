import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class MCQuestion extends StatelessWidget {
  final Question q;
  final Widget prompt;
  final Function onAnswer;
  const MCQuestion(
      {super.key,
      required this.prompt,
      required this.q,
      required this.onAnswer});

  @override
  Widget build(BuildContext context) {
    List<Widget> answers = [
      buildAnswerButton(q.c1),
      buildAnswerButton(q.c2),
      buildAnswerButton(q.c3),
      buildAnswerButton(q.answer),
    ];
    answers.shuffle();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              prompt,
              buildText(
                  context, kIsWeb ? 'headlineLarge' : 'headlineSmall', q.body),
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
    );
  }

  // Todo: UI/UX - Make grid on web and column on web
  Widget buildAnswerButton(a) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: 100,
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 50),
            ),
          ),
          onPressed: () {
            onAnswer(a);
          },
          child: SingleChildScrollView(child: Text(a)),
        ),
      ),
    );
  }
}
