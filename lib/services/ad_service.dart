import 'dart:io';
import 'package:flutter/foundation.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  // 廣告開關（僅 debug 模式下可控制）
  bool _adsEnabled = true;
  bool get adsEnabled => _adsEnabled;

  void setAdsEnabled(bool enabled) {
    _adsEnabled = enabled;
    debugPrint('🎛️ Ads ${enabled ? 'enabled' : 'disabled'}');
  }

  bool get isTestMode => kDebugMode;

  bool get isAdSupportedPlatform {
    try {
      return Platform.isAndroid || Platform.isIOS;
    } catch (_) {
      return false;
    }
  }

  // 廣告 ID 配置
  static const Map<String, Map<String, String>> _adIds = {
    'banner': {
      'android_prod': 'ca-app-pub-6943502895784792/8853656454',
      'ios_prod': 'ca-app-pub-6943502895784792/2731101230',
      'test': 'ca-app-pub-3940256099942544/6300978111',
    },
  };

  String getBannerAdUnitId() {
    if (isTestMode) {
      debugPrint('🧪 Using TEST Banner Ad ID');
      return _adIds['banner']!['test']!;
    }

    if (Platform.isAndroid) {
      return _adIds['banner']!['android_prod']!;
    } else if (Platform.isIOS) {
      return _adIds['banner']!['ios_prod']!;
    }

    throw UnsupportedError('Unsupported platform');
  }
}
