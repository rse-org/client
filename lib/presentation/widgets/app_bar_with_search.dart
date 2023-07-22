import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:rse/all.dart';

class AppBarWithSearch extends StatefulWidget {
  final int tabIndex;

  const AppBarWithSearch({super.key, required this.tabIndex});

  @override
  State<AppBarWithSearch> createState() => _AppBarWithSearchState();
}

class _AppBarWithSearchState extends State<AppBarWithSearch> {
  bool _isSearching = false;
  late FocusNode myFocusNode;
  String searchQuery = 'Search query';
  final TextEditingController _searchQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    navigate() {
      BlocProvider.of<NavBloc>(context).add(NavChanged('4-1'));
      context.go('/profile/settings');
    }

    return AppBar(
      leading: _buildLeading(),
      title: _buildTitle(context),
      actions: _buildActions(context, navigate),
    );
  }

  _buildLeading() {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }

  _buildTitle(BuildContext context) {
    return _isSearching
        ? _buildSearchField(context)
        : _buildTitleHelper(context);
  }

  Widget _buildSearchField(BuildContext c) {
    return TextField(
      autofocus: true,
      focusNode: myFocusNode,
      controller: _searchQueryController,
      style: const TextStyle(fontSize: 16.0),
      onChanged: (q) => _updateSearchQuery(q),
      decoration: InputDecoration(
        hintText: c.l.search_assets,
        border: InputBorder.none,
      ),
    );
  }

  _buildTitleHelper(context) {
    String title = 'Royal Stock Exchange';
    switch (widget.tabIndex) {
      case 1:
        title = 'Investing';
      case 2:
        title = 'Play';
      case 3:
        title = 'Notifications';
      case 4:
        title = 'Profile';
      default:
    }
    return Consumer<ThemeModel>(
      builder: (context, themeModel, _) {
        return GestureDetector(
          onDoubleTap: themeModel.toggleTheme,
          onLongPressStart: (details) {
            _handleLongPress(details, context);
          },
          child: Text(title),
        );
      },
    );
  }

  List<Widget> _buildActions(context, navigate) {
    if (widget.tabIndex == 2) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.switch_left),
          onPressed: () {
            // BlocProvider.of<NavBloc>(context).add(NavChanged('3-1'));
            // navigate();
          },
        ),
      ];
    }

    if (widget.tabIndex == 4) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            BlocProvider.of<NavBloc>(context).add(NavChanged('4-1'));
            navigate();
          },
        ),
      ];
    }

    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          myFocusNode.requestFocus();
          _startSearch();
        },
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      _updateSearchQuery('');
    });
  }
}

Widget renderAuthOptions(context) {
  return BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {},
    builder: (context, state) {
      if (FirebaseAuth.instance.currentUser != null) {
        return TextButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
          },
          child: const Text('Sign Out'),
        );
      }
      return Column(
        children: [
          SignInButton(
            Buttons.Google,
            text: 'Sign up with Google',
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(
                GoogleSignInRequested(),
              );
            },
          ),
          SignInButton(
            Buttons.Google,
            text: 'Sign up with Google',
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(
                GoogleSignInRequested(),
              );
            },
          ),
        ],
      );
    },
  );
}

Future<String> getBuildString() async {
  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    return packageName;
  } on Exception catch (_) {
    return '';
  }
}

Future<String> getVersionId() async {
  try {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return '$version: $buildNumber';
  } on Exception catch (_) {
    return '';
  }
}

void _showModal(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  bool showAppConfig = remoteConfig.getValue('app_show_config').asBool();
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          Text('Screen Width: ${width.toStringAsFixed(2)}'),
          Text('Screen Height: ${height.toStringAsFixed(2)}'),
          TextButton(
            onPressed: () {
              BlocProvider.of<LangBloc>(context).changeLang('es');
            },
            child: const Text('es'),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<LangBloc>(context).changeLang('en');
            },
            child: const Text('en'),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<LangBloc>(context).changeLang('vi');
            },
            child: const Text('vi'),
          ),
          TextButton(
            onPressed: () {
              final bool value = debugPaintSizeEnabled;
              debugPaintSizeEnabled = !value;
            },
            child: const Text('Enable Debug Paint Size'),
          ),
          TextButton(
            onPressed: () {
              // getSheetData();
            },
            child: const Text('Get Sheet Data'),
          ),
          renderAuthOptions(context),
          if (showAppConfig)
            FutureBuilder<String>(
              future: getVersionId(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(snapshot.data ?? '');
                }
              },
            ),
          FutureBuilder<String>(
            future: getVersionId(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(
                    'app_secret: ${remoteConfig.getValue('app_secret').asString()}');
              }
            },
          ),
          if (showAppConfig)
            FutureBuilder<String>(
              future: getBuildString(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(snapshot.data ?? '');
                }
              },
            ),
        ],
      );
    },
  );
}

void _handleLongPress(LongPressStartDetails details, context) {
  _showModal(context);
}
