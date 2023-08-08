import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
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

  buildAnswerButton(a) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kIsWeb ? 10 : 5),
      child: SizedBox(
        height: kIsWeb ? 100 : 50,
        child: ElevatedButton(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(double.infinity, 50),
            ),
          ),
          onPressed: () {
            widget.onAnswer(a);
          },
          child: SingleChildScrollView(child: Text(a)),
        ),
      ),
    );
  }

  buildButtonContainer(BuildContext context) {
    var answers = List.from(widget.q.answerBank!);
    answers.add(widget.q.answer);
    answers.shuffle();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          buildAnswerButton(answers[0]),
          buildAnswerButton(answers[1]),
          buildAnswerButton(answers[2]),
          buildAnswerButton(answers[3])
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
          yValueMapper: (Point p, _) => p.y,
          xValueMapper: (Point p, _) => p.x.toInt(),
          markerSettings: const MarkerSettings(isVisible: true),
          pointColorMapper: (Point p, _) => Colors.white,
          onRendererCreated: (ChartSeriesController c) {
            _chartSeriesController = c;
          },
        )
      ],
    );
  }

  buildQuestionContainer(BuildContext context) {
    final heading = cleanse('${widget.q.sym} ${widget.q.context!}');
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.prompt,
          buildText(
              context, kIsWeb ? 'headlineLarge' : 'headlineSmall', heading),
          const SizedBox(height: 10),
          buildText(
              context, kIsWeb ? 'headlineSmall' : 'titleLarge', widget.q.body),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    try {
      timer.cancel();
    } catch (e) {
      p('MCC lag');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      data = List.from(widget.q.data ?? []);
      newData = List.from(widget.q.newData ?? []);
    });
    setHeight();
    haltAndFire(milliseconds: 250, fn: startTimer);
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
    try {
      final point = newData[count];
      data.add(point);
      setState(() {
        count += 1;
        data = data;
      });
    } catch (e) {
      p('MCC lag');
    }
  }
}
