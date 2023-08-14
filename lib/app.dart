import 'dart:async';

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
  }
}
