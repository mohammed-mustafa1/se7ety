import 'dart:io';
import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_assets.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.imageFile});

  final File imageFile;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Image.asset(
          '',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(AppAssets.welcomeBg, fit: BoxFit.cover);
          },
        ),
      ),
    );
  }
}
