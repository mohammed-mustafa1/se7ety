import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/services/shared_prefs.dart';
import 'package:se7ety/features/auth/data/models/user_enum.dart';

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
        checkUserDataCompleted();
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

  Future<void> checkUserDataCompleted() async {
    bool isCompleted = await SharedPrefs.isDataCompleted();
    if (isCompleted) {
      context.pushToBase(AppRouter.mainScreen);
    } else {
      if (SharedPrefs.getUserType().isNotEmpty) {
        SharedPrefs.getUserType() == UserType.doctor.name
            ? context.pushTo(AppRouter.doctorRegister)
            : context.pushTo(AppRouter.patientRegister);
      } else {
        context.pushToBase(AppRouter.welcome);
      }
    }
  }
}
