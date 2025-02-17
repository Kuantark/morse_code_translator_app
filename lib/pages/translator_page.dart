import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class TranslatorPage extends StatefulWidget {
  @override
  _TranslatorPageState createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  TextEditingController textController = TextEditingController();
  TextEditingController morseController = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  final Map<String, String> morseCodeMap = {
    'A': '.-',
    'B': '-...',
    'C': '-.-.',
    'D': '-..',
    'E': '.',
    'F': '..-.',
    'G': '--.',
    'H': '....',
    'I': '..',
    'J': '.---',
    'K': '-.-',
    'L': '.-..',
    'M': '--',
    'N': '-.',
    'O': '---',
    'P': '.--.',
    'Q': '--.-',
    'R': '.-.',
    'S': '...',
    'T': '-',
    'U': '..-',
    'V': '...-',
    'W': '.--',
    'X': '-..-',
    'Y': '-.--',
    'Z': '--..',
    '1': '.----',
    '2': '..---',
    '3': '...--',
    '4': '....-',
    '5': '.....',
    '6': '-....',
    '7': '--...',
    '8': '---..',
    '9': '----.',
    '0': '-----',
    ' ': '/'
  };

  String textToMorse(String text) {
    return text
        .toUpperCase()
        .split('')
        .map((char) => morseCodeMap[char] ?? '')
        .join(' ');
  }

  String morseToText(String morse) {
    Map<String, String> reversedMap =
        morseCodeMap.map((key, value) => MapEntry(value, key));
    return morse.split(' ').map((code) => reversedMap[code] ?? '').join('');
  }

  void convertTextToMorse() {
    setState(() {
      morseController.text = textToMorse(textController.text);
    });
  }

  void convertMorseToText() {
    setState(() {
      textController.text = morseToText(morseController.text);
    });
  }

  Future<void> playMorseCode() async {
    const int unit = 200; // 調整間隔使播放更密集

    for (String word in morseController.text.split('/')) {
      for (String letter in word.split(' ')) {
        for (String symbol in letter.split('')) {
          if (symbol == '.') {
            await _audioPlayer.play(AssetSource('audios/short_beep.mp3'));
            await Future.delayed(Duration(milliseconds: unit));
          } else if (symbol == '-') {
            await _audioPlayer.play(AssetSource('audios/long_beep.mp3'));
            await Future.delayed(Duration(milliseconds: unit * 3));
          }
          await Future.delayed(Duration(milliseconds: unit)); // 符號間隔
        }
        await Future.delayed(Duration(milliseconds: unit * 2)); // 字母間隔 (更密集)
      }
      await Future.delayed(Duration(milliseconds: unit * 4)); // 單詞間隔 (更密集)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 5),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Text", style: TextStyle(color: Colors.black45)),
                  SizedBox(height: 8),
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) => convertTextToMorse(),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
                      ],
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 5),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Morse Code", style: TextStyle(color: Colors.black45)),
                  SizedBox(height: 8),
                  Expanded(
                    child: TextField(
                      controller: morseController,
                      onChanged: (value) => convertMorseToText(),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[.\- ]'))
                      ],
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: playMorseCode,
            child: Icon(Icons.play_arrow, size: 30),
          ),
        ],
      ),
    );
  }
}
