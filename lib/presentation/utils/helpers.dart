import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rse/all.dart';

int calculateIntervals(period, data) {
  final map = {
    'live': 5,
    '1d': data.length ~/ 24,
    '1w': 30,
    '1m': 30,
    '3m': 30,
    'ytd': 12,
    '1y': 12,
  };

  return map[period] ?? 0;
}

String calculatePercentageChange(double newVal, double oldVal) {
  double gainLoss = getChangePercent(newVal, oldVal);
  String formatted = formatPercentage(gainLoss);
  return formatted;
}

String formatTime(DateTime startTime, DateTime endTime) {
  Duration difference = endTime.difference(startTime);
  int hours = difference.inHours;
  int minutes = difference.inMinutes.remainder(60);
  int seconds = difference.inSeconds.remainder(60);
  return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
}

Future<String> getBuildString() async {
  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    return packageName;
  } on Exception catch (_) {
    return '';
  }
}

double getChangePercent(double newVal, double oldVal) {
  return ((newVal - oldVal) / oldVal) * 100;
}

double getHighestVal(List<CandleStick> series) {
  return series.reduce((v, e) => v.h > e.h ? v : e).h;
}

double getLowestVal(List<CandleStick> series) {
  return series.reduce((v, e) => v.l < e.l ? v : e).l;
}

Future<String> getVersionId() async {
  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return '$version+$buildNumber';
  } on Exception catch (_) {
    return '';
  }
}

void haltAndFire({required int milliseconds, required Function fn}) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
  fn();
}

Future<dynamic> loadJsonFile(String path) async {
  try {
    DateTime startTime = DateTime.now();
    final ByteData data = await rootBundle.load(path);
    String jsonContent = utf8.decode(data.buffer.asUint8List());
    final decoded = json.decode(jsonContent);
    DateTime endTime = DateTime.now();

    logJsonLoadSuccess(formatTime(startTime, endTime));
    return decoded;
  } catch (e) {
    p('Error loading JSON file: $e');
  }
  return null;
}

void printResponse(http.Response response) {
  final responseMap = json.decode(response.body) as Map<String, dynamic>;
  responseMap.forEach((key, v) {
    p('$key: $v');
  });
}

int randomInt(int to, int from) {
  Random random = Random();
  int randomNumber = random.nextInt(from - to + 1) + to;
  return randomNumber;
}

String regularizeSentence(String sentence) {
  // Remove extra spaces between words
  String normalizedSentence = sentence.replaceAll(RegExp(r'\s+'), ' ');

  // Remove spaces between period and end
  normalizedSentence = normalizedSentence.replaceAll(RegExp(r'\.\s+'), '.');

  // Remove any leading or trailing spaces
  return normalizedSentence.trim();
}

DateTime roundDownToNearest5Minutes(DateTime dt) {
  final minute = dt.minute;
  final roundedMinute = (minute ~/ 5) * 5;
  return DateTime(dt.year, dt.month, dt.day, dt.hour, roundedMinute);
}

DateTime roundToNearestHour(DateTime dt) {
  final minutes = dt.minute;
  final roundedMinutes = (minutes >= 30) ? 0 : 30;
  return DateTime(dt.year, dt.month, dt.day, dt.hour)
      .add(Duration(minutes: roundedMinutes));
}

String twoDigits(int n) {
  if (n >= 10) {
    return '$n';
  }
  return '0$n';
}
