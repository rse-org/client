import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/all.dart';

class Spinner extends StatefulWidget {
  const Spinner({super.key});

  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with TickerProviderStateMixin {
  late AnimationController controller;
  bool determinate = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        value: controller.value,
        semanticsLabel: 'Circular progress indicator',
      ),
    );
  }
}

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int count = 0;
  late Timer mytimer;
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
    // sleep(const Duration(seconds: 2));
    renderChart();
  }

  renderChart() {
    mytimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        addChartData();
      },
    );
  }

  addChartData() {
    final newDataRendered = count > currentQuestion.newData!.length - 1;
    if (newDataRendered) {
      mytimer.cancel();
    } else {
      setState(() {
        data = getChartData();
      });
    }
  }

  List<Point> getChartData() {
    data.add(newData[count]);
    _chartSeriesController?.updateDataSource(
      addedDataIndexes: [newData[count].x.toInt()],
    );
    count = count + 1;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    if (questions.length == 0) {
      return Spinner();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextButton(
            child: const Text(
              'Random Question 🎲',
            ),
            onPressed: () => setData(questions),
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

  void onMarkerRender(MarkerRenderArgs args) {
    final point = args.pointIndex;
    if (point == null) return;
    if (data[point] == data.first) {
      args.markerWidth = 10;
      args.markerHeight = 10;
    }
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
    return length == 0 ? 10 : length;
  }
}
