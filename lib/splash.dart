import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:whatsapp_live_caption/Authentication/signup.dart';
class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset(
            'Splash1.json'
        ),

      ),
      // nextScreen:  MyIntro(),
      nextScreen: Login(),
      // duration: 3000,
      backgroundColor: Colors.black54,
      splashIconSize: 500,
    );
  }
}
