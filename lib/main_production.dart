import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'all.dart';
import 'firebase/firebase_options_prod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  p('Production', icon: '🏃 ');
  // Log bloc events
  // bootstrap(() => const _Providers());
  // Or don't
  bootstrap(() => const Providers());
}

void mainProduction() {
  main();
}
