import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rse/all.dart';

class BottomNavBar extends StatelessWidget {
  final StatefulNavigationShell shell;
  final Function resetStack;

  const BottomNavBar(
      {super.key, required this.shell, required this.resetStack});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (idx) => _goBranch(idx, context),
      selectedIndex: shell.currentIndex,
      indicatorColor: Theme.of(context).indicatorColor,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      destinations: [
        NavigationDestination(
          label: context.l.home,
          icon: Icon(
            Icons.home,
            color: getIconColor(context, 0),
          ),
        ),
        NavigationDestination(
          label: context.l.investing,
          icon: Icon(
            Icons.candlestick_chart,
            color: getIconColor(context, 1),
          ),
        ),
        NavigationDestination(
          label: context.l.play,
          icon: Icon(
            Icons.play_arrow,
            color: getIconColor(context, 2),
          ),
        ),
        NavigationDestination(
          label: context.l.notifications,
          icon: Icon(
            Icons.notifications,
            color: getIconColor(context, 3),
          ),
        ),
        NavigationDestination(
          label: context.l.profile,
          icon: Icon(
            Icons.person,
            color: getIconColor(context, 4),
          ),
        ),
      ],
    );
  }

  getIconColor(context, idx) {
    return shell.currentIndex == idx
        ? T(context, 'primaryContainer')
        : T(context, 'inversePrimary');
  }

  void _goBranch(int index, context) {
    resetStack(index);
    Future.delayed(const Duration(milliseconds: 25), () {
      setTitle(context);
    });
  }
}
