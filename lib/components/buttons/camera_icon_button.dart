import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';

class CameraIconButton extends StatelessWidget {
  const CameraIconButton({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 16,
        backgroundColor: AppColors.whiteColor,
        child: Icon(Icons.camera_alt, color: AppColors.primaryColor),
      ),
    );
  }
}
