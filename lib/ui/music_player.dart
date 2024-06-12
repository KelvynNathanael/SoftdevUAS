import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mobile/data/model/music.dart';
import 'package:mobile/ui/lyrics_page.dart';
import 'package:mobile/globals.dart';

class MusicPlayer extends StatefulWidget {
  final Music music;
  final AudioPlayer player;
  final bool isPlaying;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLoop;

  const MusicPlayer({
    Key? key,
    required this.music,
    required this.player,
    required this.isPlaying,
    required this.onNext,
    required this.onPrevious,
    required this.isLoop,
  }) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer player;
  bool isPlaying = false;
  bool isLoop = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    player = widget.player;
    isPlaying = widget.isPlaying;
    isLoop = widget.isLoop;

    player.onPlayerComplete.listen((_) {
      if (isLoop) {
        print("Track completed and looping to next");
      } else {
        print("Track completed");
      }
    });
  }

  void _toggleLoop() {
    setState(() {
      isLoop = !isLoop;
      print("Looping is now: $isLoop");
    });
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return ValueListenableBuilder<Music?>(
      valueListenable: GlobalPlayerState.currentMusic,
      builder: (context, currentMusic, _) {
        if (currentMusic == null) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text(
                'No music playing',
                style: textTheme.headlineMedium?.copyWith(color: Colors.white),
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: currentMusic.songColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.close, color: Colors.transparent),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Singing Now',
                            style: textTheme.bodyMedium
                                ?.copyWith(color: Color(0xFF1BB751)),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: currentMusic.artistImage !=
                                        null
                                    ? NetworkImage(currentMusic.artistImage!)
                                    : null,
                                radius: 10,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                currentMusic.artistName ?? '-',
                                style: textTheme.bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Container(
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height * .4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: currentMusic.songImage != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(currentMusic.songImage!),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentMusic.songName ?? '',
                                  style: textTheme.titleLarge
                                      ?.copyWith(color: Colors.white),
                                ),
                                Text(
                                  currentMusic.artistName ?? '-',
                                  style: textTheme.titleMedium
                                      ?.copyWith(color: Colors.white60),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Color(0xFF1BB751),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        StreamBuilder<Duration>(
                          stream: player.onPositionChanged,
                          builder: (context, snapshot) {
                            final position =
                                snapshot.data ?? const Duration(seconds: 0);
                            final totalDuration = currentMusic.duration ??
                                const Duration(minutes: 4);
                            return ProgressBar(
                              progress: position,
                              total: totalDuration,
                              bufferedBarColor: Colors.white38,
                              baseBarColor: Colors.white10,
                              thumbColor: Colors.white,
                              timeLabelTextStyle:
                                  const TextStyle(color: Colors.white),
                              progressBarColor: Colors.white,
                              onSeek: (duration) {
                                player.seek(duration);
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LyricsPage(
                                      music: currentMusic,
                                      player: player,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.lyrics_outlined,
                                  color: Colors.white),
                            ),
                            IconButton(
                              onPressed: widget.onPrevious,
                              icon: const Icon(Icons.skip_previous,
                                  color: Colors.white, size: 36),
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: GlobalPlayerState.isPlaying,
                              builder: (context, isPlaying, _) {
                                return IconButton(
                                  onPressed: () async {
                                    if (isPlaying) {
                                      await player.pause();
                                    } else {
                                      await player.resume();
                                    }
                                    GlobalPlayerState.isPlaying.value =
                                        !isPlaying;
                                  },
                                  icon: Icon(
                                    isPlaying ? Icons.pause : Icons.play_circle,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              onPressed: widget.onNext,
                              icon: const Icon(Icons.skip_next,
                                  color: Colors.white, size: 36),
                            ),
                            IconButton(
                              onPressed: _toggleLoop,
                              icon: Icon(
                                Icons.loop,
                                color:
                                    isLoop ? Color(0xFF1BB751) : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
