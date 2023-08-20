import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth/auth_service.dart';
import 'auth/google_apple_signin_page.dart';
import 'map_view.dart';
import 'color_table.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            if (ref.watch(isSignedInProvider)) {
              return const MapView();
            } else {
              return const GoogleAppleSigninPage();
            }
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const double begin = 0.0;
            const double end = 1.0;
            final Animatable<double> tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));
            final Animation<double> doubleAnimation = animation.drive(tween);
            return FadeTransition(
              opacity: doubleAnimation,
              child: child,
            );
          },
          transitionDuration: const Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1.6, -0.1),
            end: Alignment(2.5, 1.3),
            stops: [0.2, 0.7],
            colors: [
              ColorTable.lightGradientBeginColor,
              ColorTable.lightGradientEndColor,
            ],
          ),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "フォトピン",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: ColorTable.primaryBlackColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "lib/assets/images/icon.png",
                  width: MediaQuery.of(context).size.width / 4,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: ColorTable.primaryBlackColor),
                  bottom: BorderSide(width: 1.0, color: ColorTable.primaryBlackColor),
                ),
              ),
              child: const Text(
                "撮影スポット共有アプリ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  height: 1.6,
                  letterSpacing: 3,
                  color: ColorTable.primaryBlackColor,
                ),
                // line-heightに対して上下中央に配置するため
                textHeightBehavior: TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
