import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'all.dart';

// Info: Flutter style guide.
// https://shorturl.at/rIUZ1

// Info: Todos VScode extension. https://rb.gy/wpj5j
// Fix: Temp workaround.
// Todo: Nice to have.
// Note: Project specific.
// Info: Useful for any project.

// Info: Comments VSCode extension.
// https://shorturl.at/ehADH
// ? Why?
// ! Important!
// * Decorators !, ?, *

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Log bloc events
  // bootstrap(() => const _Providers());
  // Or don't
  runApp(const Providers());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late NewsBloc _newsBloc;
  late AssetBloc _assetBloc;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setup(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SizedBox();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return BlocBuilder<LangBloc, LangState>(
            builder: (context, state) {
              return MaterialApp.router(
                theme: lightTheme,
                darkTheme: darkTheme,
                routerConfig: goRouter,
                locale: Locale(state.locale),
                debugShowCheckedModeBanner: false,
                supportedLocales: supportedLocales,
                localizationsDelegates: localizationsDelegates,
                localeResolutionCallback: localeResolutionCallback,
                themeMode: Provider.of<ThemeModel>(context).isDarkMode
                    ? ThemeMode.dark
                    : ThemeMode.light,
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Future<void> fetchData() async {
    _newsBloc.fetchArticles();
    _assetBloc.fetchAsset('BAC');
  }

  @override
  void initState() {
    super.initState();
    _newsBloc = context.read<NewsBloc>();
    _assetBloc = context.read<AssetBloc>();
    fetchData();
    // _fb();
  }

  _fb() async {
    await _set();
    _read();
    await _update();
    _read();
    await _updatePath('users/123/', 'address/home/street');
    _read();
  }

  _read() async {
    final snapshot = await FB.dbGet('users/123');
    if (snapshot.exists) {
      p(snapshot.value, icon: '🔥');
    } else {
      p('No data available.', icon: '🔥');
    }
  }

  _set() async {
    final ref = FB.db('users/123');

    await ref.set(
      {
        'age': 18,
        'name': 'Loi',
        'address': {
          'home': {'street': '123 Morgana'},
        }
      },
    );
  }

  _update() async {
    final ref = FB.db('users/123');
    await ref.update({'age': 66, 'name': 'Old Loi'});
  }

  _updatePath(String db, field) async {
    final ref = FB.db(db);
    await ref.update(
        {'age': 100, 'name': 'Oldest Loi', field: '456 Cranes Landing'});
  }
}
