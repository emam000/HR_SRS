import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hr_srs/features/auth/view/sign_in_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedSplashScreen(
        backgroundColor: Colors.black,
        splash: "assets/logo.png",
        splashIconSize: 300,
        nextScreen: SignInView(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 3000,
      ),
    );
  }
}
