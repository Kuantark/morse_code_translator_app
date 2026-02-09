import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/ad_service.dart';
import '../services/morse_audio_service.dart';

class SettingsPage extends StatefulWidget {
  final MorseAudioService audioService;

  const SettingsPage({super.key, required this.audioService});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AdService _adService = AdService();

  @override
  Widget build(BuildContext context) {
    final settings = widget.audioService.settings;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Audio settings
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.volume_up, color: Colors.blue[700]),
                  const SizedBox(width: 8),
                  Text(
                    'Audio',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                ],
              ),
              const Divider(),
              Text('Speed: ${settings.wpm.round()} WPM'),
              Slider(
                value: settings.wpm,
                min: 5,
                max: 50,
                divisions: 45,
                label: '${settings.wpm.round()} WPM',
                onChanged: (value) {
                  setState(() => settings.wpm = value);
                  settings.save();
                },
              ),
              const SizedBox(height: 8),
              Text('Volume: ${(settings.volume * 100).round()}%'),
              Slider(
                value: settings.volume,
                min: 0.0,
                max: 1.0,
                divisions: 20,
                label: '${(settings.volume * 100).round()}%',
                onChanged: (value) {
                  setState(() => settings.volume = value);
                  settings.save();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Developer section - debug mode only
        if (kDebugMode) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.developer_mode, color: Colors.orange[700]),
                    const SizedBox(width: 8),
                    Text(
                      'Developer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[700],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('Show Ads'),
                  subtitle: Text(
                    _adService.adsEnabled
                        ? 'Ads are visible'
                        : 'Ads are hidden',
                  ),
                  value: _adService.adsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _adService.setAdsEnabled(value);
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
