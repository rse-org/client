import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:rse/all.dart';

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
  Question currentQuestion = Question.defaultQuestion();
  late List<Question> questions = [];
  // ignore: unused_field
  ChartSeriesController? _chartSeriesController;

  @override
  void initState() {
    super.initState();
    getChartQuestions();
  }

  getChartQuestions() async {
    try {
      final questions = await QuestionApi.getChartQuestions();
      setState(() {
        data = List.from(questions[0].data);
        newData = questions[0].newData;
        currentQuestion = questions[0];
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      sleep(const Duration(seconds: 1));
      renderChart();
    }
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
    count = count + 1;
    return data;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            child: const Text(
              'Add data point',
            ),
            onPressed: () {
              addChartData();
              // _chartSeriesController?.animate();
            },
          ),
          SfCartesianChart(
            primaryXAxis: CategoryAxis(
              minimum: 0,
              maximum: setWidth(),
            ),
            series: <ChartSeries<Point, num>>[
              LineSeries<Point, num>(
                dataSource: data,
                animationDuration: 1000,
                xValueMapper: (Point sales, _) => sales.x.toInt(),
                yValueMapper: (Point sales, _) => sales.y,
                onRendererCreated: (ChartSeriesController controller) {
                  _chartSeriesController = controller;
                },
              )
            ],
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Bank of America has an earnings report being release next week. You expect the price to drop from \$28 a share to \$25. How can you capitalize?'),
              SizedBox(height: 20),
              Text('Purchase a put option'),
              Text('Purchase a call option'),
            ],
          )
        ],
      ),
    );
  }

  double setWidth() {
    final length =
        (currentQuestion.data!.length + currentQuestion.newData!.length)
            .toDouble();
    return length == 0 ? 5 : length;
  }
}
