import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:rse/all.dart';

// * 7/18/23
// * No way to filter rows on a sheet.
// * https://rb.gy/zk4bt
// * We can just load the entire sheet then filter.
// * Good place to have a spinner/loading screen and prompts.

class Point {
  final double x;
  final double y;
  final Color pointColorMapper;
  Point(this.x, this.y, this.pointColorMapper);
}

const sheetUrl =
    'https://sheets.googleapis.com/v4/spreadsheets/1FAjhtJfgRr_yHHFINKRy9S2Ja39q666Do67xrYsoDIs/values/questions!A2:J11?key=AIzaSyDo3so2R7VF4U2IjcC8fNo-HQM-7TJcrR0';

const chartUrl =
    'https://sheets.googleapis.com/v4/spreadsheets/1FAjhtJfgRr_yHHFINKRy9S2Ja39q666Do67xrYsoDIs/values/chart!A2:L100?key=AIzaSyDo3so2R7VF4U2IjcC8fNo-HQM-7TJcrR0';

class PlayService {
  String skill = '';
  String category = '';
  List<Question> game = [];
  List<Question> questions = [];

  PlayService() {
    loadQuestions();
    prepareQuestions();
  }

  prepareQuestions() async {
    final mcQuestions = await loadQuestions();
    final chartQuestions = await getChartQuestions();
    mcQuestions.shuffle();
    chartQuestions.shuffle();
    questions.addAll(mcQuestions.take(5).toList());
    questions.addAll(chartQuestions.take(5).toList());
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
            'newData': splitData(question[2], true),
            'context': question[3],
            'body': question[4],
            'answer': question[5],
            'explanation': question[6],
            'answerBank': split(question[7]),
            'explanationBank': split(question[8]),
            'type': question[9],
          };
          final q = Question.fromJson(j);
          questions.add(q);
        }
        return questions;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }
}

List<String> split(String str) {
  final List<String> parts = str.split('. ');
  return List<String>.from(parts);
}

List<Point> splitData(String str, bool isNew) {
  String trimmed = str.trim().split(RegExp(r'\s+')).join(' ');

  final parts = trimmed.split(' ');
  return parts.asMap().entries.map((entry) {
    final idx = entry.key.toDouble() + (isNew ? parts.length - 2 : 0);
    final val = double.parse(entry.value);
    return Point(idx, val,
        isNew || idx == parts.length - 1 ? Colors.green : Colors.blue);
  }).toList();
}
