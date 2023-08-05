import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rse/all.dart';

// Fix: Screen name isn't accurate on GA
// ? Doesn't fix screen_view events for FB analytics.
// ? May fix GA page path & screen class.
// ? https://analytics.google.com/analytics/web/#/p388273837/reports/explorer?params=_u..nav%3Dmaui&r=all-pages-and-screens&ruid=all-pages-and-screens,life-cycle,engagement&collectionId=life-cycle

// ? https://stackoverflow.com/questions/55830575/how-do-i-track-flutter-screens-in-firebase-analytics
late FirebaseAnalyticsObserver fbAnalyticsObserver;
final remoteConfig = FirebaseRemoteConfig.instance;

StreamSubscription? subscription;

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
      'package_name': packageName,
      'device': '$version $buildNumber',
      'env': kReleaseMode ? 'release' : 'debug',
    },
  );
}

void logEvent(Map<String, dynamic> params) async {
  Map<String, dynamic> parameters = {};

  params.forEach((key, value) {
    if (key != 'name') {
      parameters[key] = value;
    }
  });

  await FirebaseAnalytics.instance.logEvent(
    name: params['name'],
    parameters: parameters.isNotEmpty ? parameters : null,
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

void setScreenName(String name) async {
  FirebaseAnalytics.instance.setCurrentScreen(screenName: name);
}

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

    // ? Crashlytics has no web support.
    // ? https://github.com/firebase/flutterfire/issues/4631#issuecomment-758701699
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
    p('Error: Firebase $e');
  }
}
