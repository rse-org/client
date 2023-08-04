import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rse/all.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

final _tabKeys = [
  botNavKey1,
  botNavKey2,
  botNavKey3,
  botNavKey4,
  botNavKey5,
];

final _tabTitles = [
  'Check your investing growth, stocks, and news',
  'See how your long term growth is going',
  'Play games to learn about the world of finance',
  'Keep up to date on assets you\'re watching here',
  'Track your streak, manage your account, and more.',
];

class BottomNavBar extends StatefulWidget {
  final Function resetStack;
  final StatefulNavigationShell shell;

  const BottomNavBar({
    super.key,
    required this.shell,
    required this.resetStack,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late TutorialCoachMark tutorialCoachMark;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            children: [
              _buildFocusBox(botNavKey1),
              _buildFocusBox(botNavKey2),
              _buildFocusBox(botNavKey3),
              _buildFocusBox(botNavKey4),
              _buildFocusBox(botNavKey5),
            ],
          ),
        ),
        NavigationBar(
          selectedIndex: widget.shell.currentIndex,
          onDestinationSelected: (idx) => _goBranch(idx, context),
          destinations: [
            _buildNav(context.l.home, Icons.home),
            _buildNav(context.l.investing, Icons.candlestick_chart),
            _buildNav(context.l.play, Icons.play_arrow),
            _buildNav(context.l.notifications, Icons.notifications),
            _buildNav(context.l.profile, Icons.person),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    _createTutorial();
    Future.delayed(Duration.zero, _showTutorial);
    super.initState();
  }

  Expanded _buildFocusBox([key]) {
    return Expanded(
      child: Center(
        child: SizedBox(
          key: key,
          height: 40,
          width: 40,
        ),
      ),
    );
  }

  NavigationDestination _buildNav(text, IconData icon) {
    return NavigationDestination(
      label: text,
      icon: Icon(
        icon,
      ),
    );
  }

  _buildTarget(keyTarget, title) {
    return TargetFocus(
      keyTarget: keyTarget,
      alignSkip: Alignment.topRight,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildText(
                  context,
                  'headlineSmall',
                  title,
                )
              ],
            );
          },
        ),
      ],
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    for (var i = 0; i < 4; i++) {
      targets.add(
        _buildTarget(
          _tabKeys[i],
          _tabTitles[i],
        ),
      );
    }
    return targets;
  }

  void _createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.black,
      textSkip: 'SKIP',
      paddingFocus: 10,
      opacityShadow: 0.6,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        print('finish');
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print('target: $target');
        print(
            'clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}');
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print('skip');
      },
    );
  }

  void _goBranch(int index, context) {
    widget.resetStack(index);
    Future.delayed(const Duration(milliseconds: 25), () {
      setTitle(context);
    });
  }

  void _showTutorial() {
    tutorialCoachMark.show(context: context);
  }
}
