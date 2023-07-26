import 'dart:async';

import 'package:flutter/material.dart';

class CountDownState extends State<CountDownTimer> {
  late int _counter;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Text(
      getFormattedTime(_counter),
      style: TextStyle(
        fontSize: 20,
        decoration: TextDecoration.none,
        color: _counter > 10
            ? Colors.green.withOpacity(0.5)
            : Colors.red.withOpacity(0.5),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String getFormattedTime(int timeInSeconds) {
    int minutes = timeInSeconds ~/ 60;
    int seconds = timeInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    _counter = widget.time;
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter <= 0) {
          _timer.cancel();
        } else {
          _counter--;
        }
      });
    });
  }
}

class CountDownTimer extends StatefulWidget {
  final int time;
  const CountDownTimer({super.key, required this.time});

  @override
  CountDownState createState() => CountDownState();
}
