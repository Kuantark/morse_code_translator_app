import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class NumberPage extends StatelessWidget {
  final Map<String, Map<String, String>> morseNumbers = {
    '0': {'morse': '-----', 'sound': 'dah-dah-dah-dah-dah'},
    '1': {'morse': '.----', 'sound': 'di-dah-dah-dah-dah'},
    '2': {'morse': '..---', 'sound': 'di-di-dah-dah-dah'},
    '3': {'morse': '...--', 'sound': 'di-di-di-dah-dah'},
    '4': {'morse': '....-', 'sound': 'di-di-di-di-dah'},
    '5': {'morse': '.....', 'sound': 'di-di-di-di-dit'},
    '6': {'morse': '-....', 'sound': 'dah-di-di-di-dit'},
    '7': {'morse': '--...', 'sound': 'dah-dah-di-di-dit'},
    '8': {'morse': '---..', 'sound': 'dah-dah-dah-di-dit'},
    '9': {'morse': '----.', 'sound': 'dah-dah-dah-dah-dit'},
  };

  final AudioPlayer _audioPlayer = AudioPlayer();

  void playMorse(String number) async {
    await _audioPlayer.play(AssetSource('audios/${number}.mp3'));
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
                tableHeader("Number"),
                tableHeader("Morse Code"),
                tableHeader("Sound (Di/Dah)"),
              ],
            ),
            ...morseNumbers.entries.map(
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
