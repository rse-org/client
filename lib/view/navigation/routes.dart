import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rse/all.dart';

// Note: Route/Page definitions
final goRouter = GoRouter(
  initialLocation: '/',
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload
  // debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  observers: [],
  redirect: (context, state) {
    String location = state.location;
    if (location == '/') {
      final bloc = context.read<PortfolioBloc>();
      bloc.fetchPortfolio(1);
      final meta = bloc.portfolio.meta;
      if (meta != null ? meta.totalValue != 0 : false) {
        context.read<ChartBloc>().updateChartPortfolioValues(bloc.portfolio);
      }
    }
    if (location.startsWith('/securities/')) {
      final bloc = context.read<AssetBloc>();
      final sym = location.substring(12);
      bloc.fetchAsset(sym);
    }
    return state.location;
  },
  routes: [
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) {
        return App(shell: shell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            buildRoute(
              '/',
              const HomeScreen(),
              [
                GoRoute(
                  path: 'securities/:sym',
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: AssetScreen(sym: state.pathParameters['sym']!),
                  ),
                ),
              ],
            ),
            buildRoute('/design', const DesignGuideScreen()),
            buildRoute('/test', const TestScreen())
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            buildRoute(
              '/investing',
              const InvestingScreen(title: 'Investing'),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            buildRoute(
              '/play',
              const PlayScreen(),
              [
                buildRoute('results', const ResultScreen()),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDKey,
          routes: [buildRoute('/notifications', const NotificationsScreen())],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEKey,
          routes: [
            buildRoute(
              '/profile',
              const ProfileScreen(),
              [
                buildRoute('settings', const ProfileSettingsScreen()),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');
final _shellNavigatorEKey = GlobalKey<NavigatorState>(debugLabel: 'shellE');

buildRoute(path, Widget widget, [List<RouteBase>? routes]) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => NoTransitionPage(
      key: state.pageKey,
      child: widget,
    ),
    routes: (routes ?? <RouteBase>[]),
  );
}
