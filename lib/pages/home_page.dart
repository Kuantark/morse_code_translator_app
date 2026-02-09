import 'package:flutter/material.dart';
import '../services/morse_audio_service.dart';
import '../services/ad_service.dart';
import '../widgets/banner_ad_widget.dart';
import 'translator_page.dart';
import 'chart_page.dart';
import 'learn_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MorseAudioService _audioService = MorseAudioService();
  final AdService _adService = AdService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      // Rebuild to update banner visibility and sync settings UI when switching tabs
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
    _audioService.init();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('assets/icons/logo.png', height: 40),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                TranslatorPage(audioService: _audioService),
                ChartPage(audioService: _audioService),
                LearnPage(audioService: _audioService),
                SettingsPage(audioService: _audioService),
              ],
            ),
          ),
          // Banner ad - hide on Settings tab and when ads disabled
          if (_tabController.index != 3 && _adService.adsEnabled)
            const BannerAdWidget(),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: const [
            Tab(icon: Icon(Icons.translate), text: "Translator"),
            Tab(icon: Icon(Icons.table_chart), text: "Chart"),
            Tab(icon: Icon(Icons.school), text: "Learn"),
            Tab(icon: Icon(Icons.settings), text: "Settings"),
          ],
        ),
      ),
    );
  }
}
