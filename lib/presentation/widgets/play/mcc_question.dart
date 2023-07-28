import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rse/all.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MCCQuestion extends StatefulWidget {
  final Widget prompt;
  final Question q;
  final Function onAnswer;
  const MCCQuestion(
      {super.key,
      required this.q,
      required this.onAnswer,
      required this.prompt});

  @override
  State<MCCQuestion> createState() => _MCCQuestionState();
}

class _MCCQuestionState extends State<MCCQuestion> {
  int count = 0;
  late Timer timer;
  List<Point> data = [];
  List<Point> newData = [];
  List<double> yMapper = [0, 10];
  // ignore: unused_field
  ChartSeriesController? _chartSeriesController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildQuestionContainer(context),
        buildChart(),
        buildButtonContainer(context),
      ],
    );
  }

  Expanded buildAnswerButton(a) {
    return Expanded(
      flex: 1,
      child: ElevatedButton(
        onPressed: () {
          widget.onAnswer(a);
        },
        child: SingleChildScrollView(
          child: Text(a),
        ),
      ),
    );
  }

  buildButtonContainer(BuildContext context) {
    var answers = List.from(widget.q.answerBank!);
    answers.add(widget.q.answer);
    answers.shuffle();
    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              buildAnswerButton(answers[0]),
              const SizedBox(width: 10),
              buildAnswerButton(answers[1]),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              buildAnswerButton(answers[2]),
              const SizedBox(width: 10),
              buildAnswerButton(answers[3]),
            ],
          ),
        ],
      ),
    );
  }

  SfCartesianChart buildChart() {
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
          dataSource: data,
          animationDuration: 1000,
          yValueMapper: (Point sales, _) => sales.y,
          xValueMapper: (Point sales, _) => sales.x.toInt(),
          markerSettings: const MarkerSettings(isVisible: true),
          pointColorMapper: (Point sales, _) => sales.pointColorMapper,
          onRendererCreated: (ChartSeriesController c) {
            _chartSeriesController = c;
          },
        )
      ],
    );
  }

  buildQuestionContainer(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.prompt,
        Row(
          children: [
            Flexible(
              child: Text(
                  regularizeSentence('${widget.q.sym} ${widget.q.context!}'),
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(regularizeSentence(widget.q.body),
                style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      data = List.from(widget.q.data ?? []);
      newData = List.from(widget.q.newData ?? []);
    });
    setHeight();
    startTimer();
  }

  void setHeight() {
    final all = (List.from((widget.q.data ?? []) + (widget.q.newData ?? [])));
    final lo = all.map((d) => d.y as double).reduce(min);
    final hi = all.map((d) => d.y as double).reduce(max);
    yMapper = [lo, hi];
  }

  double setWidth() {
    final length =
        (widget.q.data!.length + widget.q.newData!.length).toDouble();
    return length == 0 ? 10 : length - 1;
  }

  startTimer() {
    Timer.periodic(const Duration(seconds: 1), updateSource);
  }

  void updateSource(Timer t) {
    timer = t;
    final renderNewDone = count > widget.q.newData!.length - 1;

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
}
