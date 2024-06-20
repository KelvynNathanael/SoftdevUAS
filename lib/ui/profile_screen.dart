import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/DI/service_locator.dart';
import 'package:mobile/bloc/playlist/playlist_bloc.dart';
import 'package:mobile/bloc/playlist/playlist_event.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/ui/playlist_search_screen.dart';
import 'package:mobile/widgets/bottom_player.dart';
import 'package:mobile/globals.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff101010),
                      width: 0,
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(119, 18, 18, 1),
                        Color.fromRGBO(49, 12, 12, 1),
                        Color.fromRGBO(0, 0, 0, 1),
                      ],
                    ),
                  ),
                  child: const _ProfileHeader(),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff101010),
                      width: 0,
                    ),
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  child: const _ProfilePlaylists(),
                ),
              ),
            ],
          ),
          const BottomPlayer(),
        ],
      ),
    );
  }
}

class _ProfilePlaylists extends StatelessWidget {
  const _ProfilePlaylists();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 199,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...GlobalPlayerState.playlists.keys.map((playlistName) {
                  final randomImage = GlobalPlayerState.getRandomImagePath();
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
                              cover: randomImage,
                            ),
                          ),
                        ),
                      );
                    },
                    child: _PlaylistChip(
                      title: playlistName,
                      image: randomImage,
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "See all playlists",
                  style: TextStyle(
                    fontFamily: "AM",
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaylistChip extends StatelessWidget {
  final String title;
  final String image;

  const _PlaylistChip({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(
              "images/home/$image"), // Ensure the correct path is used
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 189, 189, 189).withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "AB",
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset("images/icon_arrow_left.png"),
              ),
              Image.asset(
                "images/icon_more.png",
                color: MyColors.whiteColor,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage("images/myImage.png"),
                ),
                const SizedBox(height: 35),
                Container(
                  height: 31,
                  width: 105,
                  decoration: BoxDecoration(
                    color: const Color(0xff3E3F3F),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontFamily: "AB",
                        color: MyColors.whiteColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  GlobalPlayerState.username, // Menampilkan nama pengguna
                  style: const TextStyle(
                    fontFamily: "AB",
                    fontSize: 24,
                    color: MyColors.whiteColor,
                  ),
                ),
                const SizedBox(height: 65),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '23',
                          style: TextStyle(
                            fontFamily: "AM",
                            fontSize: 12,
                            color: MyColors.whiteColor,
                          ),
                        ),
                        Text(
                          "PlayLists",
                          style: TextStyle(
                            fontFamily: "AM",
                            fontSize: 12,
                            color: MyColors.lightGrey,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '58',
                          style: TextStyle(
                            fontFamily: "AM",
                            fontSize: 12,
                            color: MyColors.whiteColor,
                          ),
                        ),
                        Text(
                          "Followers",
                          style: TextStyle(
                            fontFamily: "AM",
                            fontSize: 10,
                            color: MyColors.lightGrey,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '43',
                          style: TextStyle(
                            fontFamily: "AM",
                            fontSize: 12,
                            color: MyColors.whiteColor,
                          ),
                        ),
                        Text(
                          "Following",
                          style: TextStyle(
                            fontFamily: "AM",
                            fontSize: 10,
                            color: MyColors.lightGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              "Playlists",
              style: TextStyle(
                fontFamily: "AM",
                fontWeight: FontWeight.w400,
                color: MyColors.whiteColor,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
