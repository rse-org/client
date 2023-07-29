import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rse/all.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class DesignGuideScreen extends StatefulWidget {
  const DesignGuideScreen({super.key});

  @override
  State<DesignGuideScreen> createState() => DesignGuideScreenState();
}

class DesignGuideScreenState extends State<DesignGuideScreen> {
  List selectedContacts = [];
  Calendar calendarView = Calendar.day;
  Set<Sizes> selection = <Sizes>{Sizes.large, Sizes.extraLarge};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(
                    text: 'Dark',
                  ),
                  Tab(
                    text: 'Light',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    buildThemeDark(context),
                    buildThemeLight(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildIcons() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          Icon(
            FontAwesomeIcons.instagram,
            size: 30,
          ),
          SizedBox(width: 10),
          Icon(
            FontAwesomeIcons.facebook,
            size: 30,
          ),
          SizedBox(width: 10),
          Icon(
            FontAwesomeIcons.whatsapp,
            size: 30,
          ),
          SizedBox(width: 10),
          Icon(
            FontAwesomeIcons.linkedin,
            size: 30,
          ),
          SizedBox(width: 10),
          Icon(
            FontAwesomeIcons.tiktok,
            size: 30,
          ),
          SizedBox(width: 10),
          Icon(
            FontAwesomeIcons.twitter,
            size: 30,
          ),
          SizedBox(width: 10),
          Icon(
            FontAwesomeIcons.github,
            size: 30,
          ),
          SizedBox(width: 10),
          Icon(
            FontAwesomeIcons.stackOverflow,
            size: 30,
          ),
          SizedBox(width: 10),
          Icon(
            FontAwesomeIcons.microsoft,
            size: 30,
          ),
          SizedBox(width: 10),
          Icon(
            FontAwesomeIcons.google,
            size: 30,
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  buildTexts(context) {
    return Container(
      color: C(context, 'background'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Body Small',
            style: T(context, 'bodySmall'),
          ),
          const SizedBox(height: 5),
          Text(
            'Body Medium',
            style: T(context, 'bodyMedium'),
          ),
          const SizedBox(height: 5),
          Text(
            'Body Large',
            style: T(context, 'bodyLarge'),
          ),
          const SizedBox(height: 5),
          Text(
            'Label Small',
            style: T(context, 'labelSmall'),
          ),
          const SizedBox(height: 5),
          Text(
            'Label Medium',
            style: T(context, 'labelMedium'),
          ),
          const SizedBox(height: 5),
          Text(
            'Label Large',
            style: T(context, 'labelLarge'),
          ),
          const SizedBox(height: 5),
          Text(
            'Title Small',
            style: T(context, 'headlineSmall'),
          ),
          const SizedBox(height: 5),
          Text(
            'Title Medium',
            style: T(context, 'headlineMedium'),
          ),
          const SizedBox(height: 5),
          Text(
            'Title Large',
            style: T(context, 'headlineLarge'),
          ),
          const SizedBox(height: 5),
          Text(
            'Headline Small',
            style: T(context, 'displaySmall'),
          ),
          const SizedBox(height: 5),
          Text(
            'Headline Medium',
            style: T(context, 'displayMedium'),
          ),
          const SizedBox(height: 5),
          Text(
            'Headline Large',
            style: T(context, 'displayLarge'),
          ),
          const SizedBox(height: 50),
          Text(
            'Primary',
            style: styleWithColor(
              type: T(context, 'titleLarge'),
              color: C(context, 'primary'),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Secondary',
            style: styleWithColor(
              type: T(context, 'titleLarge'),
              color: C(context, 'secondary'),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Tertiary',
            style: styleWithColor(
              type: T(context, 'titleLarge'),
              color: C(context, 'tertiary'),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Error',
            style: styleWithColor(
              type: T(context, 'titleLarge'),
              color: C(context, 'error'),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'onError',
            style: styleWithColor(
              type: T(context, 'titleLarge'),
              color: C(context, 'onError'),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Outline',
            style: styleWithColor(
              type: T(context, 'titleLarge'),
              color: C(context, 'outline'),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Shadow',
            style: styleWithColor(
              type: T(context, 'titleLarge'),
              color: C(context, 'shadow'),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Inverse Surface',
            style: styleWithColor(
              type: T(context, 'titleLarge'),
              color: C(context, 'inverseSurface'),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'on Inverse Surface',
            style: styleWithColor(
              type: T(context, 'titleLarge'),
              color: C(context, 'onInverseSurface'),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'inversePrimary',
            style: styleWithColor(
              type: T(context, 'titleLarge'),
              color: C(context, 'inversePrimary'),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  buildThemeDark(context) {
    return Theme(
      data: darkTheme,
      child: Builder(
        builder: (context) {
          return Container(
            color: C(context, 'background'),
            padding: const EdgeInsets.all(8),
            child: ListView(
              children: [
                const CustomForm(),
                buildTexts(context),
                buildIcons(),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'ElevatedButton ListView',
                  ),
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'TextButton ListView',
                  ),
                ),
                const SizedBox(height: 5),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'OutlinedButton ListView',
                  ),
                ),
                const SizedBox(height: 50),
                const CustomButtons(),
                const Cards(),
                const CustomTable(),
              ],
            ),
          );
        },
      ),
    );
  }

  buildThemeLight(context) {
    return Theme(
      data: lightTheme,
      child: Builder(
        builder: (context) {
          return Container(
            color: C(context, 'background'),
            padding: const EdgeInsets.all(8),
            child: ListView(
              children: [
                const CustomForm(),
                buildTexts(context),
                buildIcons(),
                const CustomButtons(),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'ElevatedButton ListView',
                  ),
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'TextButton ListView',
                  ),
                ),
                const SizedBox(height: 5),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    'OutlinedButton ListView',
                  ),
                ),
                const SizedBox(height: 5),
                const Cards(),
                const SizedBox(height: 5),
                const CustomTable(),
              ],
            ),
          );
        },
      ),
    );
  }
}
