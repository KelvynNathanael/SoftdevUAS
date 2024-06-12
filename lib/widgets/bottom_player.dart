import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/data/model/music.dart';
import 'package:mobile/globals.dart';
import 'package:mobile/ui/listening_on_screen.dart';
import 'package:mobile/ui/music_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class BottomPlayer extends StatefulWidget {
  const BottomPlayer({super.key});

  @override
  State<BottomPlayer> createState() => _BottomPlayerState();
}

class _BottomPlayerState extends State<BottomPlayer> {
  AudioPlayer _audioPlayer = GlobalPlayerState.audioPlayer;
  var Tabs = [];
  int currentTabIndex = 0;

  List<Music> playlist = [];
  int currentIndex = 0;
  bool isLoop = false;

  bool _isInPlay = false;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        _playNextSong();
      }
    });

    // Ensure the state updates on music change
    GlobalPlayerState.currentMusic.addListener(() {
      setState(() {});
    });
    GlobalPlayerState.isPlaying.addListener(() {
      setState(() {});
    });
  }

  Future<void> _loadTrack(Music music) async {
    final yt = YoutubeExplode();
    final searchResult =
        await yt.search.search("${music.songName} ${music.artistName}");
    if (searchResult.isNotEmpty) {
      final videoId = searchResult.first.id.value;
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var audioUrl = manifest.audioOnly.last.url;
      await _audioPlayer.play(UrlSource(audioUrl.toString()));
      setState(() {
        GlobalPlayerState.currentMusic.value = music;
        GlobalPlayerState.isPlaying.value = true;
      });
    }
  }

  void _playNextSong() {
    if (currentIndex < playlist.length - 1) {
      currentIndex++;
      _loadTrack(playlist[currentIndex]);
    } else if (isLoop) {
      currentIndex = 0;
      _loadTrack(playlist[currentIndex]);
    }
  }

  void _playPreviousSong() {
    if (currentIndex > 0) {
      currentIndex--;
      _loadTrack(playlist[currentIndex]);
    }
  }

  Widget miniPlayer(Music? music, {bool stop = false}) {
    if (stop) {
      GlobalPlayerState.isPlaying.value = false;
      _audioPlayer.stop();
    }

    if (music == null) {
      return const SizedBox();
    }

    Size deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 59,
        width: deviceSize.width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 83, 83, 83),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 250),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  MusicPlayer(
                            music: music,
                            player: _audioPlayer,
                            isPlaying: GlobalPlayerState.isPlaying.value,
                            onNext: _playNextSong,
                            onPrevious: _playPreviousSong,
                            isLoop: isLoop,
                          ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            final tween = Tween(begin: begin, end: end);
                            final offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      ),
                      child: Row(
                        children: [
                          ValueListenableBuilder<Music?>(
                            valueListenable: GlobalPlayerState.currentMusic,
                            builder: (context, music, _) {
                              return Container(
                                height: 37,
                                width: 37,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(music?.songImage ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 190,
                                height: 20,
                                child: ValueListenableBuilder<Music?>(
                                  valueListenable:
                                      GlobalPlayerState.currentMusic,
                                  builder: (context, music, _) {
                                    return Text(
                                      music?.songName ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "AM",
                                        color: MyColors.whiteColor,
                                        fontSize: 13.5,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  },
                                ),
                              ),
                              ValueListenableBuilder<Music?>(
                                valueListenable: GlobalPlayerState.currentMusic,
                                builder: (context, music, _) {
                                  return Text(
                                    music?.artistName ?? '',
                                    style: const TextStyle(
                                      fontFamily: "AM",
                                      fontSize: 12,
                                      color: MyColors.whiteColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 103,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ListeningOn(),
                                ),
                              );
                            },
                            child: Image.asset(
                              'images/icon_listen.png',
                              color: const Color.fromARGB(255, 190, 190, 190),
                              height: 24,
                              width: 24,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isLiked = !_isLiked;
                                });
                              },
                              child: (_isLiked)
                                  ? Row(
                                      children: [
                                        Image.asset(
                                          'images/icon_heart_filled.png',
                                          height: 22,
                                          width: 22,
                                        ),
                                        const SizedBox(
                                          width: 9,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Image.asset('images/icon_heart.png'),
                                        const SizedBox(
                                          width: 9,
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: GlobalPlayerState.isPlaying,
                            builder: (context, isPlaying, _) {
                              return GestureDetector(
                                onTap: () async {
                                  GlobalPlayerState.isPlaying.value =
                                      !isPlaying;
                                  if (GlobalPlayerState.isPlaying.value) {
                                    await _audioPlayer.resume();
                                  } else {
                                    await _audioPlayer.pause();
                                  }
                                  setState(() {
                                    _isInPlay = !_isInPlay;
                                  });
                                },
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: isPlaying
                                      ? Icon(Icons.pause,
                                          color: MyColors.whiteColor)
                                      : Icon(Icons.play_arrow,
                                          color: MyColors.whiteColor),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<Duration>(
                stream: _audioPlayer.onPositionChanged,
                builder: (context, snapshot) {
                  final position = snapshot.data ?? Duration.zero;
                  return FutureBuilder<Duration?>(
                    future: _audioPlayer.getDuration(),
                    builder: (context, durationSnapshot) {
                      final Duration duration =
                          durationSnapshot.data ?? Duration.zero;
                      final double maxDuration =
                          duration.inMilliseconds.toDouble();
                      final double currentPosition =
                          position.inMilliseconds.toDouble();

                      return SliderTheme(
                        data: SliderThemeData(
                          overlayShape: SliderComponentShape.noOverlay,
                          thumbShape: SliderComponentShape.noThumb,
                          trackShape: RectangularSliderTrackShape(),
                          trackHeight: 3,
                        ),
                        child: SizedBox(
                          height: 12,
                          child: Slider(
                            activeColor:
                                const Color.fromARGB(255, 230, 229, 229),
                            inactiveColor: MyColors.lightGrey,
                            value: currentPosition.clamp(0.0, maxDuration),
                            min: 0.0,
                            max: maxDuration,
                            onChanged: (double value) {
                              final newPosition =
                                  Duration(milliseconds: value.toInt());
                              _audioPlayer.seek(newPosition);
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return miniPlayer(GlobalPlayerState.currentMusic.value);
  }
}
