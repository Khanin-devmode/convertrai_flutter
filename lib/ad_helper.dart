import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1974036075700572/8417509120';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1974036075700572/8104205430';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
