import 'dart:convert';

import 'package:rse/all.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<List<NewsArticle>> getCachedArticles() async {
    var data = await loadData('articles');

    if (data != null && data.isNotEmpty) {
      return _mapArticlesFromData(jsonDecode(data)['results']);
    } else {
      final d = await loadJsonFile('assets/news.json');
      if (d != null && d.isNotEmpty) {
        return _mapArticlesFromData(d['results']);
      }
    }
    p('Error: Error loading cached articles');
    return [];
  }

  Future<Asset> getCachedAsset(String symbol, period) async {
    symbol = symbol.toLowerCase();
    var data = await loadData('$symbol-$period');
    if (data != null && data.isNotEmpty) {
      return Asset.fromJson(jsonDecode(data));
    } else {
      final d = await loadJsonFile('assets/$symbol-$period.json');
      if (d != null && d.isNotEmpty) {
        return Asset.fromJson(d as Map<String, dynamic>);
      }
    }
    return Asset.defaultAsset();
  }

  Future<Portfolio> getCachedPortfolio(period) async {
    var data = await loadData('portfolio-$period');
    if (data != null && data.isNotEmpty) {
      return Portfolio.fromJson(jsonDecode(data), period: period);
    } else {
      final path = 'assets/portfolio-$period.json';
      final d = await loadJsonFile(path);
      if (d != null && d.isNotEmpty) {
        return Portfolio.fromJson(d, period: period);
      }
    }
    return Portfolio.defaultPortfolio();
  }

  Future<String?> loadData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveData(String key, String value,
      {bool overwrite = true}) async {
    final prefs = await SharedPreferences.getInstance();
    if (overwrite || !prefs.containsKey(key)) {
      await prefs.setString(key, value);
    }
  }

  List<NewsArticle> _mapArticlesFromData(dynamic data) {
    return (data as List<dynamic>)
        .map((item) => NewsArticle.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Map<String, dynamic>>> bankAccountRemove(
      String number) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> serializedAccounts = prefs.getStringList('accounts') ?? [];
    List<Map<String, dynamic>> accounts = serializedAccounts.map((a) {
      return json.decode(a) as Map<String, dynamic>;
    }).toList();

    accounts.removeWhere((a) => a['accountNumber'] == number);

    List<String> updatedSerializedAccounts =
        accounts.map((a) => json.encode(a)).toList();
    await prefs.setStringList('accounts', updatedSerializedAccounts);

    return accounts;
  }

  static bankAccountsList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> serializedAccounts = prefs.getStringList('accounts') ?? [];
    List<Map<String, dynamic>> accounts = serializedAccounts.map((a) {
      return json.decode(a) as Map<String, dynamic>;
    }).toList();
    return accounts;
  }

  static bankAccountsSave(name, routingNum, accountNum) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> accounts = prefs.getStringList('accounts') ?? [];
    final info = json.encode({
      'name': name,
      'routingNumber': routingNum,
      'accountNumber': accountNum
    });
    accounts.add(info);
    await prefs.setStringList('accounts', accounts);
  }

  static playCompletedCount() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString('completed') ?? '0';
    var count = int.parse(result);
    return count;
  }

  static playIncrementCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getString('completed') ?? '0';
    var count = int.parse(result);
    count += 1;
    await prefs.setString('completed', count.toString());
    return count;
  }

  static playSaveResult(r) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> results = prefs.getStringList('results') ?? [];
    results.add(r.toJson().toString());
    await prefs.setStringList('results', results);
  }

  static playUpdateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> streak = prefs.getStringList('streak dates') ?? [];
    final now = DateTime.now();
    // final yesterday = now.subtract(const Duration(days: 1));
    // final dayBefore = now.subtract(const Duration(days: 2));
    // final lastWeek = now.subtract(const Duration(days: 7));
    streak.addAll([
      now.toString(),
      // yesterday.toString(),
      // dayBefore.toString(),
      // lastWeek.toString()
    ]);
    await prefs.setStringList('streak dates', streak);
  }

  static tutorialCheckDone(name) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> names = prefs.getStringList('tutorial') ?? [];

    if (names.contains(name)) {
      return true;
    }
    return false;
  }

  static tutorialMarkDone(name) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> names = prefs.getStringList('tutorial') ?? [];
    names.add(name);
    await prefs.setStringList('tutorial', names);
  }
}
