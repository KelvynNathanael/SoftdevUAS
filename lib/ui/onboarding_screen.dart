import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/ui/create_email_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the gradient background for the entire Scaffold
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
        // Center all content within the gradient container
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "images/Logo1.png",
                  height: 300.0,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Millions of songs.",
                  style: TextStyle(
                    fontFamily: "AB",
                    fontSize: 28,
                    color: MyColors.whiteColor,
                  ),
                ),
                const Text(
                  "Chat In Community",
                  style: TextStyle(
                    fontFamily: "AB",
                    fontSize: 28,
                    color: MyColors.whiteColor,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const _ActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width, 49),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              backgroundColor: const Color.fromARGB(255, 252, 252, 252),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateEmailScreen(),
                ),
              );
            },
            child: const Text(
              "ُSign up free",
              style: TextStyle(
                fontFamily: "AB",
                fontSize: 16,
                color: MyColors.blackColor,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          OutlinedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width, 49),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              side: const BorderSide(
                width: 1,
                color: MyColors.lightGrey,
              ),
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("images/icon_google.png"),
                const Text(
                  "Continiue with google",
                  style: TextStyle(
                    fontFamily: "AB",
                    fontSize: 16,
                    color: MyColors.whiteColor,
                  ),
                ),
                const SizedBox(
                  height: 18,
                  width: 18,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          OutlinedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width, 49),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              side: const BorderSide(
                width: 1,
                color: MyColors.lightGrey,
              ),
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("images/icon_facebook.png"),
                const Text(
                  "Continiue with Facebook",
                  style: TextStyle(
                    fontFamily: "AB",
                    fontSize: 16,
                    color: MyColors.whiteColor,
                  ),
                ),
                const SizedBox(
                  height: 18,
                  width: 18,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          OutlinedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width, 49),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              side: const BorderSide(
                width: 1,
                color: MyColors.lightGrey,
              ),
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("images/icon_apple.png"),
                const Text(
                  "Continiue with Apple",
                  style: TextStyle(
                    fontFamily: "AB",
                    fontSize: 16,
                    color: MyColors.whiteColor,
                  ),
                ),
                const SizedBox(
                  height: 18,
                  width: 18,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Log in",
            style: TextStyle(
              fontFamily: "AB",
              fontSize: 16,
              color: MyColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
