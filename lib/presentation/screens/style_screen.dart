import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rse/all.dart';

class ElevatedCardExample extends StatelessWidget {
  const ElevatedCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: SizedBox(
        width: 300,
        height: 100,
        child: Center(
          child: Text('Elevated Card'),
        ),
      ),
    );
  }
}

class FilledCardExample extends StatelessWidget {
  const FilledCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: const SizedBox(
        width: 300,
        height: 100,
        child: Center(
          child: Text('Filled Card'),
        ),
      ),
    );
  }
}

class OutlinedCardExample extends StatelessWidget {
  const OutlinedCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: const SizedBox(
        width: 300,
        height: 100,
        child: Center(
          child: Text('Outlined Card'),
        ),
      ),
    );
  }
}

class StyleScreen extends StatefulWidget {
  const StyleScreen({super.key});

  @override
  State<StyleScreen> createState() => _StyleScreenState();
}

class _StyleScreenState extends State<StyleScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
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
                  buildDark(context),
                  buildLight(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildCard() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('The Enchanted Nightingale(Light)'),
            subtitle: Text(
              'Music by Julie Gable. Lyrics by Sidney Stein.',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('LISTEN'),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }

  buildDark(context) {
    return Theme(
      data: darkTheme,
      child: Builder(
        builder: (context) {
          return Container(
            color: T(context, 'background'),
            padding: const EdgeInsets.all(8),
            child: ListView(
              children: [
                Text(
                  'Body Small',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 5),
                Text(
                  'Body Medium',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 5),
                Text(
                  'Body Large',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  'Title Small',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                Text(
                  'Title Medium',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 5),
                Text(
                  'Title Large',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                const Row(
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
                  ],
                ),
                const SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('ElevatedButton Col'),
                    ),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () {},
                      child: const Text('TextButton Col'),
                    ),
                    const SizedBox(height: 5),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('OutlinedButton Col'),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('ElevatedButton ListView'),
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () {},
                  child: const Text('TextButton ListView'),
                ),
                const SizedBox(height: 5),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('OutlinedButton ListView'),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'John',
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.pending),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                buildCard(),
                const SizedBox(height: 5),
                const ElevatedCardExample(),
                const SizedBox(height: 5),
                const FilledCardExample(),
                const SizedBox(height: 5),
                const OutlinedCardExample(),
                const SizedBox(height: 5),
              ],
            ),
          );
        },
      ),
    );
  }

  buildLight() {
    return Theme(
      data: lightTheme,
      child: Builder(
        builder: (context) {
          return Container(
            color: T(context, 'background'),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ListView(
                children: [
                  Text(
                    'Body Small',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Body Medium',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Body Large',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Title Small',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Title Medium',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Title Large',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('ElevatedButton Col'),
                      ),
                      const SizedBox(height: 5),
                      TextButton(
                        onPressed: () {},
                        child: const Text('TextButton Col'),
                      ),
                      const SizedBox(height: 5),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('OutlinedButton Col'),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('ElevatedButton ListView'),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    onPressed: () {},
                    child: const Text('TextButton ListView'),
                  ),
                  const SizedBox(height: 5),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('OutlinedButton ListView'),
                  ),
                  const Row(
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
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildCard(),
                  const ElevatedCardExample(),
                  const FilledCardExample(),
                  const OutlinedCardExample(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
