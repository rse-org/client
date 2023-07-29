import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class Cards extends StatelessWidget {
  const Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        OutlinedCard(),
        SizedBox(height: 5),
        FilledCard(),
        SizedBox(height: 5),
        ElevatedCard(),
        SizedBox(height: 5),
        ContentFilledCard(),
        SizedBox(height: 50),
      ],
    );
  }
}

class ContentFilledCard extends StatelessWidget {
  const ContentFilledCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}

class ElevatedCard extends StatelessWidget {
  const ElevatedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'Elevated Card',
          ),
        ),
      ),
    );
  }
}

class FilledCard extends StatelessWidget {
  const FilledCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: C(context, 'surfaceVariant'),
      child: const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'Filled Card',
          ),
        ),
      ),
    );
  }
}

class OutlinedCard extends StatelessWidget {
  const OutlinedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: C(context, 'outline'),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'Outlined Card',
          ),
        ),
      ),
    );
  }
}
