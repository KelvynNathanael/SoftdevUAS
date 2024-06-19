import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/globals.dart';
import 'package:mobile/ui/share_song_screen.dart';
import 'package:mobile/data/model/playlist.dart';
import 'package:mobile/data/model/playlist_track.dart';
import 'package:mobile/services/music_operations.dart';

class SongControlScreen extends StatelessWidget {
  const SongControlScreen(
      {super.key,
      required this.trackId,
      required this.trackName,
      required this.color,
      required this.singer,
      required this.albumImage,
      this.playlistName}); // Modify this line to add the playlist name
  final String trackId;
  final String albumImage;
  final String trackName;
  final Color color;
  final String singer;
  final String? playlistName;

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
                      _LikeButton(trackId: trackId),
                      const _AlbumChip(
                          text: "Hide song", image: "icon_hide_song.png"),
                      GestureDetector(
                        onTap: () => _showAddToPlaylistDialog(context),
                        child: const _AlbumChip(
                            text: "Add to playlist",
                            image: "icon_add_to_playlist.png"),
                      ),
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
                      if (playlistName !=
                          null) // Only show if a playlist name is provided
                        GestureDetector(
                          onTap: () => _removeFromPlaylist(context),
                          child: const _AlbumChip(
                              text: "Remove from playlist",
                              image: "icon_remove_playlist.png"),
                        ),
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

  void _showAddToPlaylistDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddToPlaylistDialog(trackId: trackId),
    );
  }

  void _removeFromPlaylist(BuildContext context) {
    if (playlistName != null) {
      GlobalPlayerState.removeTrackFromPlaylist(playlistName!, trackId);
      Navigator.pop(context); // Close the screen after removing the track
    }
  }
}

class AddToPlaylistDialog extends StatefulWidget {
  final String trackId;

  const AddToPlaylistDialog({required this.trackId});

  @override
  _AddToPlaylistDialogState createState() => _AddToPlaylistDialogState();
}

class _AddToPlaylistDialogState extends State<AddToPlaylistDialog> {
  final TextEditingController _playlistNameController = TextEditingController();
  String? selectedPlaylist;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add to Playlist'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            hint: Text('Select Playlist'),
            value: selectedPlaylist,
            onChanged: (String? value) {
              setState(() {
                selectedPlaylist = value;
              });
            },
            items: GlobalPlayerState.playlists.keys.map((String playlistName) {
              return DropdownMenuItem<String>(
                value: playlistName,
                child: Text(playlistName),
              );
            }).toList(),
          ),
          TextField(
            controller: _playlistNameController,
            decoration: InputDecoration(hintText: 'New Playlist Name'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _addToPlaylist();
          },
          child: Text('Add'),
        ),
        if (selectedPlaylist != null) ...[
          if (GlobalPlayerState.playlists[selectedPlaylist]!
              .contains(widget.trackId))
            TextButton(
              onPressed: () {
                _removeFromPlaylist();
              },
              child: Text('Delete from Playlist',
                  style: TextStyle(color: Colors.red)),
            ),
          TextButton(
            onPressed: () {
              _deletePlaylist();
            },
            child: Text('Delete Playlist', style: TextStyle(color: Colors.red)),
          ),
        ]
      ],
    );
  }

  void _addToPlaylist() {
    if (_playlistNameController.text.isNotEmpty) {
      String newPlaylistName = _playlistNameController.text;
      if (!GlobalPlayerState.playlists.containsKey(newPlaylistName)) {
        GlobalPlayerState.playlists[newPlaylistName] = [];
      }
      GlobalPlayerState.playlists[newPlaylistName]!.add(widget.trackId);
    } else if (selectedPlaylist != null) {
      GlobalPlayerState.playlists[selectedPlaylist]!.add(widget.trackId);
    }

    setState(() {
      _playlistNameController.clear();
      selectedPlaylist = null;
    });

    Navigator.of(context).pop();
  }

  void _removeFromPlaylist() {
    if (selectedPlaylist != null) {
      GlobalPlayerState.playlists[selectedPlaylist]!.remove(widget.trackId);
      setState(() {
        selectedPlaylist = null;
      });
      Navigator.of(context).pop();
    }
  }

  void _deletePlaylist() {
    if (selectedPlaylist != null) {
      GlobalPlayerState.deletePlaylist(selectedPlaylist!);
      setState(() {
        selectedPlaylist = null;
      });
      Navigator.of(context).pop();
    }
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
              fontSize: 16,
              color: MyColors.lightGrey,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
