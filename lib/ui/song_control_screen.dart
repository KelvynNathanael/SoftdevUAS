import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/globals.dart';
import 'package:mobile/ui/share_song_screen.dart';

class SongControlScreen extends StatelessWidget {
  const SongControlScreen(
      {super.key,
      required this.trackId,
      required this.trackName,
      required this.color,
      required this.singer,
      required this.albumImage});
  final String trackId;
  final String albumImage;
  final String trackName;
  final Color color;
  final String singer;

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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 380,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0,
                    color: MyColors.blackColor,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      color,
                      MyColors.blackColor,
                    ],
                  ),
                ),
                child: _SongHeader(
                  trackName: trackName,
                  singer: singer,
                  albumImage: albumImage,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0,
                    color: MyColors.blackColor,
                  ),
                  color: MyColors.blackColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      _LikeButton(trackId: trackId), // Updated line
                      const _AlbumChip(
                          text: "Hide song", image: "icon_hide_song.png"),
                      const _AlbumChip(
                          text: "Add to playlist",
                          image: "icon_add_to_playlist.png"),
                      const _AlbumChip(
                          text: "Add to queue", image: "icon_add_to_quoue.png"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShareSongScreen(),
                            ),
                          );
                        },
                        child: const _AlbumChip(
                            text: "Share", image: "icon_share.png"),
                      ),
                      const _AlbumChip(
                          text: "Go to radio", image: "icon_radio.png"),
                      const _AlbumChip(
                          text: "View album", image: "icon_album.png"),
                      const _AlbumChip(
                          text: "View artist", image: "icon_view_artist.png"),
                      const _AlbumChip(
                          text: "Song credits", image: "icon_song_credits.png"),
                      const _AlbumChip(
                          text: "Sleep timer", image: "icon_sleep_timer.png"),
                      const SizedBox(height: 30),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Close",
                            style: TextStyle(
                              fontFamily: "AM",
                              fontSize: 16,
                              color: MyColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LikeButton extends StatefulWidget {
  final String trackId;

  const _LikeButton({required this.trackId});

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<_LikeButton> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = GlobalPlayerState.likes.contains(widget.trackId);
  }

  void _toggleLike() {
    setState(() {
      if (isLiked) {
        GlobalPlayerState.likes.remove(widget.trackId);
      } else {
        GlobalPlayerState.likes.add(widget.trackId);
      }
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleLike,
      child: _AlbumChip(
        text: "Like",
        image: isLiked ? "icon_heart_filled.png" : "icon_heart.png",
      ),
    );
  }
}

class _AlbumChip extends StatelessWidget {
  const _AlbumChip({required this.text, required this.image});
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset("images/$image"),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontFamily: "AM",
              fontSize: 16,
              color: MyColors.lightGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _SongHeader extends StatelessWidget {
  const _SongHeader(
      {required this.trackName,
      required this.albumImage,
      required this.singer});
  final String albumImage;
  final String trackName;
  final String singer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 50,
        ),
        albumImage.isNotEmpty
            ? Image.network(
                albumImage,
                height: 164,
                width: 164,
                fit: BoxFit.cover,
              )
            : Image.asset(
                'images/default_cover.jpg',
                height: 164,
                width: 164,
                fit: BoxFit.cover,
              ),
        const SizedBox(
          height: 55,
        ),
        Center(
          child: Text(
            trackName,
            style: const TextStyle(
              fontFamily: "AM",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: MyColors.whiteColor,
            ),
          ),
        ),
        Center(
          child: Text(
            singer,
            style: const TextStyle(
              fontFamily: "AM",
              fontSize: 14,
              color: MyColors.lightGrey,
            ),
          ),
        ),
        const SizedBox(
          height: 55,
        ),
      ],
    );
  }
}
