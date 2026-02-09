import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ad_service.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool _hasError = false;
  AdSize? _adSize;
  bool _isInitializing = false;

  final AdService _adService = AdService();

  Future<void> _initializeAdSize(int containerWidth) async {
    if (_isInitializing || _adSize != null) return;
    _isInitializing = true;

    if (!mounted) return;

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      containerWidth,
    );

    if (!mounted) return;

    if (size == null) {
      setState(() => _hasError = true);
      return;
    }

    setState(() => _adSize = size);
    _loadBannerAd(size);
  }

  void _loadBannerAd(AdSize size) {
    _bannerAd = BannerAd(
      adUnitId: _adService.getBannerAdUnitId(),
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) async {
          if (!mounted) return;
          final BannerAd bannerAd = ad as BannerAd;
          final AdSize? platformSize = await bannerAd.getPlatformAdSize();

          if (!mounted) return;

          if (platformSize != null &&
              (platformSize.height != _adSize?.height ||
                  platformSize.width != _adSize?.width)) {
            setState(() => _adSize = platformSize);
          }

          setState(() => _isLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (!mounted) return;
          setState(() => _hasError = true);
          debugPrint('❌ BannerAd failed to load: $error');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 不支援廣告的平台
    if (!_adService.isAdSupportedPlatform) {
      if (_adService.isTestMode) {
        return Container(
          width: double.infinity,
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.2),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.5)),
          ),
          child: Center(
            child: Text(
              '🧪 Banner Ad Placeholder (unsupported platform)',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final containerWidth = constraints.maxWidth.truncate();

        if (_adSize == null && !_isInitializing && !_hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _initializeAdSize(containerWidth);
          });
          return const SizedBox.shrink();
        }

        if (_adSize == null) return const SizedBox.shrink();

        final double containerHeight = _adSize!.height.toDouble();
        final double adWidth = _adSize!.width.toDouble();

        if (_isLoaded && _bannerAd != null) {
          return SizedBox(
            width: adWidth,
            height: containerHeight,
            child: AdWidget(ad: _bannerAd!),
          );
        }

        // Loading / error placeholder
        return SizedBox(
          width: adWidth,
          height: containerHeight,
          child: Container(
            color: Colors.grey.withValues(alpha: 0.1),
            child: Center(
              child: _hasError
                  ? Text('Ad failed to load',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.grey[400]!),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('Loading ad...',
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 12)),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
