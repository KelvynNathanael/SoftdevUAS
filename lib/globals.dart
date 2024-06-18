import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mobile/data/model/music.dart';
import 'package:mobile/data/model/playlist_track.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class GlobalPlayerState {
  static final AudioPlayer audioPlayer = AudioPlayer();
  static final ValueNotifier<Music?> currentMusic = ValueNotifier<Music?>(null);
  static final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);
  static final List<String> likes = [];
  static List<PLaylistTrack> playlistTracks = [];
  static int currentTrackIndex = 0;
  static Map<String, List<String>> playlists = {};
  static List<String> playlistToAdd = [];

  static void deletePlaylist(String playlistName) {
    if (playlists.containsKey(playlistName)) {
      playlists.remove(playlistName);
    }
  }

  static void removeTrackFromPlaylist(String playlistName, String trackId) {
    if (playlists.containsKey(playlistName)) {
      playlists[playlistName]?.remove(trackId);
    }
  }

  static void playNextTrack() {
    if (currentTrackIndex < playlistTracks.length - 1) {
      currentTrackIndex++;
      playTrackAtCurrentIndex();
    }
  }

  static void playPreviousTrack() {
    if (currentTrackIndex > 0) {
      currentTrackIndex--;
      playTrackAtCurrentIndex();
    }
  }

  static Future<void> playTrackAtCurrentIndex() async {
    final track = playlistTracks[currentTrackIndex];
    final yt = YoutubeExplode();
    final searchResult =
        await yt.search.search("${track.trackName} ${track.artistName}");
    if (searchResult.isNotEmpty) {
      final videoId = searchResult.first.id.value;
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var audioUrl = manifest.audioOnly.last.url;
      await audioPlayer.play(UrlSource(audioUrl.toString()));

      final dominantColor =
          await PaletteGenerator.fromImageProvider(NetworkImage(track.image))
              .then((palette) => palette.dominantColor?.color ?? Colors.black);

      currentMusic.value = Music(
        trackId: track.trackId,
        songName: track.trackName,
        artistName: track.artistName,
        songImage: track.image,
        songColor: dominantColor,
      );
      isPlaying.value = true;
    }
  }

  static Future<void> pause() async {
    await audioPlayer.pause();
    isPlaying.value = false;
  }

  static void likeTrack(String trackId) {
    if (!likes.contains(trackId)) {
      likes.add(trackId);
    }
  }
}