import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  Account formData = Account();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: const ArrowBackButton(screenCode: '4-0', root: '/profile'),
      ),
      body: ResponsiveLayout(
        mobile: _buildContent(),
        desktop: _buildContent(),
      ),
    );
  }

  _buildContent() {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: const SingleChildScrollView(
        child: Column(
          children: [
            AccountForm(),
            SizedBox(height: 20),
            BankForm(),
            AccountList(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
