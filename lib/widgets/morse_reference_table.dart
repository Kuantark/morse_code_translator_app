import 'package:flutter/material.dart';

class MorseReferenceTable extends StatelessWidget {
  final Map<String, String> data;
  final String characterLabel;
  final String Function(String morseCode) getSoundDescription;
  final void Function(String character)? onPlayPressed;

  const MorseReferenceTable({
    super.key,
    required this.data,
    required this.characterLabel,
    required this.getSoundDescription,
    this.onPlayPressed,
  });

  @override
  Widget build(BuildContext context) {
    final hasPlay = onPlayPressed != null;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Table(
          border: TableBorder.all(),
          columnWidths: {
            0: const FlexColumnWidth(2),
            1: const FlexColumnWidth(3),
            2: const FlexColumnWidth(3),
            if (hasPlay) 3: const FlexColumnWidth(1.5),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[300]),
              children: [
                _tableHeader(characterLabel),
                _tableHeader("Code"),
                _tableHeader("Sound"),
                if (hasPlay) _tableHeader("Play"),
              ],
            ),
            ...data.entries.map(
              (entry) => TableRow(
                children: [
                  _tableCell(entry.key),
                  _tableCell(entry.value),
                  _tableCell(
                    getSoundDescription(entry.value),
                    color: Colors.green,
                  ),
                  if (hasPlay)
                    TableCellVerticalAlignment.middle == TableCellVerticalAlignment.middle
                        ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: IconButton(
                              icon: const Icon(Icons.play_arrow, size: 20),
                              onPressed: () => onPlayPressed!(entry.key),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          )
                        : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _tableCell(String text, {Color? color}) {
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
