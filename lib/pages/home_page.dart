import 'package:flutter/material.dart';
import '../services/morse_audio_service.dart';
import 'translator_page.dart';
import 'alphabet_page.dart';
import 'number_page.dart';
import 'punctuation_page.dart';
import 'learn_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MorseAudioService _audioService = MorseAudioService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
      body: TabBarView(
        controller: _tabController,
        children: [
          TranslatorPage(audioService: _audioService),
          AlphabetPage(audioService: _audioService),
          NumberPage(audioService: _audioService),
          PunctuationPage(audioService: _audioService),
          LearnPage(audioService: _audioService),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          labelStyle: const TextStyle(fontSize: 11),
          tabs: const [
            Tab(icon: Icon(Icons.translate), text: "Translator"),
            Tab(icon: Icon(Icons.sort_by_alpha), text: "Alphabet"),
            Tab(icon: Icon(Icons.looks_one), text: "Numbers"),
            Tab(icon: Icon(Icons.tag), text: "Punctuation"),
            Tab(icon: Icon(Icons.school), text: "Learn"),
          ],
        ),
      ),
    );
  }
}
