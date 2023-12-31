import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var api = 'http://localhost:7254';
var newsApi = 'https://newsdata.io/api/1/news?category=business&language=en';

void setupAPI() {
  // ? Platform isn't available on web.
  if (!kIsWeb) {
    // ? Android connection issues with localhost. "Connection refused..."
    // ?  https://stackoverflow.com/questions/4905315/error-connection-refused
    // ? Could be a few other things as well though:
    // ?  https://rb.gy/u5kdq
    api = Platform.isAndroid ? 'http://10.0.2.2:7254' : 'http://localhost:7254';
  }

  final apiKey = dotenv.env['API_KEY'];
  newsApi += '&apikey=$apiKey';
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
