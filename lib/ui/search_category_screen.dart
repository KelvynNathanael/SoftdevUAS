import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/DI/service_locator.dart';
import 'package:mobile/bloc/playlist/playlist_bloc.dart';
import 'package:mobile/bloc/playlist/playlist_event.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/ui/playlist_search_screen.dart';
import 'package:mobile/ui/search_screen.dart';
import 'package:mobile/widgets/bottom_player.dart';

class SearchCategoryScreen extends StatefulWidget {
  const SearchCategoryScreen({super.key});

  @override
  State<SearchCategoryScreen> createState() => _SearchCategoryScreenState();
}

class _SearchCategoryScreenState extends State<SearchCategoryScreen> {
  String? scanResault;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(119, 18, 18, 1),
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            // Gradient background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color.fromRGBO(119, 18, 18, 1), // Dark red
                    const Color.fromRGBO(49, 12, 12, 1),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Search",
                            style: TextStyle(
                              fontFamily: "AB",
                              fontSize: 25,
                              color: MyColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const _SearchBox(),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 17, bottom: 17),
                      child: Text(
                        "Your top genres",
                        style: TextStyle(
                          fontFamily: "AM",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: MyColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ImageContainer(
                          title: " ",
                          image: "pop.png",
                          playlistName: "Pop",
                          coverImage: "2010s-mix.png",
                        ),
                        _ImageContainer(
                          title: " ",
                          image: "indie.png",
                          playlistName: "Indie",
                          coverImage: "2010s-mix.png",
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 25, bottom: 10),
                      child: Text(
                        "Browse all",
                        style: TextStyle(
                          fontFamily: "AM",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: MyColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _ImageContainer(
                          title: "2023 Wrapped",
                          image: "2023_wrapped.png",
                          playlistName: "2023 Wrapped",
                          coverImage: "2010s-mix.png",
                        ),
                        _ImageContainer(
                          title: "Podcasts",
                          image: "podcasts.png",
                          playlistName: "Podcasts",
                          coverImage: "2010s-mix.png",
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _ImageContainer(
                            title: "Made for you",
                            image: "made_for_you.png",
                            playlistName: "Made for you",
                            coverImage: "2010s-mix.png",
                          ),
                          _ImageContainer(
                            title: "Charts",
                            image: "charts.png",
                            playlistName: "Charts",
                            coverImage: "2010s-mix.png",
                          ),
                        ],
                      ),
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
    );
  }

  Future barcodeScanner() async {
    String scanResault;

    try {
      scanResault = await FlutterBarcodeScanner.scanBarcode(
          "#ffFFFF", "Cancel", false, ScanMode.QR);
    } on PlatformException {
      scanResault = "Failed to get Platform version";
    }
    if (!mounted) return;

    setState(() {
      this.scanResault = scanResault;
    });
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 46,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: MyColors.whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            child: Row(
              children: [
                Image.asset("images/icon_search_black.png"),
                const SizedBox(width: 15),
                const Text(
                  "Artists, songs, or podcasts",
                  style: TextStyle(
                    fontFamily: "AB",
                    color: MyColors.darGreyColor,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageContainer extends StatelessWidget {
  const _ImageContainer({
    required this.title,
    required this.image,
    required this.playlistName,
    required this.coverImage,
  });

  final String title;
  final String image;
  final String playlistName;
  final String coverImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) {
                var bloc = PlaylistBloc(locator.get());
                bloc.add(PlaylistFetchEvent(playlistName));
                return bloc;
              },
              child: PlaylistSearchScreen(
                cover: coverImage,
              ),
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 100,
            width: (MediaQuery.of(context).size.width / 1.75) - 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/$image"),
                fit: BoxFit.cover,
              ),
              color: Colors.red,
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: "AB",
                fontSize: 16,
                color: MyColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
