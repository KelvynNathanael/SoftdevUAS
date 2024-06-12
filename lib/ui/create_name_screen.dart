import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/DI/service_locator.dart';
import 'package:mobile/bloc/artist/artist_bloc.dart';
import 'package:mobile/bloc/artist/artist_event.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/ui/choose_artist_screen.dart';
import 'package:mobile/ui/create_password_screen.dart';

class CreateNameScreen extends StatefulWidget {
  const CreateNameScreen({super.key});

  @override
  State<CreateNameScreen> createState() => _CreateNameScreenState();
}

class _CreateNameScreenState extends State<CreateNameScreen> {
  bool newsCheck = false;
  bool marketPurposeCheck = false;
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color.fromRGBO(119, 18, 18, 1), // Dark red
                const Color.fromRGBO(49, 12, 12, 1), // Darker red
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const _Header(),
                  const Row(
                    children: [
                      SizedBox(width: 3),
                      Text(
                        "What's your name?",
                        style: TextStyle(
                          fontFamily: "AB",
                          fontSize: 20,
                          color: MyColors.whiteColor,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Container(
                    height: 51,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 143, 139, 139),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  text = value;
                                });
                              },
                              style: const TextStyle(
                                fontFamily: "AM",
                                fontSize: 14,
                                color: MyColors.whiteColor,
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    style: BorderStyle.none,
                                    width: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (text.length > 6) ? true : false,
                            child: Image.asset("images/icon_tic.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (text.length > 6) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) {
                                  var bloc = ArtistBloc(locator.get());
                                  bloc.add(ArtistListEvent());
                                  return bloc;
                                },
                                child: const CreatePasswordScreen(),
                              ),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: Container(
                          height: 42,
                          width: 179,
                          decoration: BoxDecoration(
                            color: (text.length > 6)
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : const Color.fromARGB(255, 0, 0, 0),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Create an account",
                              style: TextStyle(
                                fontFamily: "AB",
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35, top: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.blackColor,
              ),
              child: Center(
                child: Image.asset(
                  "images/icon_arrow_left.png",
                  height: 16,
                  width: 16,
                ),
              ),
            ),
          ),
          const Text(
            "Create Account",
            style: TextStyle(
              fontFamily: "AB",
              fontSize: 16,
              color: MyColors.whiteColor,
            ),
          ),
          const SizedBox(
            height: 32,
            width: 32,
          ),
        ],
      ),
    );
  }
}
