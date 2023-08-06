import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildMany(),
    );
  }

  @override
  void initState() {
    super.initState();
    if (kDebugMode && kReleaseMode) {
      _rtdb();
      _fs();
    }
  }

  _buildMany() {
    final go = <Widget>[];
    for (var i = 0; i < 40; i++) {
      go.add(const Text('Go'));
    }
    return go;
  }

  _fs() {
    FS.deleteAll();
    FS.read();
    final user = <String, dynamic>{
      'first': 'Ada',
      'last': 'Lovelace',
      'born': 1815
    };

    final user2 = <String, dynamic>{
      'first': 'Alan',
      'middle': 'Mathison',
      'last': 'Turing',
      'born': 1912
    };
    FS.write(user);
    FS.write(user2);
  }

  _read() async {
    final snapshot = await FB.dbGet('users/123');
    if (snapshot.exists) {
      p(snapshot.value, icon: '🔥');
    } else {
      p('No data available.', icon: '🔥');
    }
  }

  _rtdb() async {
    await _set();
    _read();
    await _update();
    _read();
    await _updatePath('users/123/', 'address/home/street');
    _read();
  }

  _set() async {
    final ref = FB.db('users/123');
    await ref.set(
      {
        'age': 18,
        'name': 'Loi',
        'address': {
          'home': {'street': '123 Morgana'},
        }
      },
    );
  }

  _update() async {
    final ref = FB.db('users/123');
    await ref.update({'age': 66, 'name': 'Old Loi'});
  }

  _updatePath(String db, field) async {
    final ref = FB.db(db);
    await ref.update(
        {'age': 100, 'name': 'Oldest Loi', field: '456 Cranes Landing'});
  }
}
