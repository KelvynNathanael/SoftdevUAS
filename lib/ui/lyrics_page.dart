import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/model/music.dart';
import 'package:mobile/data/model/lyric.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LyricsPage extends StatefulWidget {
  final Music music;
  final AudioPlayer player;

  const LyricsPage({super.key, required this.music, required this.player});

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> {
  List<Lyric>? lyrics;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();
  StreamSubscription? streamSubscription;
  int scrollOffset = 0; // Added to track current scroll position

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    streamSubscription = widget.player.onPositionChanged.listen((duration) {
      DateTime dt = DateTime(1970, 1, 1).copyWith(
        hour: duration.inHours,
        minute: duration.inMinutes.remainder(60),
        second: duration.inSeconds.remainder(60),
      );

      if (lyrics != null) {
        int currentIndex =
            lyrics!.indexWhere((lyric) => lyric.timeStamp.isAfter(dt));
        if (currentIndex >= 0) {
          // Ensure we stay within list bounds
          currentIndex = currentIndex.clamp(0, lyrics!.length - 1);
          int newScrollOffset =
              currentIndex - 1; // Show current and previous line

          // Only scroll if position has changed significantly
          if ((newScrollOffset - scrollOffset).abs() > 2) {
            itemScrollController.scrollTo(
                index: newScrollOffset,
                duration: const Duration(milliseconds: 600));
            scrollOffset = newScrollOffset; // Update tracked position
          }
        }
      }
    });
    get(Uri.parse(
            'https://paxsenixofc.my.id/server/getLyricsMusix.php?q=${widget.music.songName} ${widget.music.artistName}&type=default'))
        .then((response) {
      String data = response.body;
      lyrics = data
          .split('\n')
          .map((e) => Lyric(e.split(' ').sublist(1).join(' '),
              DateFormat("[mm:ss.SS]").parse(e.split(' ')[0])))
          .toList();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.music.songColor,
      body: lyrics != null
          ? SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0)
                    .copyWith(top: 20),
                child: StreamBuilder<Duration>(
                  stream: widget.player.onPositionChanged,
                  builder: (context, snapshot) {
                    return ScrollablePositionedList.builder(
                      itemCount: lyrics!.length,
                      itemBuilder: (context, index) {
                        Duration duration = snapshot.data ?? Duration.zero;
                        DateTime dt = DateTime(1970, 1, 1).copyWith(
                          hour: duration.inHours,
                          minute: duration.inMinutes.remainder(60),
                          second: duration.inSeconds.remainder(60),
                        );
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            lyrics![index].words,
                            style: TextStyle(
                              color: lyrics![index].timeStamp.isAfter(dt)
                                  ? Colors.white38
                                  : Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                      itemScrollController: itemScrollController,
                      scrollOffsetController: scrollOffsetController,
                      itemPositionsListener: itemPositionsListener,
                      scrollOffsetListener: scrollOffsetListener,
                    );
                  },
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
