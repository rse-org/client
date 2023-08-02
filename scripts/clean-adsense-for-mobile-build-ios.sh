#!/bin/bash
echo "Current directory: $(pwd)"

sed -i '' '/if (kIsWeb) WebAd/d' ./lib/presentation/screens/home_screen.dart
sed -i '' '/if (kIsWeb) WebAd/d' ./lib/presentation/screens/investing_screen.dart
sed -i '' '/if (kIsWeb) WebAd/d' ./lib/presentation/screens/profile_screen.dart
sed -i '' '/if (kIsWeb) WebAd/d' ./lib/presentation/screens/play_screen.dart
sed -i '' '/web_ad.dart/d' ./lib/presentation/widgets/ads/all.dart
dart fix --apply