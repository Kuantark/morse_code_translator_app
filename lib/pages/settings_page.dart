import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/ad_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AdService _adService = AdService();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
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
