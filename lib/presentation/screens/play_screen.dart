import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  PlayScreenState createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> {
  @override
  void initState() {
    super.initState();
    setScreenName('/play');
    logPlayLoadSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: buildMobile(),
        desktop: buildDesktop(),
      ),
    );
  }

  buildMobile() {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProgressBar(),
          SetupStepper(),
        ],
      ),
    );
  }

  buildDesktop() {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProgressBar(),
          SetupStepper(),
        ],
      ),
    );
  }
}
