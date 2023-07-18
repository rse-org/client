import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/all.dart';

class TestScreen extends StatefulWidget {
  Function onPress;
  TestScreen({super.key, required this.onPress});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int count = 0;
  late Timer timer;
  List<Point> data = [];
  List<Point> newData = [];
  List<Question> questions = [];
  Question currentQuestion = Question.defaultQuestion();
  // ignore: unused_field
  ChartSeriesController? _chartSeriesController;

  @override
  void initState() {
    super.initState();
    getChartQuestions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getChartQuestions() async {
    try {
      final resp = await QuestionApi.getChartQuestions();
      setData(resp);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      timer = Timer.periodic(const Duration(seconds: 1), updateSource);
    }
  }

  setData(resp) {
    final qs = List<Question>.from(resp);
    qs.shuffle();
    setState(() {
      count = 0;
      questions = qs;
      currentQuestion = resp[0];
      data = List.from(resp[0].data);
      newData = List.from(resp[0].newData);
    });
    setHeight();
    sleep(const Duration(seconds: 2));
  }

  void updateSource(Timer timer) {
    final renderNewDone = count > currentQuestion.newData!.length - 1;
    if (renderNewDone) {
      timer.cancel();
      return;
    }
    final point = newData[count];
    data.add(point);
    _chartSeriesController?.updateDataSource(
      addedDataIndexes: <int>[data.length - 1],
    );
    count = count + 1;
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), updateSource);
  }

  @override
  Widget build(BuildContext context) {
    final loading = questions.isEmpty || currentQuestion.data!.isEmpty;
    if (loading) return const Spinner();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: const Text(
                  'Play Quiz 📖',
                ),
                onPressed: () => widget.onPress(),
              ),
              TextButton(
                child: const Text(
                  'Random Question 🎲',
                ),
                onPressed: () {
                  setData(questions);
                  startTimer();
                },
              ),
            ],
          ),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(
              minimum: 0,
              maximum: setWidth(),
            ),
            primaryYAxis: CategoryAxis(
              minimum: yMapper[0],
              maximum: yMapper[1],
            ),
            series: <ChartSeries<Point, num>>[
              LineSeries<Point, num>(
                dataSource: data,
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
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(currentQuestion.context),
              Text(currentQuestion.body),
              SizedBox(height: 20),
              Text(currentQuestion.answerBank[0]),
              Text(currentQuestion.answerBank[1]),
              Text(currentQuestion.answerBank[2]),
              Text(currentQuestion.answerBank[3]),
            ],
          )
        ],
      ),
    );
  }

  List<double> yMapper = [0, 10];

  setHeight() {
    final all = (List.from(currentQuestion.data! + currentQuestion.newData!));
    final lo = all.map((d) => d.y as double).reduce(min);
    final hi = all.map((d) => d.y as double).reduce(max);
    yMapper = [lo, hi];
  }

  double setWidth() {
    final length =
        (currentQuestion.data!.length + currentQuestion.newData!.length)
            .toDouble();
    return length == 0 ? 10 : length + 1;
  }
}
