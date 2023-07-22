import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/all.dart';

class MCChartQuestion extends StatefulWidget {
  final Widget prompt;
  final Question question;
  final Function nextQuestion;
  const MCChartQuestion(
      {super.key,
      required this.question,
      required this.nextQuestion,
      required this.prompt});

  @override
  State<MCChartQuestion> createState() => _MCChartQuestionState();
}

class _MCChartQuestionState extends State<MCChartQuestion> {
  int count = 0;
  late Timer timer;
  List<Point> data = [];
  List<Point> newData = [];
  List<double> yMapper = [0, 10];
  // ignore: unused_field
  ChartSeriesController? _chartSeriesController;

  @override
  void initState() {
    super.initState();
    setState(() {
      data = List.from(widget.question.data!);
      newData = List.from(widget.question.newData!);
    });
    setHeight();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void updateSource(Timer t) {
    timer = t;
    final renderNewDone = count > widget.question.newData!.length - 1;

    if (renderNewDone) {
      timer.cancel();
      return;
    }
    // ! No blink but no animation
    // final point = newData[count];
    // data.add(point);
    // _chartSeriesController?.updateDataSource(
    //   addedDataIndexes: <int>[data.length - 1],
    // );
    // count = count + 1;

    // ! Animation with blink
    final point = newData[count];
    data.add(point);
    setState(() {
      count += 1;
      data = data;
    });
  }

  startTimer() {
    Timer.periodic(const Duration(seconds: 1), updateSource);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildQuestionContainer(context),
        buildChart(data),
        buildButtonContainer(context),
      ],
    );
  }

  SfCartesianChart buildChart(d) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        minimum: 0,
        maximum: setWidth(),
        isVisible: false,
      ),
      primaryYAxis: CategoryAxis(
        minimum: yMapper[0],
        maximum: yMapper[1],
      ),
      series: <ChartSeries<Point, num>>[
        LineSeries<Point, num>(
          dataSource: d,
          animationDuration: 1000,
          xValueMapper: (Point sales, _) => sales.x.toInt(),
          yValueMapper: (Point sales, _) => sales.y,
          pointColorMapper: (Point sales, _) => sales.pointColorMapper,
          markerSettings: const MarkerSettings(isVisible: true),
          onRendererCreated: (ChartSeriesController c) {
            _chartSeriesController = c;
          },
        )
      ],
    );
  }

  Container buildQuestionContainer(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: isS(context) ? null : MediaQuery.of(context).size.height * .25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.prompt,
          Row(
            children: [
              Flexible(
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isS(context) ? 20 : 30,
                    fontWeight: FontWeight.bold,
                  ),
                  child: Text(
                    regularizeSentence(widget.question.context!),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                ),
                child: Text(
                  regularizeSentence(widget.question.body),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  buildButtonContainer(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      widget.nextQuestion();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(56, 56),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Text(
                      widget.question.answerBank![0],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      widget.nextQuestion();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(56, 56),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Text(
                      widget.question.answerBank![1],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      widget.nextQuestion();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(56, 56),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Text(
                      widget.question.answerBank![2],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      widget.nextQuestion();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(56, 56),
                      padding: const EdgeInsets.all(16),
                    ),
                    child: Text(
                      widget.question.answerBank![3],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void setHeight() {
    final all = (List.from(widget.question.data! + widget.question.newData!));
    final lo = all.map((d) => d.y as double).reduce(min);
    final hi = all.map((d) => d.y as double).reduce(max);
    yMapper = [lo, hi];
  }

  double setWidth() {
    final length =
        (widget.question.data!.length + widget.question.newData!.length)
            .toDouble();
    return length == 0 ? 10 : length - 1;
  }
}

String regularizeSentence(String sentence) {
  // Remove extra spaces between words
  String normalizedSentence = sentence.replaceAll(RegExp(r'\s+'), ' ');

  // Remove spaces between period and end
  normalizedSentence = normalizedSentence.replaceAll(RegExp(r'\.\s+'), '.');

  // Remove any leading or trailing spaces
  return normalizedSentence.trim();
}
