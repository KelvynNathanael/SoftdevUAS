import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/DI/service_locator.dart';
import 'package:mobile/bloc/album/album_bloc.dart';
import 'package:mobile/bloc/album/album_event.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/ui/albumview_screen.dart';
import 'package:mobile/widgets/album_chip.dart';
import 'package:mobile/widgets/artist_chip.dart';
import 'package:mobile/widgets/song_chip.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(119, 18, 18, 1),
        body: SafeArea(
          child: Stack(
              alignment: AlignmentDirectional
                  .topStart, // Adjust for gradient placement
              children: [
                // Gradient background
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft, // Adjust for gradient direction
                      end: Alignment.bottomRight,
                      colors: [
                        const Color.fromRGBO(119, 18, 18, 1), // Dark red
                        const Color.fromRGBO(49, 12, 12, 1),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomScrollView(
                    slivers: [
                      const _SearchBox(),
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 20),
                          child: Text(
                            "Recent searches",
                            style: TextStyle(
                              fontFamily: "AM",
                              fontWeight: FontWeight.w400,
                              color: MyColors.whiteColor,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (cotnext) {
                                    var bloc = AlbumBloc(locator.get());
                                    bloc.add(AlbumListEvent("Post Malone"));
                                    return bloc;
                                  },
                                  child: const AlbumViewScreen(),
                                ),
                              ),
                            );
                          },
                          child: const AlbumChip(
                            image: "AUSTIN.jpg",
                            albumName: "AUSTIN",
                            artistName: "Post Malone",
                            size: 47,
                            isDeletable: true,
                          ),
                        ),
                      ),
                      const ArtistChip(
                        image: 'Doja-Cat.jpg',
                        name: "Doja Cat",
                        radius: 23,
                        isDeletable: true,
                      ),
                      const SongChip(
                        image: "UTOPIA.jpg",
                        singerName: 'Travis Scott',
                        songTitle: "MY EYES",
                        size: 47,
                        isDeletable: true,
                      ),
                      const ArtistChip(
                        image: "Lil-Wayne.jpg",
                        name: "Lil Wayne",
                        radius: 23,
                        isDeletable: true,
                      ),
                      const ArtistChip(
                        image: "Megan-Thee-Stallion.jpg",
                        name: "Megan Thee Stallion",
                        radius: 23,
                        isDeletable: true,
                      ),
                      SliverToBoxAdapter(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) {
                                    var bloc = AlbumBloc(locator.get());
                                    bloc.add(AlbumListEvent("21 Savage"));
                                    return bloc;
                                  },
                                  child: const AlbumViewScreen(),
                                ),
                              ),
                            );
                          },
                          child: const AlbumChip(
                            image: "american-dream.jpg",
                            albumName: "american dream",
                            artistName: "21 Savage",
                            size: 47,
                            isDeletable: true,
                          ),
                        ),
                      ),
                      const SongChip(
                        image: "For-All-The-Dogs.jpg",
                        singerName: 'Drake',
                        songTitle: "IDGAF",
                        size: 47,
                        isDeletable: true,
                      ),
                      const ArtistChip(
                        image: "Taylor-Swift.jpg",
                        name: "Taylor Swift",
                        radius: 23,
                        isDeletable: true,
                      ),
                      const SongChip(
                        image: "AUSTIN.jpg",
                        singerName: 'Post Malone',
                        songTitle: "Laugh It Off",
                        size: 47,
                        isDeletable: true,
                      ),
                    ],
                  ),
                ),
              ]),
        ));
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 35,
              width: MediaQuery.of(context).size.width - 102.5,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Image.asset(
                      "images/icon_search_transparent.png",
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    const Expanded(
                      child: TextField(
                        style: TextStyle(
                          fontFamily: "AM",
                          fontSize: 16,
                          color: Color.fromARGB(255, 15, 15, 15),
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 10, left: 15),
                          hintText: "Search",
                          hintStyle: TextStyle(
                            fontFamily: "AM",
                            color: Color.fromARGB(255, 0, 0, 0),
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
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                    fontFamily: "AM", color: MyColors.whiteColor, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
