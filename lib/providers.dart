import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:rse/all.dart';

class Providers extends StatelessWidget {
  const Providers({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: Bloc entry.
    return ChangeNotifierProvider(
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
    );
  }
}
