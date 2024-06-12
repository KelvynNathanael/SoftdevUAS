import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:mobile/data/model/music.dart';

class GlobalPlayerState {
  static final AudioPlayer audioPlayer = AudioPlayer();
  static final ValueNotifier<Music?> currentMusic = ValueNotifier<Music?>(null);
  static final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
}
