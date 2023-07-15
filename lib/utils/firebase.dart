import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rse/all.dart';

import 'firebase_options.dart';

StreamSubscription? subscription;
final remoteConfig = FirebaseRemoteConfig.instance;

// Doesn't fix screen_view events for FB analytics.
// May fix GA page path & screen class.
// https://analytics.google.com/analytics/web/#/p388273837/reports/explorer?params=_u..nav%3Dmaui&r=all-pages-and-screens&ruid=all-pages-and-screens,life-cycle,engagement&collectionId=life-cycle

// https://stackoverflow.com/questions/55830575/how-do-i-track-flutter-screens-in-firebase-analytics
late FirebaseAnalyticsObserver fbAnalyticsObserver;

setupFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    fbAnalyticsObserver =
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);

    await remoteConfig.fetchAndActivate();

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: kDebugMode ? 5 : 720),
      ),
    );

    // Crashlytics isn't supported on web.
    // https://github.com/firebase/flutterfire/issues/4631
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

void logPeriodSelect(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: "chart_select_period",
    parameters: {
      "name": name,
    },
  );
}

void logAssetView(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: "asset_viewed",
    parameters: {
      "name": name,
    },
  );
}

void logTradeAsset(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: "asset_choose_trade",
    parameters: {
      "name": name,
    },
  );
}

void logTradeAssetOption(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: "asset_choose_trade_option",
    parameters: {
      "name": name,
    },
  );
}

void logJsonLoadTime(String duration) async {
  String platform = kIsWeb ? "web" : Platform.operatingSystem;

  await FirebaseAnalytics.instance.logEvent(
    name: "json_file_save_load_time",
    parameters: {
      "platform": platform,
      "duration": duration,
      "env": kReleaseMode ? "release" : "debug",
    },
  );
}

void logAppLoadSuccess() async {
  String platform = kIsWeb ? "web" : Platform.operatingSystem;
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  await FirebaseAnalytics.instance.logEvent(
    name: "app_load_success",
    parameters: {
      "platform": platform,
      "device": '$version $buildNumber',
      "env": kReleaseMode ? "release" : "debug",
    },
  );
}
