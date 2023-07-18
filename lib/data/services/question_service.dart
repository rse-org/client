import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rse/all.dart';

import 'package:http/http.dart' as http;

// * 7/18/23
// * No way to filter rows on a sheet.
// * https://rb.gy/zk4bt
// * We can just load the entire sheet then filter.
// * Good place to have a spinner/loading screen and prompts.

class Point {
  final double x;
  final double y;
  Point(this.x, this.y);
}

const sheetUrl =
    'https://sheets.googleapis.com/v4/spreadsheets/1FAjhtJfgRr_yHHFINKRy9S2Ja39q666Do67xrYsoDIs/values/questions!A2:J11?key=AIzaSyDo3so2R7VF4U2IjcC8fNo-HQM-7TJcrR0';

const chartUrl =
    'https://sheets.googleapis.com/v4/spreadsheets/1FAjhtJfgRr_yHHFINKRy9S2Ja39q666Do67xrYsoDIs/values/chart!A2:L3?key=AIzaSyDo3so2R7VF4U2IjcC8fNo-HQM-7TJcrR0';

class QuestionApi {
  // static Future init() async {
  //   try {
  //     final response = await http.get(Uri.parse(sheetUrl));
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //     } else {
  //       throw Error();
  //     }
  //   } catch (e) {}
  // }

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
            'lo': double.parse(question[1]),
            'hi': double.parse(question[2]),
            'data': splitData(question[3], false),
            'newData': splitData(question[4], true),
            'context': question[5],
            'body': question[6],
            'answer': question[7],
            'explanation': question[8],
            'answerBank': split(question[9]),
            'explanationBank': split(question[10]),
            'type': question[11],
          };
          final q = Question.fromJson(j);
          questions.add(q);
        }
        return questions;
      } else {
        throw Error();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  static Future getData() async {}
}

List<String> split(String str) {
  final List<String> parts = str.split('. ');
  return List<String>.from(parts);
}

List<Point> splitData(String str, bool isNew) {
  String trimmed = str.trim().split(RegExp(r'\s+')).join(' ');

  final parts = trimmed.split(' ');
  return parts.asMap().entries.map((entry) {
    final idx = entry.key.toDouble() + (isNew ? parts.length : 0);
    final val = double.parse(entry.value);
    return Point(idx, val);
  }).toList();
}
