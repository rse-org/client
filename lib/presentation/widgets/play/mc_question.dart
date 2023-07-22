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
                prompt,
                Text(
                  q.body,
                  style: TextStyle(
                    fontSize: isS(context) ? 20 : 30,
                    color: Colors.white,
                    decoration: TextDecoration.none,
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

  // TODO: UI/UX - Make grid on web and column on web
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
              Colors.green,
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
