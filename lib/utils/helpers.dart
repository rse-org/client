import 'dart:developer' as devtools show log;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

String getTitle(context) {
  final location = GoRouterState.of(context).location;
  var title = 'Royal Stock Exchange(RSE)';
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

// Toggle print statements everywhere more easily.
// Sometimes we do need to see print statements in prod.
void p(v, {error = false}) {
  if (kDebugMode) {
    print('${error ? '❗️' : 'ℹ️'} $v');
  }
}

void setTitle(context) {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
    label: getTitle(context),
    primaryColor: Theme.of(context).primaryColor.value,
  ));
}

extension Log on Object {
  void log([String tag = '']) {
    devtools.log(toString(), name: tag);
  }
}
