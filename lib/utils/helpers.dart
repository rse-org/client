import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rse/all.dart';

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
