class AudioSettings {
  double wpm;
  double volume;

  AudioSettings({this.wpm = 15, this.volume = 1.0});

  int get unitDurationMs => (60 / (wpm * 50) * 1000).round();
  int get dotDuration => unitDurationMs;
  int get dashDuration => unitDurationMs * 3;
  int get symbolGap => unitDurationMs;
  int get letterGap => unitDurationMs * 3;
  int get wordGap => unitDurationMs * 7;
}
