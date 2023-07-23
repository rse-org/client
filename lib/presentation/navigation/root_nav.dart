import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rse/all.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class App extends StatefulWidget {
  final StatefulNavigationShell shell;

  const App({super.key, required this.shell});

  @override
  State<App> createState() => _AppState();
}

// Notes:  3. Explanation of navigation
// A drawer wraps a bottom tab bar wraps nested stacks:
// - Drawer:
//   - Hamburger menu icon in app bar leading of all root bottom tab screens.
//   - Hamburger icon press opens drawer.
// - Bottom Tab:
//   - Contains stacks in each tab.
//   - Push replaces hamburger icon with back arrow icon.
//   - Back arrow icon press pops stack to previous screen.
//   - Popping from stack replaces back arrow with hamburger icon when root reached.
//   - Bottom tab icon press when already on this tab resets the stack to root screen of the stack.
//   - State should be preserved between stacks:
//      - Leaving tab and returning should maintain scroll position.
//      - Navigate to 2nd screen of home, asset.
//      - Press 2nd tab, investing.
//      - Press 1st tab, home.
//      - 1st tab 2nd screen, asset, should still be present.

// https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/

// https://github.com/flutter/flutter/issues/112196
// The messy code from this navigation comes from goRouter lack
// of API for observers working correctly within nested navigators.
// We can't easily know when a nested Stack is pushed or popped.
// So we have to manually track it in order to know when to show/hide the app bar.

// If we don't do this, the app bar will be shown when the user navigates to nested stacks.
// We have to manually hide it when the user navigates to a nested stack.

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavBloc, NavState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is QuizStartSuccess) {
          return const GameScreen();
        }
        return Scaffold(
          key: _scaffoldKey,
          body: widget.shell,
          drawer: const CustomDrawer(),
          appBar: tabRootAppBar(state.states[widget.shell.currentIndex]),
          bottomNavigationBar: BottomNavBar(
            shell: widget.shell,
            resetStack: resetStack,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    logAppLoadSuccess();
  }

  resetStack(int tabIdx) {
    final shell = widget.shell;
    if (tabIdx == shell.currentIndex) {
      BlocProvider.of<NavBloc>(context).add(NavChanged('$tabIdx-0'));
    }

    shell.goBranch(
      tabIdx,
      initialLocation: tabIdx == shell.currentIndex,
    );
  }

  PreferredSize? tabRootAppBar(int tabStackIdx) {
    return tabStackIdx == 0
        ? PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: AppBarWithSearch(
              tabIndex: widget.shell.currentIndex,
            ),
          )
        : null;
  }
}
