// Fix: Adsense cleaning script & auto remove unused imports will make foundation go missing
// ignore: unused_import
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
  List<Watch> watched = [];
  @override
  Widget build(BuildContext context) {
    // Note: Design guide.
    // return const DesignGuideScreen();
    return Scaffold(
      body: ResponsiveLayout(
        mobile: buildMobile(context),
        desktop: buildDesktop(context),
      ),
    );
  }

  SingleChildScrollView buildContent(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildLineChart(),
          _mobileWatchList(context),
          const Articles(),
        ],
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
            child: SingleChildScrollView(
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  if (kIsWeb) WebAd(type: 'display'),
                  const LineChart(),
                  const TickerCarousel(),
                  const Articles(),
                ],
              ),
            ),
          ),
        ),
        Watchlist(watched: watched),
      ],
    );
  }

  Widget buildMobile(context) {
    return buildContent(context);
  }

  fetchWatched() async {
    final List<Watch> data = await getWatched();
    setState(() {
      watched = data;
    });
  }

  @override
  void initState() {
    super.initState();
    // ! Fails during tests env so only invoke in release env.
    if (kReleaseMode) setScreenName('/home');

    haltAndFire(milliseconds: 250, fn: () => setTitle(context));
    fetchWatched();
  }

  _buildLineChart() {
    if (kIsWeb) return const LineChart();
    return const AdBanner(
      child: Padding(
        padding: EdgeInsets.only(
          top: 80,
        ),
        child: LineChart(),
      ),
    );
  }

  Widget _mobileWatchList(BuildContext context) {
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
