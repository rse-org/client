import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rse/all.dart';

StreamSubscription? subscription;
final remoteConfig = FirebaseRemoteConfig.instance;

// ? Doesn't fix screen_view events for FB analytics.
// ? May fix GA page path & screen class.
// ? https://analytics.google.com/analytics/web/#/p388273837/reports/explorer?params=_u..nav%3Dmaui&r=all-pages-and-screens&ruid=all-pages-and-screens,life-cycle,engagement&collectionId=life-cycle

// ? https://stackoverflow.com/questions/55830575/how-do-i-track-flutter-screens-in-firebase-analytics
late FirebaseAnalyticsObserver fbAnalyticsObserver;

setupFirebase() async {
  try {
    fbAnalyticsObserver =
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

    await remoteConfig.fetchAndActivate();

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: kDebugMode ? 5 : 720),
      ),
    );

    // ! Crashlytics isn't supported on web.
    // ! https://github.com/firebase/flutterfire/issues/4631
    if (!kIsWeb) {
      if (subscription != null) {
        await subscription!.cancel();
        subscription = null;
      }

      subscription = remoteConfig.onConfigUpdated.listen((event) async {
        await remoteConfig.activate();
      });

      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      p('Firebase initialized');
    }
  } catch (e) {
    debugPrint('Error: Firebase $e');
  }
}

void setScreenName(String name) async {
  FirebaseAnalytics.instance.setCurrentScreen(screenName: name);
}

// * Use this naming convention
// * https://bloclibrary.dev/#/blocnamingconventions

void logAppLoadSuccess() async {
  String platform = kIsWeb ? 'web' : Platform.operatingSystem;
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  String packageName = packageInfo.packageName;
  await FirebaseAnalytics.instance.logEvent(
    name: 'app_load_success',
    parameters: {
      'platform': platform,
      'device': '$version $buildNumber',
      'package_name': packageName,
      'env': kReleaseMode ? 'release' : 'debug',
    },
  );
}

void logPeriodSelect(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: 'chart_period_select',
    parameters: {
      'name': name,
    },
  );
}

void logAssetView(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: 'asset_view',
    parameters: {
      'name': name,
    },
  );
}

void logAssetTradeSelect(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: 'asset_trade_select',
    parameters: {
      'name': name,
    },
  );
}

void logAssetTradeOptionSelect(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: 'asset_trade_option_selected',
    parameters: {
      'name': name,
    },
  );
}

void logJsonLoadSuccess(String duration) async {
  String platform = kIsWeb ? 'web' : Platform.operatingSystem;

  await FirebaseAnalytics.instance.logEvent(
    name: 'json_load_success',
    parameters: {
      'platform': platform,
      'duration': duration,
      'env': kReleaseMode ? 'release' : 'debug',
    },
  );
}

void logPlayLoadSuccess() async {
  await FirebaseAnalytics.instance.logEvent(
    name: 'play_load_success',
  );
}

void logPlayDifficultySelect(d) async {
  await FirebaseAnalytics.instance
      .logEvent(name: 'play_difficulty_select', parameters: {'difficulty': d});
}

void logPlayCategorySelect(c) async {
  await FirebaseAnalytics.instance
      .logEvent(name: 'play_category_select', parameters: {'category': c});
}

void logPlayStart() async {
  var now = DateTime.now();
  DateFormat().format(now);
  await FirebaseAnalytics.instance.logEvent(
    name: 'play_game_start',
    parameters: {
      'start_time': DateFormat().format(now),
    },
  );
}

void logPlayEnd(start) async {
  var end = DateTime.now();
  Duration difference = end.difference(start);
  String diff = formatTimeDifference(difference);
  await FirebaseAnalytics.instance.logEvent(
    name: 'play_game_end',
    parameters: {
      'start_time': DateFormat().format(start),
      'end_time': DateFormat().format(end),
      'time': diff
    },
  );
}

void logPlayAnswerSelect() async {
  await FirebaseAnalytics.instance.logEvent(name: 'play_answer_select');
}

String formatTimeDifference(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
}
