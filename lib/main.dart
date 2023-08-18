import 'all.dart';
import 'main_production.dart';

void main() {
  if (const String.fromEnvironment('FLUTTER_WEB_ENTRY') ==
      'lib/main_production.dart') {
    mainProduction();
  } else {
    bootstrap(() => const Providers());
  }
}
