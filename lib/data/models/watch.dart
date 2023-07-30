import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rse/all.dart';

filterInvalid(d) {
  List cleansed = d['values']
      .where((t) =>
          t[0] != '' &&
          t[3] != '' &&
          t[3] != '#N/A' &&
          double.tryParse(t[4]) != null &&
          double.tryParse(t[5]) != null)
      .toList();
  sortDes(cleansed);
  return cleansed;
}

Future<List<Watch>> getWatched() async {
  List<Watch> keep = [];
  try {
    final response = await http.get(Uri.parse(urlTickers));
    if (response.statusCode == 200) {
      final d = json.decode(response.body);
      List filtered = filterInvalid(d);

      for (final t in filtered) {
        keep.add(
          Watch(
            sym: t[1],
            shares: 0,
            price: double.parse(t[4]),
            change: double.parse(t[5]),
            changePercent: double.parse(t[5]),
          ),
        );
      }
      keep = keep.take(25).toList();
    }
  } catch (e) {
    p('Error: $e', icon: '😡');
  }
  return keep;
}

sortDes(d) {
  return d.sort((a, b) {
    double marketCapA = double.parse(a[3].replaceAll(RegExp(r'[\$,]'), ''));
    double marketCapB = double.parse(b[3].replaceAll(RegExp(r'[\$,]'), ''));
    return marketCapB.compareTo(marketCapA);
  });
}

class Watch {
  final String sym;
  final int shares;
  final double price;
  final double change;
  final double changePercent;
  final List<String> lists = [];

  Watch({
    required this.sym,
    required this.shares,
    required this.price,
    required this.change,
    required this.changePercent,
  });
}
