import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4473907527318574/6857868725';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4473907527318574/5161643676';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4473907527318574/3876482160';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4473907527318574/6179157979';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4473907527318574/4395356917';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4473907527318574/2152336959';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
