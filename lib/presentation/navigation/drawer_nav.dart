import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:rse/all.dart';
import 'package:slider_button/slider_button.dart';
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
            buildTop(),
            Expanded(
              child: ListView(
                children: [
                  buildOptions(context),
                  const SizedBox(height: 100),
                  buildBottom(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildBottom(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildThemeToggler(),
        const Divider(thickness: 0.5),
        buildSignoutSlider(context),
        buildBuildInfo(),
      ],
    );
  }

  Padding buildBuildInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 10, 30),
      child: Column(
        children: [
          if (taps > 2) buildFutureBuilder(getVersionId()),
          if (taps > 2) buildFutureBuilder(getBuildString()),
        ],
      ),
    );
  }

  buildFutureBuilder(d) {
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

  Column buildOptions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rowItem(context.l.home, Icons.home, () {
          BlocProvider.of<NavBloc>(context).add(NavChanged('0-0'));
          context.go('/');
          Navigator.pop(context);
        }),
        rowItem(context.l.investing, Icons.candlestick_chart, () {
          BlocProvider.of<NavBloc>(context).add(NavChanged('1-0'));
          context.go('/investing');
          Navigator.pop(context);
        }),
        rowItem(context.l.account, Icons.person, () {
          BlocProvider.of<NavBloc>(context).add(NavChanged('4-0'));
          context.go('/profile');
          Navigator.pop(context);
        }),
        rowItem(context.l.leaderboard, Icons.leaderboard, () {
          BlocProvider.of<NavBloc>(context).add(NavChanged('4-0'));
          context.go('/profile');
          Navigator.pop(context);
        }),
        rowItem(context.l.settings, Icons.settings, () {
          BlocProvider.of<NavBloc>(context).add(NavChanged('4-1'));
          context.go('/profile/settings');
          Navigator.pop(context);
        }),
        rowItem(context.l.send_feedback, Icons.edit, () {
          if (isWeb) {
            launchUrlString(urlFeedbackForm);
          } else {
            _dialogBuilder(context);
            // _showWebViewFullScreen();
          }
        }),
      ],
    );
  }

  Padding buildSignoutSlider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: SliderButton(
        width: 125,
        height: 50,
        shimmer: false,
        buttonSize: 50,
        highlightedColor: Colors.red,
        action: () {
          Navigator.of(context).pop();
        },
        label: Text(
          context.l.sign_out,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.red,
            fontWeight: FontWeight.w500,
          ),
        ),
        icon: const Icon(
          Icons.logout,
          color: Colors.red,
        ),
      ),
    );
  }

  Padding buildThemeToggler() {
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
                  toggleTheme(themeModel);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  buildTop() {
    return SizedBox(
      height: H(context) * .3,
      child: DrawerHeader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (taps <= 2) setState(() => taps++);
              },
              child: Text(
                'Royal Stock Exchange',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 5),
            StreamBuilder<User?>(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(snapshot.data!.photoURL!),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        getTimeAgo(),
                      ),
                    ],
                  );
                }
                return const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(urlPlaceholderAvatar),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String formatTimeAgo(Duration duration) {
    if (duration.inDays >= 365) {
      final years = (duration.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (duration.inDays >= 1) {
      return '${duration.inDays} ${duration.inDays == 1 ? 'day' : 'days'} ago';
    } else if (duration.inHours >= 1) {
      return '${duration.inHours} ${duration.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (duration.inMinutes >= 1) {
      return '${duration.inMinutes} ${duration.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  getTimeAgo() {
    final now = DateTime.now();
    final then = FirebaseAuth.instance.currentUser!.metadata.creationTime;
    final timeDifference = now.difference(then!);
    final formatted = formatTimeAgo(timeDifference);
    return formatted;
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

  rowItem(text, icon, onTap) {
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

  void toggleTheme(themeModel) {
    setState(() {
      isDark = !isDark;
    });
    themeModel.toggleTheme();
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

  Future<void> _dialogBuilder(BuildContext context) {
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
}
