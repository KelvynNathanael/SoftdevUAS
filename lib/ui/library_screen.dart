import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/DI/service_locator.dart';
import 'package:mobile/bloc/album/album_bloc.dart';
import 'package:mobile/bloc/album/album_event.dart';
import 'package:mobile/bloc/playlist/playlist_bloc.dart';
import 'package:mobile/bloc/playlist/playlist_event.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/ui/albumview_screen.dart';
import 'package:mobile/ui/playlist_search_screen.dart';
import 'package:mobile/ui/profile_screen.dart';
import 'package:mobile/ui/setting_screen.dart';
import 'package:mobile/widgets/album_chip.dart';
import 'package:mobile/widgets/artist_chip.dart';
import 'package:mobile/widgets/bottom_player.dart';
import 'package:mobile/widgets/song_chip.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(119, 18, 18, 1), // Dark red
              Color.fromRGBO(49, 12, 12, 1), // Darker red
            ],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SettingScreen(),
                                  ),
                                );
                              },
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        AssetImage("images/myImage.png"),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Your Library",
                                    style: TextStyle(
                                      fontFamily: "AB",
                                      fontSize: 24,
                                      color: MyColors.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfileScreen(),
                                  ),
                                );
                              },
                              child: Image.asset("images/icon_add.png"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "images/arrow_component_down.png",
                                      width: 10,
                                      height: 12,
                                    ),
                                    Image.asset(
                                      "images/arrow_component_up.png",
                                      width: 10,
                                      height: 12,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "Recently Played",
                                  style: TextStyle(
                                    fontFamily: "AM",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: MyColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset("images/icon_category.png"),
                          ],
                        ),
                      ),
                    ),
                    const _LikedSongsSection(),
                    const _NewEpisodesSection(),
                    SliverToBoxAdapter(
                      child: AlbumChip(
                        image: "For-All-The-Dogs.jpg",
                        albumName: "For All The Dogs",
                        artistName: "Drake",
                        size: 65,
                        isDeletable: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) {
                                  var bloc = PlaylistBloc(locator.get());
                                  bloc.add(PlaylistFetchEvent('Drake mix'));
                                  return bloc;
                                },
                                child: const PlaylistSearchScreen(
                                  cover: "For-All-The-Dogs.jpg",
                                ),
                              ),
                            ),
                          );
                        },
                        onDelete: () {},
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: AlbumChip(
                        image: "UTOPIA.jpg",
                        albumName: "Travis Scott",
                        artistName: "Travis Scott",
                        size: 65,
                        isDeletable: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) {
                                  var bloc = PlaylistBloc(locator.get());
                                  bloc.add(
                                      PlaylistFetchEvent('Travis Scott mix'));
                                  return bloc;
                                },
                                child: const PlaylistSearchScreen(
                                  cover: "UTOPIA.jpg",
                                ),
                              ),
                            ),
                          );
                        },
                        onDelete: () {},
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: AlbumChip(
                        image: "american-dream.jpg",
                        albumName: "american dream",
                        artistName: "21 Savage",
                        size: 65,
                        isDeletable: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) {
                                  var bloc = PlaylistBloc(locator.get());
                                  bloc.add(
                                      PlaylistFetchEvent('american dream'));
                                  return bloc;
                                },
                                child: const PlaylistSearchScreen(
                                  cover: "american-dream.jpg",
                                ),
                              ),
                            ),
                          );
                        },
                        onDelete: () {},
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: AlbumChip(
                        image: "AUSTIN.jpg",
                        albumName: "Post Malone",
                        artistName: "Landmine",
                        size: 65,
                        isDeletable: false,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) {
                                  var bloc = PlaylistBloc(locator.get());
                                  bloc.add(PlaylistFetchEvent('Post Malone'));
                                  return bloc;
                                },
                                child: const PlaylistSearchScreen(
                                  cover: "AUSTIN.jpg",
                                ),
                              ),
                            ),
                          );
                        },
                        onDelete: () {},
                      ),
                    ),
                    const SliverPadding(
                      padding: EdgeInsets.only(bottom: 130),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 64),
                child: BottomPlayer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewEpisodesSection extends StatelessWidget {
  const _NewEpisodesSection();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) {
                  var bloc = PlaylistBloc(locator.get());
                  bloc.add(PlaylistFetchEvent('New Episodes'));
                  return bloc;
                },
                child: const PlaylistSearchScreen(
                  cover: "Offset-Mix.jpg",
                ),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 15),
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset("images/new_episods.png"),
                  Image.asset("images/icon_bell_fill.png"),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "New Episodes",
                    style: TextStyle(
                      fontFamily: "AM",
                      fontSize: 15,
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Image.asset("images/icon_pin.png"),
                      const SizedBox(width: 5),
                      const Text(
                        "Updated 2 days ago",
                        style: TextStyle(
                          fontFamily: "AM",
                          color: MyColors.lightGrey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LikedSongsSection extends StatelessWidget {
  const _LikedSongsSection();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) {
                  var bloc = PlaylistBloc(locator.get());
                  bloc.add(PlaylistFetchEvent('liked song'));
                  return bloc;
                },
                child: const PlaylistSearchScreen(
                  cover: "Offset-Mix.jpg",
                ),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Image.asset("images/liked_songs.png"),
                  Image.asset("images/icon_heart_white.png"),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Liked Songs",
                    style: TextStyle(
                      fontFamily: "AM",
                      fontSize: 15,
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Image.asset("images/icon_pin.png"),
                      const SizedBox(width: 5),
                      const Text(
                        "Playlist . 58 songs",
                        style: TextStyle(
                          fontFamily: "AM",
                          color: MyColors.lightGrey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
