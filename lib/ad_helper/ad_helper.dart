import 'dart:io';

class AdHelper {

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4779220143200061/4769493170'; 
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4779220143200061/6284882680'; 
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4779220143200061/7203799413'; 
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4779220143200061/5851474709'; 
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get appOpenAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4779220143200061/6602283740'; 
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4779220143200061/2527307361'; 
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}