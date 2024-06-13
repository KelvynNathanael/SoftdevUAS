import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/ui/dashboard_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email = "";
  String name = "";
  String password= "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(119, 18, 18, 1), // Dark red
              Color.fromRGBO(49, 12, 12, 1), // Darker red
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const _Header(),
                  const SizedBox(height: 35),
                  _buildEmailInput(),
                  const SizedBox(height: 35),
                  _buildNameInput(),
                  const SizedBox(height: 35),
                  _buildPasswordInput(),
                  const SizedBox(height: 300),
                  _buildNextButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What's your email?",
          style: TextStyle(
            fontFamily: "AB",
            fontSize: 20,
            color: MyColors.whiteColor,
          ),
          textAlign: TextAlign.start,
        ),
        Container(
          height: 51,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 134, 133, 133),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            style: const TextStyle(
              fontFamily: "AM",
              fontSize: 14,
              color: MyColors.whiteColor,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50), 
      child: GestureDetector(
        onTap: () {
          if (email.length >= 6 && password.length >= 6 && name.length >= 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DashBoardScreen(),
              ),
            );
          }
        },
        child: Container(
          height: 45,
          width: 90,
          decoration: BoxDecoration(
            color: (email.length >= 6)
                ? const Color.fromARGB(255, 0, 0, 0)
                : const Color.fromARGB(255, 0, 0, 0),
            borderRadius: const BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: const Center(
            child: Text(
              "Next",
              style: TextStyle(
                fontFamily: "AB",
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What's your name?",
          style: TextStyle(
            fontFamily: "AB",
            fontSize: 20,
            color: MyColors.whiteColor,
          ),
          textAlign: TextAlign.start,
        ),
        Container(
          height: 51,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 143, 139, 139),
            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                        name = value;
                      });
                    },
                    style: const TextStyle(
                      fontFamily: "AM",
                      fontSize: 14,
                      color: MyColors.whiteColor,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: name.length > 0,
                  child: Image.asset("images/icon_tic.png"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What's your password?",
          style: TextStyle(
            fontFamily: "AB",
            fontSize: 20,
            color: MyColors.whiteColor,
          ),
          textAlign: TextAlign.start,
        ),
        Container(
          height: 51,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 143, 139, 139),
            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                        password = value; // Update this to handle password instead
                      });
                    },
                    style: const TextStyle(
                      fontFamily: "AM",
                      fontSize: 14,
                      color: MyColors.whiteColor,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: password.length > 6, // Update this to handle password visibility logic
                  child: Image.asset("images/icon_tic.png"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
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
