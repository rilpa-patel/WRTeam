import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wrteam/Screens/onboarding_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'WRTeam',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            LoadingAnimationWidget.twistingDots(
              leftDotColor: const Color.fromARGB(255, 188, 215, 119),
              rightDotColor: const Color.fromARGB(255, 55, 106, 234),
              size: 50,
            )
          ],
        ),
      ),
    );
  }
}
