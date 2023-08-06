import 'dart:math';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:rse/all.dart';

String calculatePercentageChange(double newVal, double oldVal) {
  double gainLoss = getChangePercent(newVal, oldVal);
  String formatted = formatPercentage(gainLoss);
  return formatted;
}

String cleanse(String sentence) {
  // Remove extra spaces between words
  String normalizedSentence = sentence.replaceAll(RegExp(r'\s+'), ' ');

  // Split the sentence into individual sentences based on periods
  List<String> sentences = normalizedSentence.split('.');

  // Remove any leading or trailing spaces for each sentence
  for (int i = 0; i < sentences.length; i++) {
    sentences[i] = sentences[i].trim();
  }

  // Join the sentences back together
  normalizedSentence = sentences.join('. ');

  // Remove any trailing space after the last sentence
  normalizedSentence = normalizedSentence.replaceAll(RegExp(r'\.\s+$'), '.');

  return normalizedSentence;
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

int randomInt(int to, int from) {
  Random random = Random();
  int randomNumber = random.nextInt(from - to + 1) + to;
  return randomNumber;
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
