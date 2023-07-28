import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:rse/presentation/widgets/play/examples/everything_view.dart';

import 'all.dart';
import 'firebase_options.dart';

// Note: Flutter style guide.
// https://shorturl.at/rIUZ1

// Note: Todos VScode extension.
// Fix: Not ideal fix.
// Todo: Work to do later.
// https://rb.gy/wpj5j

// Note: Comments VSCode extension.
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

  // Fix: Hacky package solution. https://shorturl.at/DYZ02
  _loadShader();

  // Note: Bloc entry.
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

Future<void> _loadShader() async {
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
