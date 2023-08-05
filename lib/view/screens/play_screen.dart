import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  PlayScreenState createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: buildMobile(),
        desktop: buildDesktop(),
      ),
    );
  }

  buildDesktop() {
    return const SingleChildScrollView(
      child: PlaySetupScreen(),
    );
  }

  buildMobile() {
    return const SingleChildScrollView(
      child: PlaySetupScreen(),
    );
  }

  @override
  void initState() {
    super.initState();
    setScreenName('/play');
    logEvent({'name': 'play_load_success'});
  }
}
