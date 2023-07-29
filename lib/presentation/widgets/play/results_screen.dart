import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/all.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> r = {'grade': 'a', 'score': 1};
    final score = r['score'];
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '${getPromptFromGrade(r['grade'])} \n$score',
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
                BlocProvider.of<NavBloc>(context).add(EndQuiz());
              },
              child: const Text('Finish'),
            ),
          ],
        )
      ],
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
}
