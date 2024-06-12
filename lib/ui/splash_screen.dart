import 'package:flutter/material.dart';
import 'package:mobile/ui/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnBoardingScreen(),
          ),
        );
      },
    );
    super.initState();
  }

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
        // Center the image within the gradient container
        child: Center(
          child: Image.asset(
            'images/Logo1.png',
            height: 200,
            width: 200,
          ),
        ),
      ),
    );
  }
}
