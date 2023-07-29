import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:rse/all.dart';
import 'package:slider_button/slider_button.dart';
import 'package:url_launcher/url_launcher_string.dart';
// import 'package:webview_flutter/webview_flutter.dart';

const feedbackFormUrl =
    'https://docs.google.com/forms/d/e/1FAIpQLSc-Yxeq0n2galt6CaO0Uw8F_vYaQSEOQTY5LfowQpFrIDoY1w/viewform';

const placeHolderAvatar = 'https://shorturl.at/yGISX';

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
                  const SizedBox(height: 200),
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
        Padding(
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
        ),
        const Divider(thickness: 0.5),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 40,
          ),
          child: Center(
            child: SliderButton(
              width: 125,
              height: 30,
              shimmer: false,
              buttonSize: 30,
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 10, 30),
          child: Column(
            children: [
              if (taps > 2) buildFutureBuilder(getVersionId()),
              if (taps > 2) buildFutureBuilder(getBuildString()),
              if (taps <= 2) const SizedBox(height: 34)
            ],
          ),
        ),
      ],
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
      children: [
        ListTile(
          title: Text(context.l.home),
          onTap: () {},
        ),
        ListTile(
          title: Text(context.l.investing),
          onTap: () {},
        ),
        ListTile(
          title: Text(context.l.account),
          onTap: () {},
        ),
        ListTile(
          title: Text(context.l.settings),
          onTap: () {},
        ),
        ListTile(
          title: Text(context.l.send_feedback),
          onTap: () {
            if (isWeb) {
              launchUrlString(feedbackFormUrl);
            } else {
              _dialogBuilder(context);
              // _showWebViewFullScreen();
            }
          },
        ),
      ],
    );
  }

  DrawerHeader buildTop() {
    return DrawerHeader(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black),
        ),
      ),
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
          const Spacer(),
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(snapshot.data!.photoURL!),
                );
              }
              return const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(placeHolderAvatar),
              );
            },
          ),
        ],
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
    //   ..loadRequest(Uri.parse(feedbackFormUrl));
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
        url: feedbackFormUrl,
        appBar: AppBar(
          title: const Text('RSE'),
        ),
      ),
    );
  }
}
