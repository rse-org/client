import 'dart:math';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:rse/all.dart';

String calculatePercentageChange(double newVal, double oldVal) {
  double gainLoss = getChangePercent(newVal, oldVal);
  String formatted = formatPercentage(gainLoss);
  return formatted;
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

String regularizeSentence(String sentence) {
  // Remove extra spaces between words
  String normalizedSentence = sentence.replaceAll(RegExp(r'\s+'), ' ');

  // Remove spaces between period and end
  normalizedSentence = normalizedSentence.replaceAll(RegExp(r'\.\s+'), '.');

  // Remove any leading or trailing spaces
  return normalizedSentence.trim();
}
