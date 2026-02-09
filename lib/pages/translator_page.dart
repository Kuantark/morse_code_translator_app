import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/morse_code_data.dart';
import '../services/morse_audio_service.dart';

class TranslatorPage extends StatefulWidget {
  final MorseAudioService audioService;

  const TranslatorPage({super.key, required this.audioService});

  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController morseController = TextEditingController();
  bool _isPlaying = false;

  void convertTextToMorse() {
    setState(() {
      morseController.text = MorseCodeData.textToMorse(textController.text);
    });
  }

  void convertMorseToText() {
    setState(() {
      textController.text = MorseCodeData.morseToText(morseController.text);
    });
  }

  Future<void> _playOrStop() async {
    if (_isPlaying) {
      await widget.audioService.stop();
      setState(() => _isPlaying = false);
      return;
    }
    if (morseController.text.isEmpty) return;
    setState(() => _isPlaying = true);
    await widget.audioService.playMorseCode(morseController.text);
    if (mounted) setState(() => _isPlaying = false);
  }

  void _copyToClipboard(String text, String label) {
    if (text.isEmpty) return;
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _applyExample(String text) {
    textController.text = text;
    convertTextToMorse();
  }

  void _showAudioSettings() {
    final settings = widget.audioService.settings;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Audio Settings',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text('Speed: ${settings.wpm.round()} WPM'),
                  Slider(
                    value: settings.wpm,
                    min: 5,
                    max: 50,
                    divisions: 45,
                    label: '${settings.wpm.round()} WPM',
                    onChanged: (value) {
                      setModalState(() => settings.wpm = value);
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
                      setModalState(() => settings.volume = value);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Text input area
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Text",
                          style: TextStyle(color: Colors.black45)),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        onPressed: () =>
                            _copyToClipboard(textController.text, 'Text'),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) => convertTextToMorse(),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'''[a-zA-Z0-9 .,?!/()&:;=+\-"'@]'''))
                      ],
                      maxLines: null,
                      expands: true,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Morse code area
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Morse Code",
                          style: TextStyle(color: Colors.black45)),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 18),
                        onPressed: () => _copyToClipboard(
                            morseController.text, 'Morse code'),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: TextField(
                      controller: morseController,
                      onChanged: (value) => convertMorseToText(),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[.\- /]'))
                      ],
                      maxLines: null,
                      expands: true,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Quick examples
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: MorseCodeData.quickExamples.map((example) {
              return ActionChip(
                label: Text(example['label']!),
                onPressed: () => _applyExample(example['text']!),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          // Play/Stop + Settings
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _playOrStop,
                child: Icon(
                  _isPlaying ? Icons.stop : Icons.play_arrow,
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: _showAudioSettings,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
