import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:rse/all.dart';
import 'package:url_launcher/url_launcher_string.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => DrawerState();
}

class DrawerState extends State<CustomDrawer> {
  int taps = 0;
  // late WebViewController controller;
  late bool isDark = isDarkMode(context);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        height: H(context),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [_buildTop(), _buildOptions(context), _buildBottom()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Fix: Fixes startup warning about future webview
    // deprecation but introduces drawer error on web.

    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {},
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith('https://www.youtube.com/')) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse(urlFeedbackForm));
  }

  Column _buildBottom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildThemeToggler(),
        const Divider(thickness: 0.5),
        _buildSignoutSlider(),
        _buildBuildInfo(),
      ],
    );
  }

  Padding _buildBuildInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 10, 30),
      child: Column(
        children: [
          if (taps > 2 || kDebugMode) _buildFutureBuilder(getVersionId()),
          if (taps > 2 || kDebugMode) _buildFutureBuilder(getBuildString()),
        ],
      ),
    );
  }

  // void _showWebViewFullScreen() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return WillPopScope(
  //         onWillPop: () async {
  //           Navigator.pop(context);
  //           return true;
  //         },
  //         child: Scaffold(
  //           appBar: AppBar(),
  //           body: WebViewWidget(controller: controller),
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> _buildDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => WebviewScaffold(
        url: urlFeedbackForm,
        appBar: AppBar(
          title: const Text('RSE'),
        ),
      ),
    );
  }

  _buildDrawerItem(text, icon, onTap) {
    return ListTile(
      title: Row(children: [
        Icon(
          icon,
          size: 24.0,
          color: C(context, 'primary'),
        ),
        const SizedBox(width: 10),
        Text(text, style: TextStyle(color: C(context, 'primary')))
      ]),
      onTap: onTap,
    );
  }

  _buildFutureBuilder(d) {
    return FutureBuilder<String>(
      future: d,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(height: 17);
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text(snapshot.data ?? '')],
          );
        }
      },
    );
  }

  Column _buildOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDrawerItem(context.l.home, Icons.home, () {
          BlocProvider.of<NavBloc>(context).add(NavChanged('0-0'));
          context.go('/');
          Navigator.pop(context);
        }),
        _buildDrawerItem(context.l.investing, Icons.candlestick_chart, () {
          BlocProvider.of<NavBloc>(context).add(NavChanged('1-0'));
          context.go('/investing');
          Navigator.pop(context);
        }),
        _buildDrawerItem(context.l.profile, Icons.person, () {
          BlocProvider.of<NavBloc>(context).add(NavChanged('4-0'));
          context.go('/profile');
          Navigator.pop(context);
        }),
        _buildDrawerItem(context.l.leaderboard, Icons.leaderboard, () {
          BlocProvider.of<NavBloc>(context).add(NavChanged('4-0'));
          context.go('/profile');
          Navigator.pop(context);
        }),
        _buildDrawerItem(context.l.settings, Icons.settings, () {
          BlocProvider.of<NavBloc>(context).add(NavChanged('4-1'));
          context.go('/profile/settings');
          Navigator.pop(context);
        }),
        _buildDrawerItem(context.l.send_feedback, Icons.edit, () {
          if (isWeb) {
            launchUrlString(urlFeedbackForm);
          } else {
            _buildDialog(context);
            // _showWebViewFullScreen();
          }
        }),
      ],
    );
  }

  _buildSignoutSlider() {
    return const AuthScreen();
  }

  Padding _buildThemeToggler() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Row(
        children: [
          Consumer<ThemeModel>(
            builder: (context, themeModel, _) {
              return Toggler(
                type: 'theme',
                value: isDark,
                onChanged: (newValue) {
                  _toggleTheme(themeModel);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  _buildTop() {
    return SizedBox(
      height: H(context) * .4,
      child: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (taps <= 2) {
                        setState(() => taps++);
                        if (taps >= 2) {
                          BlocProvider.of<PlayBloc>(context).add(SetDev());
                        }
                      }
                    },
                    child: buildText(
                        context, 'headlineSmall', 'Royal Stock Exchange'),
                  ),
                  const SizedBox(height: 5),
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(snapshot.data!.photoURL!),
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.instagram,
                            size: 25,
                          ),
                          SizedBox(height: 10),
                          Text('Streak')
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.instagram,
                            size: 25,
                          ),
                          SizedBox(height: 10),
                          Text('Total')
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.instagram,
                            size: 25,
                          ),
                          SizedBox(height: 10),
                          Text('Average')
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    getTimeAgo(),
                  ),
                ],
              ),
            );
          }
          return DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(context, 'headlineSmall', 'Royal Stock Exchange'),
                const SizedBox(height: 5),
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(urlPlaceholderAvatar),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _toggleTheme(themeModel) {
    setState(() {
      isDark = !isDark;
    });
    themeModel.toggleTheme();
  }
}
