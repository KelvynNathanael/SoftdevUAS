import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:mobile/DI/service_locator.dart';
import 'package:mobile/bloc/album/album_bloc.dart';
import 'package:mobile/bloc/album/album_event.dart';
import 'package:mobile/bloc/playlist/playlist_bloc.dart';
import 'package:mobile/bloc/playlist/playlist_event.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/ui/albumview_screen.dart';
import 'package:mobile/ui/edit_profile.dart';
import 'package:mobile/ui/playlist_search_screen.dart';
import 'package:mobile/widgets/bottom_player.dart';

import 'package:mobile/data/model/music.dart';
import 'package:mobile/services/music_operations.dart';
import 'package:mobile/globals.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:audioplayers/audioplayers.dart';

import 'timer_provider.dart';
import 'dart:async';


class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
  
  }
  class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;
  int _seconds = 0;
  final int targetMinutes = 0;
  final int targetSeconds = 10;
  bool _popupShown = false; 

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });

      int totalTargetSeconds = (targetMinutes * 60) + targetSeconds;

      if (_seconds == totalTargetSeconds && !_popupShown) {
        _showPopup();
        _popupShown = true; // set flag biar pop up muncul 1x aj
      }
    });
  }

  void _showPopup() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('CLAIM HADIAH ANDA'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('images/hadiah.png'),
          SizedBox(height: 10), // Add some space between the image and text
          Text('Selamat Anda Mendapatkan Hadiah.'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerProvider()..startTimer(),
      child: Scaffold(
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
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CustomScrollView(
                    slivers: [
                      _Header(),
                      _JumpBackin(),
                      _TopMixes(),
                      _RecentPlays(),
                      SliverPadding(
                        padding: EdgeInsets.only(bottom: 100),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 64),
                  child: BottomPlayer(),
                ),
                TimerOverlay(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecentPlays extends StatefulWidget {
  const _RecentPlays();

  @override
  State<_RecentPlays> createState() => _RecentPlaysState();
}

class _RecentPlaysState extends State<_RecentPlays> {
  late Future<List<Music>> _musicListFuture;

  @override
  void initState() {
    super.initState();
    _musicListFuture = MusicOperations.getMusic();
  }

  Future<void> _loadAndPlayTrack(Music music) async {
    final yt = YoutubeExplode();
    final searchResult =
        await yt.search.search("${music.songName} ${music.artistName}");
    if (searchResult.isNotEmpty) {
      final videoId = searchResult.first.id.value;
      var manifest = await yt.videos.streamsClient.getManifest(videoId);
      var audioUrl = manifest.audioOnly.last.url;
      await GlobalPlayerState.audioPlayer.play(UrlSource(audioUrl.toString()));
      GlobalPlayerState.currentMusic.value = music;
      GlobalPlayerState.isPlaying.value = true;
    }
  }

  Widget createMusic(Music music) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 133,
            width: 133,
            child: InkWell(
              onTap: () async {
                await _loadAndPlayTrack(music);
                // Add any additional actions for mini player if needed
              },
              child: Image.network(
                music.songImage ?? 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error);
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            music.songName ?? 'Unknown Song',
            style:
                TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'AB'),
          ),
          Text(
            music.artistName ?? 'Unknown Song',
            style:
                TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'AB'),
          ),
        ],
      ),
    );
  }

  Widget createMusicList(String label, AsyncSnapshot<List<Music>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      List<Music> musicList = snapshot.data!;
      return Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'AM'),
            ),
            SizedBox(
              height: 199,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return createMusic(musicList[index]);
                },
                itemCount: musicList.length,
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder<List<Music>>(
          future: _musicListFuture,
          builder: (context, snapshot) {
            return createMusicList('Recently played', snapshot);
          },
        ),
      ),
    );
  }
}

class TimerOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final seconds = context.watch<TimerProvider>().seconds;

    if (seconds == 0) {
      return SizedBox.shrink();
    }

    return Positioned(
      top: 100,
      right: 20,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(
              'images/hadiah.png',
              width: 24,
              height: 24,
            ),
            SizedBox(width: 8),
            Text(
              'Time: $seconds s',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JumpBackin extends StatelessWidget {
  const _JumpBackin();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Jump back in",
              style: TextStyle(
                fontFamily: "AB",
                color: MyColors.whiteColor,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 199,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) {
                              var bloc = PlaylistBloc(locator.get());
                              bloc.add(PlaylistFetchEvent('future mix'));
                              return bloc;
                            },
                            child: const PlaylistSearchScreen(
                              cover: "Rap-Workout.jpg",
                            ),
                          ),
                        ),
                      );
                    },
                    child: const _MixChip(
                      subtitle: "Future, Jack Harlow, Drake and more",
                      image: "Rap-Workout.jpg",
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
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
                              cover: "Drake-Mix.jpg",
                            ),
                          ),
                        ),
                      );
                    },
                    child: const _MixChip(
                      subtitle: "JID, Baby Keem and 21 Savage",
                      image: 'Daily-Mix-1.jpg',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) {
                              var bloc = PlaylistBloc(locator.get());
                              bloc.add(
                                  PlaylistFetchEvent('Kendrick Lamar mix'));
                              return bloc;
                            },
                            child: const PlaylistSearchScreen(
                              cover: "Drake-Mix.jpg",
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Column(
                      children: [
                        CircleAvatar(
                          radius: 75,
                          backgroundImage:
                              AssetImage("images/artists/Kendrick-Lamar.jpg"),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Kendrick Lamar",
                          style: TextStyle(
                            fontFamily: "AB",
                            fontSize: 12,
                            color: MyColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) {
                              var bloc = PlaylistBloc(locator.get());
                              bloc.add(PlaylistFetchEvent('Travis Scott mix'));
                              return bloc;
                            },
                            child: const PlaylistSearchScreen(
                              cover: "UTOPIA.jpg",
                            ),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 153,
                          width: 153,
                          child: Image.asset("images/home/UTOPIA.jpg"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "UTOPIA",
                              style: TextStyle(
                                fontFamily: "AB",
                                fontSize: 12,
                                color: MyColors.whiteColor,
                              ),
                            ),
                            Text(
                              "Album . Travis Scott",
                              style: TextStyle(
                                fontFamily: "AM",
                                fontSize: 12.5,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 153,
                          width: 153,
                          child:
                              Image.asset("images/home/For-All-The-Dogs.jpg"),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "For All The Dogs",
                              style: TextStyle(
                                fontFamily: "AB",
                                fontSize: 12,
                                color: MyColors.whiteColor,
                              ),
                            ),
                            Text(
                              "Album . Drake",
                              style: TextStyle(
                                fontFamily: "AM",
                                fontSize: 12.5,
                                color: Color.fromARGB(255, 255, 255, 255),
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
          ],
        ),
      ),
    );
  }
}

class _TopMixes extends StatelessWidget {
  const _TopMixes();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your top mixes",
              style: TextStyle(
                fontFamily: "AB",
                color: MyColors.whiteColor,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 199,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) {
                              var bloc = PlaylistBloc(locator.get());
                              bloc.add(PlaylistFetchEvent('2010'));
                              return bloc;
                            },
                            child: const PlaylistSearchScreen(
                              cover: "2010s-mix.png",
                            ),
                          ),
                        ),
                      );
                    },
                    child: const _MixChip(
                      subtitle: "Travis Scott, Soul Chef, Kanye West and more",
                      image: "2010s-mix.png",
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) {
                              var bloc = PlaylistBloc(locator.get());
                              bloc.add(PlaylistFetchEvent("Chill"));
                              return bloc;
                            },
                            child: const PlaylistSearchScreen(
                                cover: "chill-mix.png"),
                          ),
                        ),
                      );
                    },
                    child: const _MixChip(
                      subtitle: "Talyor Swift, The Beatles and more",
                      image: 'chill-mix.png',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) {
                              var bloc = PlaylistBloc(locator.get());
                              bloc.add(PlaylistFetchEvent("Upbeat"));
                              return bloc;
                            },
                            child: const PlaylistSearchScreen(
                              cover: "Upbeat-Mix.jpg",
                            ),
                          ),
                        ),
                      );
                    },
                    child: const _MixChip(
                      subtitle: "benny blanco, Darke and more",
                      image: 'Upbeat-Mix.jpg',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) {
                              var bloc = PlaylistBloc(locator.get());
                              bloc.add(PlaylistFetchEvent("baby keem"));
                              return bloc;
                            },
                            child: const PlaylistSearchScreen(
                              cover: "Offset-Mix.jpg",
                            ),
                          ),
                        ),
                      );
                    },
                    child: const _MixChip(
                      subtitle: "Baby keem, Travis Scott and Drake",
                      image: "Offset-Mix.jpg",
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
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
                              cover: "Drake-Mix.jpg",
                            ),
                          ),
                        ),
                      );
                    },
                    child: const _MixChip(
                      subtitle: "JID, Baby Keem and 21 Savage",
                      image: 'Drake-Mix.jpg',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  int? _selectedMinutes;
  int _endTime = DateTime.now().millisecondsSinceEpoch;
  bool _isTimerRunning = false;

  void onEnd() {
    setState(() {
      _isTimerRunning = false;
    });
    print('Timer ended');
    // Close the app
    SystemNavigator.pop();
  }

  void startTimer() {
    if (_selectedMinutes != null) {
      setState(() {
        _endTime = DateTime.now().millisecondsSinceEpoch +
            1000 * 60 * _selectedMinutes!;
        _isTimerRunning = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => editProfile()),
                        );
                      },
                      child:CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("images/myImage.png"),
                    ),
                    ),
                    
                    SizedBox(width: 12),
                    Text(
                      "Good evening",
                      style: TextStyle(
                        fontFamily: "AB",
                        color: MyColors.whiteColor,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 100,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: DropdownButton<int>(
                          isExpanded: true,
                          hint: Text(
                            'Select minutes',
                            style: TextStyle(
                                fontSize: 11, color: MyColors.whiteColor),
                          ),
                          value: _selectedMinutes,
                          onChanged: (int? newValue) {
                            setState(() {
                              _selectedMinutes = newValue;
                            });
                          },
                          items: <int>[1, 5, 10, 15, 30, 45, 60]
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text('$value minutes',
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  height: 35,
                  decoration: const BoxDecoration(
                    color: MyColors.darGreyColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(145),
                    ),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Music",
                        style: TextStyle(
                          fontFamily: "AM",
                          fontSize: 14,
                          color: MyColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 80,
                  height: 35,
                  child: ElevatedButton(
                    onPressed: startTimer,
                    child: Text(
                      'Start Timer',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (_isTimerRunning)
                  CountdownTimer(
                    endTime: _endTime,
                    onEnd: onEnd,
                    widgetBuilder: (_, CurrentRemainingTime? time) {
                      if (time == null) {
                        return Text('Timer Ended');
                      }
                      return Text(
                        'Time left: ${time.min ?? 0} min : ${time.sec ?? 0} sec',
                        style: TextStyle(fontSize: 14,color: Colors.white
                        ),
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) {
                                var bloc = PlaylistBloc(locator.get());
                                bloc.add(PlaylistFetchEvent("liked song"));
                                return bloc;
                              },
                              child: const PlaylistSearchScreen(
                                cover: "chill-mix.png",
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 55,
                        width: (MediaQuery.of(context).size.width / 1.77) - 45,
                        decoration: const BoxDecoration(
                          color: MyColors.darGreyColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Row(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                  height: 55,
                                  width: 55,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "images/liked_songs.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  'images/icon_heart_white.png',
                                  height: 20,
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Liked Songs",
                              style: TextStyle(
                                fontFamily: "AB",
                                fontSize: 12,
                                color: MyColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) {
                                var bloc = PlaylistBloc(locator.get());
                                bloc.add(PlaylistFetchEvent("JID mix"));
                                return bloc;
                              },
                              child: const PlaylistSearchScreen(
                                cover: "JID.jpg",
                              ),
                            ),
                          ),
                        );
                      },
                      child: const _RecentPlaysChip(
                        image: "artists/JID.jpg",
                        title: "JID",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) {
                                var bloc = PlaylistBloc(locator.get());
                                bloc.add(PlaylistFetchEvent("21 Savage mix"));
                                return bloc;
                              },
                              child: const PlaylistSearchScreen(
                                cover: "american-dream.jpg",
                              ),
                            ),
                          ),
                        );
                      },
                      child: const _RecentPlaysChip(
                        image: "home/american-dream.jpg",
                        title: "american dream",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) {
                                var bloc = PlaylistBloc(locator.get());
                                bloc.add(
                                    PlaylistFetchEvent("Travis Scott mix"));
                                return bloc;
                              },
                              child: const PlaylistSearchScreen(
                                cover: "UTOPIA.jpg",
                              ),
                            ),
                          ),
                        );
                      },
                      child: const _RecentPlaysChip(
                        image: "home/UTOPIA.jpg",
                        title: "UTOPIA",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) {
                                var bloc = PlaylistBloc(locator.get());
                                bloc.add(PlaylistFetchEvent("Upbeat"));
                                return bloc;
                              },
                              child: const PlaylistSearchScreen(
                                cover: "Upbeat-Mix.jpg",
                              ),
                            ),
                          ),
                        );
                      },
                      child: const _RecentPlaysChip(
                        image: "home/Upbeat-Mix.jpg",
                        title: "Upbeat Mix",
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) {
                                var bloc = PlaylistBloc(locator.get());
                                bloc.add(PlaylistFetchEvent("Drake mix"));
                                return bloc;
                              },
                              child: const PlaylistSearchScreen(
                                cover: "Daily-Mix-1.jpg",
                              ),
                            ),
                          ),
                        );
                      },
                      child: const _RecentPlaysChip(
                        image: "home/Daily-Mix-1.jpg",
                        title: "Daily Mix",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentPlaysChip extends StatelessWidget {
  const _RecentPlaysChip({required this.image, required this.title});
  final String title;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: (MediaQuery.of(context).size.width / 1.77) - 45,
      decoration: const BoxDecoration(
        color: MyColors.darGreyColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
              image: DecorationImage(
                image: AssetImage(
                  "images/$image",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          AutoSizeText(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontFamily: "AB",
            ),
          )
        ],
      ),
    );
  }
}

class _MixChip extends StatelessWidget {
  const _MixChip({required this.subtitle, required this.image});
  final String subtitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 153,
          width: 153,
          child: Image.asset("images/home/$image"),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 150,
          child: Text(
            subtitle,
            style: const TextStyle(
              fontFamily: "AM",
              fontSize: 12.5,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
