import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rse/all.dart';

List<String> splitAndNormalize(String str) {
  final List<String> parts = str.trim().split('.');
  final List<String> normalizedParts = parts
      .where((part) => part.trim().isNotEmpty)
      .map((part) => '${part.trim()}.')
      .toList();
  return normalizedParts;
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
  List<Question> mcQuestions = [];
  List<Question> chartQuestions = [];
  List<Question> quizQuestions = [];

  PlayService() {
    loadMCQuestions();
  }

  clearQuizQuestions() {
    mcQuestions = [];
    chartQuestions = [];
    quizQuestions = [];
  }

  Future loadMCCQuestions() async {
    try {
      final response = await http.get(Uri.parse(urlChart));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Question> questions = [];

        // ! Don't reorder these guys.
        // ! Google sheets returns an array so the order of question[index] matters
        for (final question in data['values']) {
          final j = _getQuestionObject(question);
          final q = Question.fromJson(j);
          questions.add(q);
        }
        questions.shuffle();
        chartQuestions.addAll(questions);
      }
    } catch (e) {
      p('Error: $e');
    }
  }

  Future loadMCQuestions() async {
    String j = await rootBundle.loadString('assets/questions.json');
    for (var q in jsonDecode(j)) {
      mcQuestions.add(Question.fromJson(q));
    }
    mcQuestions.shuffle();
  }

  prepareQuiz(dev) async {
    await loadMCQuestions();
    await loadMCCQuestions();

    if (dev || kDebugMode) {
      quizQuestions.addAll(mcQuestions.take(1).toList());
      // quizQuestions.addAll(chartQuestions.take(1).toList());
    } else {
      quizQuestions.addAll(mcQuestions.take(5).toList());
      quizQuestions.addAll(chartQuestions.take(5).toList());
    }
  }

  Map<String, dynamic> _getQuestionObject(question) {
    return {
      'sym': question[0],
      'data': splitData(question[1], false),
      'newData': splitData(question[3], true),
      'context': question[4],
      'body': question[5],
      'answer': question[6],
      'answerBank': splitAndNormalize(question[7]),
      'explanation': question[8],
      'explanationBank': splitAndNormalize(question[9]),
      'type': question[10],
    };
  }
}

class Point {
  final double x;
  final double y;
  final Color pointColorMapper;
  Point(this.x, this.y, this.pointColorMapper);
}
