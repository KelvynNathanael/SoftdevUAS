import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/bloc/playlist/playlist_bloc.dart';
import 'package:mobile/bloc/playlist/playlist_state.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/data/model/music.dart';
import 'package:mobile/data/model/playlist_track.dart';
import 'package:mobile/globals.dart';
import 'package:mobile/widgets/bottom_player.dart';
import 'package:mobile/widgets/stream_buttons.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlaylistSearchScreen extends StatefulWidget {
  const PlaylistSearchScreen({super.key, required this.cover});
  final String cover;

  @override
  _PlaylistSearchScreenState createState() => _PlaylistSearchScreenState();
}

class _PlaylistSearchScreenState extends State<PlaylistSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromRGBO(119, 18, 18, 1), // Dark red
            const Color.fromRGBO(49, 12, 12, 1),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: BlocBuilder<PlaylistBloc, PlaylistState>(
            builder: (context, state) {
              if (state is PlaylistResponseState) {
                return Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomScrollView(
                        slivers: [
                          _Header(
                            cover: widget.cover,
                          ),
                          _PlaylistActionButtons(time: state.playlist.time),
                          _SongList(state: state),
                          const SliverPadding(
                            padding: EdgeInsets.only(bottom: 50),
                          ),
                        ],
                      ),
                    ),
                    const BottomPlayer(),
                  ],
                );
              }
              return const Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontFamily: "AB",
                    fontSize: 18,
                    color: MyColors.whiteColor,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SongList extends StatelessWidget {
  const _SongList({required this.state});
  final PlaylistResponseState state;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 20, bottom: 35),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final track = state.playlist.tracks[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () async {
                  GlobalPlayerState.playlistTracks = state.playlist.tracks;
                  GlobalPlayerState.currentTrackIndex = index;
                  await GlobalPlayerState.playTrackAtCurrentIndex();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 48,
                          width: 48,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: track.image.isNotEmpty
                                ? Image.network(
                                    track.image,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'images/default_cover.jpg',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 115,
                              child: Text(
                                track.trackName,
                                style: const TextStyle(
                                  fontFamily: "AM",
                                  fontSize: 16,
                                  color: MyColors.whiteColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              track.artistName,
                              style: const TextStyle(
                                fontFamily: "AM",
                                color: MyColors.lightGrey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Image.asset("images/icon_more.png"),
                  ],
                ),
              ),
            );
          },
          childCount: state.playlist.tracks.length,
        ),
      ),
    );
  }
}

class _PlaylistActionButtons extends StatefulWidget {
  const _PlaylistActionButtons({required this.time});
  final String time;

  @override
  State<_PlaylistActionButtons> createState() => _PlaylistActionButtonsState();
}

class _PlaylistActionButtonsState extends State<_PlaylistActionButtons> {
  bool _isInPlay = false;
  bool _isDownloaded = false;
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "New and approved indie pop. CoverL No Rome",
                style: TextStyle(
                  fontFamily: "AM",
                  fontSize: 13,
                  color: MyColors.lightGrey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset(
                    'images/Logo1.png',
                    width: 50, // Set desired width
                    height: 50,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Devil Music",
                    style: TextStyle(
                      fontFamily: "AM",
                      fontWeight: FontWeight.w700,
                      color: MyColors.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "1,629,592 likes . ${widget.time}",
                style: const TextStyle(
                  fontFamily: "AM",
                  fontSize: 13,
                  color: MyColors.lightGrey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                      child: (_isLiked)
                          ? Image.asset(
                              'images/icon_heart_filled.png',
                              height: 19,
                              width: 20,
                            )
                          : Image.asset('images/icon_heart.png'),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isDownloaded = !_isDownloaded;
                        });
                      },
                      child: (_isDownloaded)
                          ? Image.asset('images/icon_downloaded.png')
                          : Image.asset('images/icon_download.png'),
                    ),
                    Image.asset('images/icon_more.png'),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  _isInPlay = !_isInPlay;
                });
                if (_isInPlay) {
                  // Play the first track
                  GlobalPlayerState.currentTrackIndex = 0;
                  await GlobalPlayerState.playTrackAtCurrentIndex();
                } else {
                  // Pause the currently playing track
                  await GlobalPlayerState.pause();
                }
              },
              child: (_isInPlay)
                  ? const PauseButton(
                      iconWidth: 5,
                      iconHeight: 19,
                      color: MyColors.greenColor,
                      height: 56,
                      width: 56,
                    )
                  : const PlayButton(
                      color: MyColors.greenColor,
                      height: 56,
                      width: 56,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.cover});
  final String cover;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _SearchBox(),
              Container(
                height: 38,
                width: 64,
                decoration: BoxDecoration(
                  color: MyColors.whiteColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Sort",
                    style: TextStyle(
                      fontFamily: "AM",
                      fontSize: 14,
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Image.asset(
              'images/home/$cover',
              height: 270,
              width: 270,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 38,
            width: MediaQuery.of(context).size.width - 105,
            decoration: BoxDecoration(
              color: MyColors.whiteColor.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Image.asset(
                    "images/icon_search_transparent.png",
                    color: MyColors.whiteColor,
                  ),
                  const Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontFamily: "AM",
                        fontSize: 16,
                        color: MyColors.whiteColor,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10, left: 15),
                        hintText: "Find in playlist",
                        hintStyle: TextStyle(
                          fontFamily: "AM",
                          color: MyColors.whiteColor,
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                            width: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
