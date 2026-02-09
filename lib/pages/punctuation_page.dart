import 'package:flutter/material.dart';
import '../models/morse_code_data.dart';
import '../services/morse_audio_service.dart';
import '../widgets/morse_reference_table.dart';

class PunctuationPage extends StatelessWidget {
  final MorseAudioService audioService;

  const PunctuationPage({super.key, required this.audioService});

  @override
  Widget build(BuildContext context) {
    return MorseReferenceTable(
      data: MorseCodeData.punctuationMap,
      characterLabel: "Symbol",
      getSoundDescription: MorseCodeData.getMorseSound,
      onPlayPressed: (character) => audioService.playCharacter(character),
    );
  }
}
