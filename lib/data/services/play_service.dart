import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:rse/all.dart';

class PlayService {
  List<Question> questions = [];

  PlayService() {
    loadQuestions();
  }

  Future<List<Question>> loadQuestions() async {
    String jsonString = await rootBundle.loadString('assets/questions.json');
    List<dynamic> jsonList = jsonDecode(jsonString);

    for (var json in jsonList) {
      Question question = Question.fromJson(json);
      questions.add(question);
    }
    questions.shuffle();
    return questions;
  }
}
