import 'package:flutter/material.dart';

class Music {
  String trackId;
  String? songName;
  String? artistName;
  String? songImage;
  Color? songColor;
  String? artistImage;
  Duration? duration;

  Music(
      {required this.trackId,
      this.songName,
      this.artistName,
      this.songImage,
      this.songColor,
      this.artistImage,
      this.duration});
}
