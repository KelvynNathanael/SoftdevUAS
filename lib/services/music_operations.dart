import 'package:mobile/data/model/music.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:mobile/constants/strings.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/material.dart';

class MusicOperations {
  MusicOperations._() {}

  static Future<List<Music>> getMusic() async {
    final credentials = SpotifyApiCredentials(
        CustomStrings.clientId, CustomStrings.clientSecret);
    final spotify = SpotifyApi(credentials);
    final yt = YoutubeExplode();

    List<Music> playlist = [
      Music(trackId: '6rWblGW0pBcB3uygxBuWZV'), // As You Fade Away - Neffex
      Music(trackId: '32Pdf9eyXDEMoClEJW6yYP'), // Interaksi - Tulus
      Music(
          trackId:
              '2S2laN33BdttxJ8yyv4VbX'), // Another Day In Paradise - Quinn XCII
    ];

    for (var music in playlist) {
      final track = await spotify.tracks.get(music.trackId);

      music.songName = track.name;
      music.artistName = track.artists?.first.name ?? '';
      String? image = track.album?.images?.first.url;
      if (image != null) {
        music.songImage = image;
        final tempSongColor = await getImagePalette(NetworkImage(image));
        if (tempSongColor != null) {
          music.songColor = tempSongColor;
        }
      }
      music.artistImage = track.artists?.first.images?.first.url;

      final video =
          (await yt.search.search("${music.songName} ${music.artistName}"))
              .first;
      final videoId = video.id.value;
      music.duration = video.duration;
    }

    return playlist;
  }

  static Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }

  static Future<Music> getMusicDetail(String trackId) async {
    final credentials = SpotifyApiCredentials(
        CustomStrings.clientId, CustomStrings.clientSecret);
    final spotify = SpotifyApi(credentials);

    final track = await spotify.tracks.get(trackId);

    String? songName = track.name;
    String? artistName = track.artists?.first.name ?? '';
    String? image = track.album?.images?.first.url;

    Color? songColor;
    if (image != null) {
      final tempSongColor = await getImagePalette(NetworkImage(image));
      if (tempSongColor != null) {
        songColor = tempSongColor;
      }
    }

    String? artistImage = track.artists?.first.images?.first.url;

    return Music(
      trackId: trackId,
      songName: songName,
      artistName: artistName,
      songImage: image,
      songColor: songColor,
      artistImage: artistImage,
    );
  }

  static Future<List<Music>> getMusicDetails(List<String> trackIds) async {
    List<Music> musicList = [];
    for (String trackId in trackIds) {
      musicList.add(await getMusicDetail(trackId));
    }
    return musicList;
  }
}
