import 'package:flutter/material.dart';
import 'package:mobile/ui/signup_screen.dart';

class Agreement extends StatefulWidget {
  const Agreement({super.key});

  @override
  State<Agreement> createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  bool licenseAgreementCheck = false;
  bool termsOfUseCheck = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(119, 18, 18, 1), // Dark red
            Color.fromRGBO(49, 12, 12, 1), // Darker red
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor:
            Colors.transparent, // Make scaffold background transparent
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _Header(),
                const SizedBox(height: 8),
                const Text(
                  'Agreement',
                  style: TextStyle(
                    fontFamily: "AM",
                    fontSize: 30,
                    color: Color(0xffFFFFFF),
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 25),
                const Text(
                  'By tapping on "Create account" you agree to the following terms:',
                  style: TextStyle(
                    fontFamily: "AM",
                    fontSize: 12,
                    color: Color(0xffFFFFFF),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  '1. You agree to the Devil Music Terms of Use, which include our policies on content usage, copyright protection, and data privacy.',
                  style: TextStyle(
                    fontFamily: "AM",
                    fontSize: 12,
                    color: Color(0xffFFFFFF),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  '2. You acknowledge that all content within the Devil Music app is protected by copyright and agree not to infringe upon these rights.',
                  style: TextStyle(
                    fontFamily: "AM",
                    fontSize: 12,
                    color: Color(0xffFFFFFF),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "I accept the license agreement.",
                        style: TextStyle(
                          fontFamily: "AM",
                          fontSize: 12,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        shape: const CircleBorder(),
                        activeColor: Color.fromARGB(255, 152, 23, 23),
                        checkColor: Color(0xffFFFFFF),
                        value: licenseAgreementCheck,
                        onChanged: (onChanged) {
                          setState(() {
                            licenseAgreementCheck = onChanged!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "I accept the Devil Music Terms of Use.",
                        style: TextStyle(
                          fontFamily: "AM",
                          fontSize: 12,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Checkbox(
                        shape: const CircleBorder(),
                        activeColor: Color.fromARGB(255, 167, 28, 28),
                        checkColor: Color(0xffFFFFFF),
                        value: termsOfUseCheck,
                        onChanged: (onChanged) {
                          setState(() {
                            termsOfUseCheck = onChanged!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 147, 8, 8),
                    ),
                    onPressed: () {
                      if (licenseAgreementCheck && termsOfUseCheck) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Agreement Required'),
                              content: const Text(
                                  'You must accept the license agreement and the terms of use to create an account.'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text("Create account"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                color: Color.fromARGB(255, 10, 10, 10),
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
            "Agreement",
            style: TextStyle(
              fontFamily: "AB",
              fontSize: 16,
              color: Color(0xffFFFFFF),
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
