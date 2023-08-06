import 'package:flutter/material.dart';

class NumberPrompt extends StatelessWidget {
  final int idx;
  final int length;
  const NumberPrompt({super.key, required this.idx, required this.length});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${idx + 1} of $length',
      style: const TextStyle(
        fontSize: 15,
        decoration: TextDecoration.none,
      ),
    );
  }
}
