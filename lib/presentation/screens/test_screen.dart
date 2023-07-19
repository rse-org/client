import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/all.dart';

class TestScreen extends StatefulWidget {
  final Function onPress;
  const TestScreen({super.key, required this.onPress});

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

  setData(resp) async {
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
    await Future.delayed(const Duration(seconds: 3));
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildPlayOptions(),
        buildChart(),
        buildQuestionContainer(context),
        buildButtonContainer(context),
      ],
    );
  }

  SfCartesianChart buildChart() {
    return SfCartesianChart(
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
    );
  }

  Row buildPlayOptions() {
    return Row(
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
    );
  }

  Container buildQuestionContainer(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: MediaQuery.of(context).size.height * .25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                currentQuestion.context,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                currentQuestion.body,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    setData(questions);
                    startTimer();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(56, 56),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: Text(
                    currentQuestion.answerBank[0],
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
                    setData(questions);
                    startTimer();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(56, 56),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: Text(
                    currentQuestion.answerBank[1],
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
                    setData(questions);
                    startTimer();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(56, 56),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: Text(
                    currentQuestion.answerBank[2],
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
                    setData(questions);
                    startTimer();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(56, 56),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: Text(
                    currentQuestion.answerBank[3],
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
    return length == 0 ? 10 : length;
  }
}