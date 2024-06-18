import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/DI/service_locator.dart';
import 'package:mobile/bloc/playlist/playlist_bloc.dart';
import 'package:mobile/bloc/playlist/playlist_event.dart';
import 'package:mobile/bloc/playlist/playlist_state.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/globals.dart';
import 'package:mobile/ui/playlist_search_screen.dart';
import 'package:mobile/widgets/album_chip.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  void _addRecentSearch(String search) {
    if (search.isNotEmpty) {
      setState(() {
        if (!GlobalPlayerState.recentSearches.contains(search)) {
          GlobalPlayerState.recentSearches.add(search);
        }
      });
    }
  }

  void _deleteRecentSearch(String search) {
    setState(() {
      GlobalPlayerState.recentSearches.remove(search);
    });
  }

  Future<void> _executeSearch(String query) async {
    if (query.isNotEmpty) {
      var bloc = PlaylistBloc(locator.get());
      bloc.add(PlaylistFetchEvent(query));

      // Tunggu hingga state diupdate
      await Future.delayed(
          Duration(seconds: 2)); // Sesuaikan delay sesuai kebutuhan

      bloc.stream.listen((state) {
        if (state is PlaylistResponseState) {
          if (state.playlist.tracks.isNotEmpty) {
            _addRecentSearch(query);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: bloc,
                  child: PlaylistSearchScreen(
                    cover:
                        "Drake-Mix.jpg", // Ganti dengan cover yang sesuai
                  ),
                ),
              ),
            );
          } else {
            // Tampilkan pesan bahwa tidak ada hasil yang ditemukan
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('No playlists found for "$query"'),
              ),
            );
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(119, 18, 18, 1),
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            // Gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(119, 18, 18, 1), // Dark red
                    Color.fromRGBO(49, 12, 12, 1),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomScrollView(
                slivers: [
                  _SearchBox(
                    controller: searchController,
                    onSearch: (query) {
                      _executeSearch(query);
                    },
                  ),
                  SliverToBoxAdapter(
                    child: GlobalPlayerState.recentSearches
                            .where((search) => search.isNotEmpty)
                            .isNotEmpty
                        ? const Padding(
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
                          )
                        : Container(),
                  ),
                  ...GlobalPlayerState.recentSearches
                      .where((search) => search.isNotEmpty)
                      .map((search) => SliverToBoxAdapter(
                            child: AlbumChip(
                              image:
                                  "Drake-Mix.jpg", // Change to appropriate cover
                              albumName: search,
                              artistName: search,
                              size: 47,
                              isDeletable: true,
                              onDelete: () {
                                _deleteRecentSearch(search);
                              },
                              onTap: () {
                                _executeSearch(search);
                              },
                            ),
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const _SearchBox({required this.controller, required this.onSearch});

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
              width: MediaQuery.of(context).size.width - 152.5,
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
                    GestureDetector(
                      onTap: () {
                        onSearch(controller.text);
                      },
                      child: Image.asset(
                        "images/icon_search_transparent.png",
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(width: 10), // Add some spacing
                    Expanded(
                      child: TextField(
                        controller: controller,
                        style: const TextStyle(
                          fontFamily: "AM",
                          fontSize: 16,
                          color: Color.fromARGB(255, 15, 15, 15),
                        ),
                        decoration: const InputDecoration(
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
                        onSubmitted: onSearch,
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
                  fontFamily: "AM",
                  color: MyColors.whiteColor,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
