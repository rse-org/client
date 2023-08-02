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
      selectedIndex: shell.currentIndex,
      onDestinationSelected: (idx) => _goBranch(idx, context),
      destinations: [
        NavigationDestination(
          label: context.l.home,
          icon: const Icon(
            Icons.home,
          ),
        ),
        NavigationDestination(
          label: context.l.investing,
          icon: const Icon(
            Icons.candlestick_chart,
          ),
        ),
        NavigationDestination(
          label: context.l.play,
          icon: const Icon(
            Icons.play_arrow,
          ),
        ),
        NavigationDestination(
          label: context.l.notifications,
          icon: const Icon(
            Icons.notifications,
          ),
        ),
        NavigationDestination(
          label: context.l.profile,
          icon: const Icon(
            Icons.person,
          ),
        ),
      ],
    );
  }

  void _goBranch(int index, context) {
    resetStack(index);
    Future.delayed(const Duration(milliseconds: 25), () {
      setTitle(context);
    });
  }
}
