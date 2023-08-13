import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: mobile(context),
        desktop: desktop(context),
      ),
    );
  }

  Widget desktop(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors
          if (kIsWeb) WebAd(type: 'display'),
          const ProgressBar(),
          const StreakCalendar(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setScreenName('/profile');
  }

  mobile(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ProgressBar(),
          SizedBox(height: 40),
          StreakCalendar(),
        ],
      ),
    );
  }
}
