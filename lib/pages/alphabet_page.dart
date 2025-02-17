import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AlphabetPage extends StatelessWidget {
  final Map<String, Map<String, String>> morseAlphabet = {
    'A': {'morse': '.-', 'sound': 'di-dah'},
    'B': {'morse': '-...', 'sound': 'dah-di-di-dit'},
    'C': {'morse': '-.-.', 'sound': 'dah-di-dah-dit'},
    'D': {'morse': '-..', 'sound': 'dah-di-dit'},
    'E': {'morse': '.', 'sound': 'dit'},
    'F': {'morse': '..-.', 'sound': 'di-di-dah-dit'},
    'G': {'morse': '--.', 'sound': 'dah-dah-dit'},
    'H': {'morse': '....', 'sound': 'di-di-di-dit'},
    'I': {'morse': '..', 'sound': 'di-dit'},
    'J': {'morse': '.---', 'sound': 'di-dah-dah-dah'},
    'K': {'morse': '-.-', 'sound': 'dah-di-dah'},
    'L': {'morse': '.-..', 'sound': 'di-dah-di-dit'},
    'M': {'morse': '--', 'sound': 'dah-dah'},
    'N': {'morse': '-.', 'sound': 'dah-dit'},
    'O': {'morse': '---', 'sound': 'dah-dah-dah'},
    'P': {'morse': '.--.', 'sound': 'di-dah-dah-dit'},
    'Q': {'morse': '--.-', 'sound': 'dah-dah-di-dah'},
    'R': {'morse': '.-.', 'sound': 'di-dah-dit'},
    'S': {'morse': '...', 'sound': 'di-di-dit'},
    'T': {'morse': '-', 'sound': 'dah'},
    'U': {'morse': '..-', 'sound': 'di-di-dah'},
    'V': {'morse': '...-', 'sound': 'di-di-di-dah'},
    'W': {'morse': '.--', 'sound': 'di-dah-dah'},
    'X': {'morse': '-..-', 'sound': 'dah-di-di-dah'},
    'Y': {'morse': '-.--', 'sound': 'dah-di-dah-dah'},
    'Z': {'morse': '--..', 'sound': 'dah-dah-di-dit'},
  };

  final AudioPlayer _audioPlayer = AudioPlayer();

  void playMorse(String character) async {
    // TODO: Replace with actual sound assets
    await _audioPlayer
        .play(AssetSource('audios/${character.toLowerCase()}.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Table(
          border: TableBorder.all(),
          columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[300]),
              children: [
                tableHeader("Character"),
                tableHeader("Code"),
                tableHeader("Sound"),
              ],
            ),
            ...morseAlphabet.entries.map(
              (entry) => TableRow(
                children: [
                  tableCell(entry.key),
                  tableCell(entry.value['morse']!),
                  tableCell(entry.value['sound']!, color: Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget tableCell(String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(color: color ?? Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}
