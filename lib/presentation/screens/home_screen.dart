import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class HomeScreen extends StatefulWidget {
  final String label;

  const HomeScreen({required this.label, Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // return const StyleScreen();
    return Scaffold(
      body: ResponsiveLayout(
        mobile: buildMobile(context),
        desktop: buildDesktop(context),
      ),
    );
  }

  Widget buildDesktop(context) {
    return Row(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  LineChart(),
                  TickerCarousel(),
                  Articles(),
                ],
              ),
            ),
          ),
        ),
        const Watchlist(),
      ],
    );
  }

  Widget buildMobile(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const LineChart(),
          mobileWatchList(context),
          const Articles(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // ! Fails during tests env so only invoke in release env.
    if (kReleaseMode) setScreenName('/home');

    haltAndFire(milliseconds: 250, fn: () => setTitle(context));
  }

  Widget mobileWatchList(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: watched.length,
        itemBuilder: (BuildContext context, int index) {
          final item = watched[index];
          return WatchItem(item);
        },
      ),
    );
  }
}
