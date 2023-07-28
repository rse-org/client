import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:rse/all.dart';

Widget renderAuthOptions(context) {
  return BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) {},
    builder: (context, state) {
      if (FirebaseAuth.instance.currentUser != null) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.red,
          ),
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
        ],
      );
    },
  );
}

void _handleLongPress(LongPressStartDetails details, context) {
  _showModal(context);
}

void _showModal(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Text('Screen Width: ${width.toStringAsFixed(2)}'),
              Text('Screen Height: ${height.toStringAsFixed(2)}'),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<LangBloc>(context).changeLang('es');
                },
                child: const Text('es'),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<LangBloc>(context).changeLang('en');
                },
                child: const Text('en'),
              ),
              ElevatedButton(
                onPressed: () {
                  BlocProvider.of<LangBloc>(context).changeLang('vi');
                },
                child: const Text('vi'),
              ),
              ElevatedButton(
                onPressed: () {
                  final bool value = debugPaintSizeEnabled;
                  debugPaintSizeEnabled = !value;
                },
                child: const Text('Enable Debug Paint Size'),
              ),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go('/style');
                },
                child: const Text('Style Screen'),
              ),
              renderAuthOptions(context),
            ],
          ),
        ),
      );
    },
  );
}

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
  Widget build(BuildContext context) {
    navigate() {
      BlocProvider.of<NavBloc>(context).add(NavChanged('4-1'));
      context.go('/profile/settings');
    }

    String name;
    switch (widget.tabIndex) {
      case 1:
        name = context.l.investing;
      case 2:
        name = context.l.play;
      case 3:
        name = context.l.notifications;
      case 4:
        name = context.l.profile;
      default:
        name = 'Royal Stock Exchange';
    }

    return AppBar(
      leading: _buildLeading(),
      title: _buildTitle(context, name),
      actions: _buildActions(context, navigate),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
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

  _buildLeading() {
    return IconButton(
      icon: const Icon(Icons.menu),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
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

  _buildTitle(BuildContext context, String name) {
    return _isSearching
        ? _buildSearchField(context)
        : _buildTitleHelper(context, name);
  }

  _buildTitleHelper(context, String name) {
    return Consumer<ThemeModel>(
      builder: (context, themeModel, _) {
        return GestureDetector(
          onDoubleTap: themeModel.toggleTheme,
          onLongPressStart: (details) {
            _handleLongPress(details, context);
          },
          child: Text(name),
        );
      },
    );
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      _updateSearchQuery('');
    });
  }

  void _startSearch() {
    ModalRoute.of(context)
        ?.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _updateSearchQuery(String q) {
    setState(() {
      searchQuery = q;
    });
  }
}
