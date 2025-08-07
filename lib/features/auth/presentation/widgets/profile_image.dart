import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_assets.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.imageNetworkUrl,
    required this.imageFile,
  });

  final String imageNetworkUrl;
  final File imageFile;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ClipOval(
        child:
            imageFile.path.isNotEmpty
                ? Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(AppAssets.person, fit: BoxFit.cover);
                  },
                )
                : CachedNetworkImage(
                  imageUrl: imageNetworkUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return Image.asset(AppAssets.person, fit: BoxFit.cover);
                  },
                ),
      ),
    );
  }
}
