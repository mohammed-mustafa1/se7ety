import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class OnBoardingPageViewItem extends StatelessWidget {
  const OnBoardingPageViewItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
  });
  final String title, subTitle, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Spacer(),
        SvgPicture.asset(image, width: 250),
        Spacer(),
        Text(
          title,
          style: TextStyles.getHeadLine1(color: AppColors.primaryColor),
        ),
        Gap(16),
        Text(
          subTitle,
          style: TextStyles.getBody(),
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
