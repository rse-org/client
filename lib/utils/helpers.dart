import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:rse/all.dart';

String getGrade(val) {
  var outcome = '';
  if (val >= 90) {
    outcome = 'A';
  } else if (val >= 80) {
    outcome = 'B';
  } else if (val >= 70) {
    outcome = 'C';
  } else if (val >= 60) {
    outcome = 'D';
  } else {
    outcome = 'F';
  }
  return outcome;
}

String getTitle(context) {
  final location = GoRouterState.of(context).location;
  var title = 'RSE - Royal Stock Exchange';
  if (location.contains('/securities')) {
    String name = location
        .substring(location.indexOf('/securities') + '/securities/'.length);
    title = 'RSE - $name';
  } else if (location.contains('/investing')) {
    title = 'RSE - Investments';
  } else if (location.contains('/play')) {
    title = 'RSE - Play';
  } else if (location.contains('/notifications')) {
    title = 'RSE - Notifications';
  } else if (location.contains('/profile')) {
    title = 'RSE - Profile';
  }
  return title;
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

// Toggle print statements everywhere easily.
// Sometimes we do need to see print in prod.
void p(v, {icon}) {
  icon = icon ?? 'ℹ️';
  switch (icon) {
    case 'error' || 'e':
      icon = '❗️';
      break;
  }
  if (kDebugMode) {
    log('\x1B[32m$icon $v');
  }
}

void printResponse(http.Response response) {
  final responseMap = json.decode(response.body) as Map<String, dynamic>;
  responseMap.forEach((key, v) {
    p('$key: $v');
  });
}

selectPeriod(context, p) {
  final portfolioBloc = BlocProvider.of<PortfolioBloc>(context);
  final assetBloc = BlocProvider.of<AssetBloc>(context);
  final isHome = GoRouterState.of(context).location == '/';
  if (isHome) {
    portfolioBloc.setPeriod(p);
  } else {
    assetBloc.setPeriod(p);
  }
}

void setTitle(context) {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
    label: getTitle(context),
    primaryColor: Theme.of(context).primaryColor.value,
  ));
}
