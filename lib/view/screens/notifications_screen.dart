import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rse/all.dart';

var notItems = [
  {
    'name': 'RSE',
    'full_name': 'Royal Stock Exchange',
    'title': 'Welcome!',
    'body':
        'Thank you for joining. Watch investment assets and you\'ll receive notifications about them here.',
    'messages': [
      {
        'user': false,
        'body':
            'Thank you for joining. Watch investment assets and you\'ll receive notifications about them here.',
      }
    ]
  },
  {
    'name': 'CS',
    'full_name': 'Customer support',
    'title': 'Customer service',
    'body': 'Questions can be asked here about how to use our service.',
    'messages': [
      {
        'user': false,
        'body': 'Questions can be asked here about how to use our service.',
      },
      {
        'user': true,
        'body': 'Questions can be asked here about how to use our service.',
      },
    ]
  }
];

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int selectedIdx = 0;
  bool selected = false;
  FocusNode focus1 = FocusNode();

  List notificationItems = notItems;
  final myController = TextEditingController();
  allNotifications(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notificationItems.length,
              itemBuilder: (context, idx) {
                return _buildNotificationItem(notificationItems[idx], idx);
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
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          allNotifications(context),
          notificationBody(context),
        ],
      ),
    );
  }

  buildMobile(context) {
    if (selected) return notificationBody(context);
    return Column(
      children: [
        allNotifications(context),
      ],
    );
  }

  notificationBody(context) {
    final messages = (notificationItems[selectedIdx]['messages'] as List);
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
            ),
            child: Column(
              children: [
                if (!kIsWeb)
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.5, color: Colors.black),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              setState(() {
                                selected = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                Align(
                  child: buildText(
                    context,
                    'headlineLarge',
                    notificationItems[selectedIdx]['full_name'],
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, idx) {
                      return ListTile(
                        title: Text(
                          textAlign:
                              messages[idx]['user'] ? TextAlign.end : null,
                          '${messages[idx]['body']}',
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextFormField(
                    autofocus: true,
                    focusNode: focus1,
                    controller: myController,
                    onFieldSubmitted: (String value) {
                      _addToList(value);
                      myController.clear();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _addToList(String body) {
    final messages = (notificationItems[selectedIdx]['messages'] as List);
    messages.add({
      'user': true,
      'body': body,
    });
    notificationItems[selectedIdx]['messages'] = messages;
    setState(() {
      notificationItems = notificationItems;
    });
    focus1.requestFocus();
  }

  ListTile _buildNotificationItem(item, idx) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(item['name']),
      ),
      title: Text(item['title']),
      isThreeLine: true,
      subtitle: Text(
        item['body'],
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        setState(() {
          selectedIdx = idx;
          selected = true;
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(
          width: 1,
        ),
      ),
    );
  }
}
