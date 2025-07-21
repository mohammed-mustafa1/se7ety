import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/constants/app_assets.dart';

showLoadingDialog(context) => showDialog(
  barrierDismissible: false,
  context: context,
  builder:
      (context) => PopScope(
        canPop: false,
        child: Center(
          child: SizedBox(
            width: 150,
            child: LottieBuilder.asset(
              AppAssets.loadingAnimation3,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
);
