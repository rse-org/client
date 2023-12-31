import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rse/all.dart';

class NewsService {
  final LocalStorageService _localStorage = LocalStorageService();

  Future<List<NewsArticle>> fetchArticles() async {
    try {
      if (kDebugMode) throw Error();
      final response = await http.get(Uri.parse(newsApi));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _localStorage.saveData('articles', response.body);
        final List<dynamic> articles = data['results'] as List<dynamic>;
        return articles.map((item) => NewsArticle.fromJson(item)).toList();
      } else {
        throw Error();
      }
    } catch (e) {
      p('Error: Fetching articles. Loading from cache.', icon: 'e');
      return await _localStorage.getCachedArticles();
    }
  }
}
