import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rse/all.dart';
import 'package:rse/presentation/widgets/play/examples/everything_view.dart';

setup() async {
  if (kDebugMode) p('Setup...');
  setupEnvironments();
  await setupFirebase();
}

void setupEnvironments() async {
  if (kIsWeb && kReleaseMode) return;
  try {
    await dotenv.load(fileName: 'assets/.env');
    p('Env loaded? ${dotenv.env['ENV_LOADED']}');
    setupAPI();
  } catch (e) {
    p('Error: dotenv $e');
  }
}

Future<void> loadShader() async {
  return FragmentProgram.fromAsset('assets/shader.frag').then(
    (FragmentProgram prgm) {
      EverythingView.shader = prgm.fragmentShader();
    },
    onError: (Object error, StackTrace stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(exception: error, stack: stackTrace),
      );
    },
  );
}
