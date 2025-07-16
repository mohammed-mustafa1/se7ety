import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AppAssets.logo, width: 250)),
    );
  }
}
