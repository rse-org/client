import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import './firebase_options.dart';
import 'all.dart';

// Notes: 1. Review Todo Tree

// https://marketplace.visualstudio.com/items?itemName=Gruntfuggly.todo-tree
// Fix: Less than ideal fix but working.
// Todo: Work to do later

// Learn to use better comments as well.
// https://marketplace.visualstudio.com/items?itemName=aaron-bond.better-comments
// ! Very important
// ? Not sure of something
// * Decorators !, ?, *

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Notes: 2. Bloc entrypoint
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LangBloc>(
            create: (_) => LangBloc(),
          ),
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(authService: AuthService()),
          ),
          BlocProvider<NavBloc>(
            create: (_) => NavBloc(),
          ),
          BlocProvider<PortfolioBloc>(
            create: (_) => PortfolioBloc(
              portfolio: Portfolio.defaultPortfolio(),
            ),
          ),
          BlocProvider<NewsBloc>(
            create: (_) => NewsBloc(),
          ),
          BlocProvider<PlayBloc>(
            create: (_) => PlayBloc(),
          ),
          BlocProvider<AssetBloc>(
            create: (_) => AssetBloc(
              asset: Asset.defaultAsset(),
              assetService: AssetService(),
            ),
          ),
          BlocProvider<ChartBloc>(
            create: (context) {
              final assetBloc = BlocProvider.of<AssetBloc>(context);
              final portfolioBloc = BlocProvider.of<PortfolioBloc>(context);
              return ChartBloc(
                assetBloc: assetBloc,
                chart: Chart.defaultChart(),
                portfolioBloc: portfolioBloc,
              );
            },
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
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
        // Once complete, show your application
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
