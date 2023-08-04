import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  allNotifications(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return _buildNotificationItem();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setScreenName('/notifications');
    return Scaffold(
      body: ResponsiveLayout(
        mobile: buildMobile(context),
        desktop: buildDesktop(context),
      ),
    );
  }

  buildDesktop(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            allNotifications(context),
            securityNotifications(context),
          ],
        ),
      ),
    );
  }

  buildMobile(context) {
    return Column(
      children: [
        allNotifications(context),
      ],
    );
  }

  securityNotifications(context) {
    return Expanded(
      flex: 5,
      child: Column(
        children: [
          const Align(
            child: Text(
              'Name',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
              ),
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Message $index'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildNotificationItem() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text('RSE'),
      ),
      title: const Text('Welcome!'),
      isThreeLine: true,
      subtitle: const Text(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          'Thank you for joining. Watch investment assets and you\'ll receive notifications about them here.'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(
          width: 1,
        ),
      ),
    );
  }
}
