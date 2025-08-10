import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class EmptyUI extends StatelessWidget {
  const EmptyUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: SvgPicture.asset(AppAssets.noScheduled, height: 250)),
          Text('لا يوجد حجوزات قادمه', style: TextStyles.getBody()),
        ],
      ),
    );
  }
}
