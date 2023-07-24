import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rse/all.dart';

// * 7/18/23
// * No way to filter rows on a sheet.
// * https://rb.gy/zk4bt
// * We can just load the entire sheet then filter.
// * Good place to have a spinner/loading screen and prompts.

const chartUrl =
    'https://sheets.googleapis.com/v4/spreadsheets/1FAjhtJfgRr_yHHFINKRy9S2Ja39q666Do67xrYsoDIs/values/chart!A2:L100?key=AIzaSyDo3so2R7VF4U2IjcC8fNo-HQM-7TJcrR0';

const sheetUrl =
    'https://sheets.googleapis.com/v4/spreadsheets/1FAjhtJfgRr_yHHFINKRy9S2Ja39q666Do67xrYsoDIs/values/questions!A2:J11?key=AIzaSyDo3so2R7VF4U2IjcC8fNo-HQM-7TJcrR0';

List<String> split(String str) {
  final List<String> parts = str.split('. ');
  return List<String>.from(parts);
}

List<Point> splitData(String str, bool isNew) {
  String trimmed = str.trim().split(RegExp(r'\s+')).join(' ');
  final parts = trimmed.split(' ');
  return parts.asMap().entries.map((entry) {
    final idx = entry.key.toDouble() + (isNew ? parts.length - 3 : 0);
    final val = double.parse(entry.value);
    return Point(idx, val,
        isNew || idx == parts.length - 3 ? Colors.green : Colors.blue);
  }).toList();
}

class PlayService {
  String skill = '';
  String category = '';
  List<Question> game = [];
  List<Question> questions = [];
  List<Question> quizQuestions = [];

  PlayService() {
    loadQuestions();
  }

  Future<List<Question>> loadQuestions() async {
    String j = await rootBundle.loadString('assets/questions.json');
    List<dynamic> list = jsonDecode(j);

    for (var q in list) {
      questions.add(Question.fromJson(q));
    }
    questions.shuffle();
    return questions;
  }

  prepareQuiz() async {
    final mcQuestions = await loadQuestions();
    final chartQuestions = await getChartQuestions();
    mcQuestions.shuffle();
    chartQuestions.shuffle();
    quizQuestions.addAll(mcQuestions.take(5).toList());
    quizQuestions.addAll(chartQuestions.take(5).toList());
  }

  static Future getChartQuestions() async {
    try {
      final response = await http.get(Uri.parse(chartUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Question> questions = [];

        // ! Don't reorder these guys.
        // ! Google sheets returns an array so the order of question[index] matters
        for (final question in data['values']) {
          final j = {
            'sym': question[0],
            'data': splitData(question[1], false),
            'newData': splitData(question[3], true),
            'context': question[4],
            'body': question[5],
            'answer': question[6],
            'answerBank': split(question[7]),
            'explanation': question[8],
            'explanationBank': split(question[9]),
            'type': question[10],
          };
          final q = Question.fromJson(j);
          questions.add(q);
        }
        return questions;
      }
    } catch (e) {
      p('Error: $e');
    }
  }
}

class Point {
  final double x;
  final double y;
  final Color pointColorMapper;
  Point(this.x, this.y, this.pointColorMapper);
}
