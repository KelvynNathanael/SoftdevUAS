import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/ui/profile_screen.dart';
import 'package:mobile/widgets/bottom_player.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Hilangkan backgroundColor dari Scaffold
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(119, 18, 18, 1),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 65,
        title: const Text(
          "Settings",
          style: TextStyle(
            fontFamily: "AB",
            fontSize: 16,
            color: MyColors.whiteColor,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset("images/icon_arrow_left.png"),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(119, 18, 18, 1),
              Color.fromRGBO(49, 12, 12, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomScrollView(
                slivers: [
                  _ProfileSection(),
                  _SettingsOptionChip(title: "Account"),
                  _SettingsOptionChip(title: "Data Saver"),
                  _SettingsOptionChip(title: "Languages"),
                  _SettingsOptionChip(title: "Playback"),
                  _SettingsOptionChip(title: "Explicit Content"),
                  _SettingsOptionChip(title: "Devices"),
                  _SettingsOptionChip(title: "Car"),
                  _SettingsOptionChip(title: "Social"),
                  _SettingsOptionChip(title: "Voice Assistant & Apps"),
                  _SettingsOptionChip(title: "Audio Quality"),
                  _SettingsOptionChip(title: "Storage"),
                ],
              ),
            ),
            BottomPlayer(),
          ],
        ),
      ),
    );
  }
}

class _SettingsOptionChip extends StatelessWidget {
  const _SettingsOptionChip({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: "AM",
                fontSize: 16,
                color: MyColors.whiteColor,
              ),
            ),
            Image.asset("images/icon_arrow_right.png"),
          ],
        ),
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  const _ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 45),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 27,
                      backgroundImage: AssetImage("images/myImage.png"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Mohammad",
                          style: TextStyle(
                            fontFamily: "AB",
                            fontSize: 18,
                            color: MyColors.whiteColor,
                          ),
                        ),
                        Text(
                          "View Profile",
                          style: TextStyle(
                            fontFamily: "AM",
                            fontSize: 13,
                            color: MyColors.lightGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Image.asset("images/icon_arrow_right.png"),
            ],
          ),
        ),
      ),
    );
  }
}
