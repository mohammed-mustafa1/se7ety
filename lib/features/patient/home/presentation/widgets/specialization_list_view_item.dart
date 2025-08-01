import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class SpecializationListViewItem extends StatelessWidget {
  const SpecializationListViewItem({
    super.key,
    required this.backgroundColor,
    required this.text,
  });
  final Color backgroundColor;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 220,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 6, color: backgroundColor)],
        borderRadius: BorderRadius.circular(24),
        color: backgroundColor,
      ),
      child: Stack(
        children: [
          Positioned(
            top: -16,
            right: -16,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.whiteColor.withValues(alpha: .3),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  height: 140,
                  AppAssets.doctorCard,
                  fit: BoxFit.scaleDown,
                ),
                Text(
                  text,
                  style: TextStyles.getSmall(
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor,
                  ),
                ),
                Gap(16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
