import 'package:flutter/material.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/ui/create_name_screen.dart';

class CreateEmailScreen extends StatefulWidget {
  const CreateEmailScreen({super.key});

  @override
  State<CreateEmailScreen> createState() => _CreateEmailScreenState();
}

class _CreateEmailScreenState extends State<CreateEmailScreen> {
  String text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const _Header(),
              const Row(
                children: [
                  SizedBox(width: 3),
                  Text(
                    "What's your email?",
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
                  color: Color.fromARGB(255, 134, 133, 133),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
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
              const SizedBox(
                height: 8,
              ),
              const Row(
                children: [
                  Text(
                    "You'll need to confirm this email later.",
                    style: TextStyle(
                      fontFamily: "AM",
                      fontSize: 10,
                      color: MyColors.whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              GestureDetector(
                onTap: () {
                  if (text.length >= 6) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateNameScreen(),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 45,
                  width: 90,
                  decoration: BoxDecoration(
                    color: (text.length >= 6)
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
