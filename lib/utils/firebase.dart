import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'firebase_options.dart';
import 'package:rse/all.dart';

void setupFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Crashlytics isn't supported on web.
    // https://github.com/firebase/flutterfire/issues/4631
    if (!kIsWeb) {
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

void logPeriodSelect(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: "selected_period",
    parameters: {
      "name": name,
    },
  );
}

void logAssetView(String name) async {
  await FirebaseAnalytics.instance.logEvent(
    name: "viewed_asset",
    parameters: {
      "name": name,
    },
  );
}
