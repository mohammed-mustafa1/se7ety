import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/extensions/media_query.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/user_enum.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.orientationOf(context);
    var isLandscape = orientation == Orientation.landscape;
    double height = context.height;
    double width = context.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.welcomeBg, fit: BoxFit.cover),
          ),
          Positioned(
            top: isLandscape ? height * 0.15 : height * 0.15,
            right: isLandscape ? 0 : null,
            child: Center(child: WelcomeBox()),
          ),
          Positioned(
            left: 0,
            top: isLandscape ? height * 0.15 : null,
            right: isLandscape ? width * 0.50 : 0,
            bottom: isLandscape ? null : height * 0.15,
            child: Center(child: ButtonsBox()),
          ),
        ],
      ),
    );
  }
}

class WelcomeBox extends StatelessWidget {
  const WelcomeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اهلا بيك',
            style: TextStyles.getHeadLine1(
              color: AppColors.primaryColor,
              fontSize: 32,
            ),
          ),
          Gap(20),
          Text('سجل واحجز عند دكتورك وانت فالبيت', style: TextStyles.getBody()),
        ],
      ),
    );
  }
}

class ButtonsBox extends StatelessWidget {
  const ButtonsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      width: context.width,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withAlpha(160),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'سجل دلوقتي كـ',
            style: TextStyles.getHeadLine2(color: AppColors.accentColor),
          ),
          Gap(40),
          MainButton(
            radius: 24,
            height: 60,
            text: 'دكتور',
            backgroundColor: AppColors.accentColor.withAlpha(200),
            textColor: AppColors.darkColor,
            fontWeight: FontWeight.bold,
            onTap: () {
              context.pushTo(AppRouter.register, extra: UserType.doctor);
            },
          ),
          Gap(16),
          MainButton(
            height: 60,
            radius: 20,
            backgroundColor: AppColors.accentColor.withAlpha(200),
            text: 'مريض',
            textColor: AppColors.darkColor,
            fontWeight: FontWeight.bold,
            onTap: () {
              context.pushTo(AppRouter.register, extra: UserType.patient);
            },
          ),
        ],
      ),
    );
  }
}
