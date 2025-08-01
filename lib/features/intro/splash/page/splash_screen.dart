import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/services/shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bool isLogedIn = SharedPrefs.getUserID().isNotEmpty;
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (isLogedIn) {
        context.pushToReplace(AppRouter.mainScreen);
      } else {
        SharedPrefs.isOnBoardingView
            ? context.pushToReplace(AppRouter.onBoarding)
            : context.pushToReplace(AppRouter.welcome);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AppAssets.logo, width: 250)),
    );
  }
}
