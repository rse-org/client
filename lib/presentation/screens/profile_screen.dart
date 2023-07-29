import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  ProfileForm formData = ProfileForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobile: mobile(context),
        desktop: mobile(context),
      ),
    );
  }

  Widget desktop(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          StreakCalendar(),
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
          StreakCalendar(),
        ],
      ),
    );
  }
}
