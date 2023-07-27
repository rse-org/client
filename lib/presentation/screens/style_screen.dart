import 'package:flutter/material.dart';
import 'package:rse/all.dart';

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
      home: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Theme(
            data: lightTheme,
            child: Builder(
              builder: (context) {
                return Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Body Small (Light)',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            'Body Medium (Light)',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Body Large (Light)',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('TextButton (Light)'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('ElevatedButton (Light)'),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text('OutlinedButton (Light)'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Theme(
              data: darkTheme,
              child: Builder(
                builder: (context) {
                  return Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Body Small (Dark)',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            'Body Medium (Dark)',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            'Body Large (Dark)',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('TextButton (Dark)'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('ElevatedButton (Dark)'),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text('OutlinedButton (Dark)'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
