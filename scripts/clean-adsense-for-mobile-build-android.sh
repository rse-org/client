#!/bin/bash

echo "Current directory: $(pwd)"
ls

sed -i"" -e "/if (kIsWeb) WebAd/d" ./lib/presentation/screens/home_screen.dart
sed -i"" -e "/if (kIsWeb) WebAd/d" ./lib/presentation/screens/investing_screen.dart
sed -i"" -e "/if (kIsWeb) WebAd/d" ./lib/presentation/screens/profile_screen.dart
sed -i"" -e "/if (kIsWeb) WebAd/d" ./lib/presentation/screens/play_screen.dart
sed -i"" -e "/web_ad.dart/d" ./lib/presentation/widgets/ads/all.dart

dart fix --apply
