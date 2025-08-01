import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/user_enum.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AppAssets.welcomeBg),
          ),
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              'اهلا بيك',
              style: TextStyles.getHeadLine1(
                color: AppColors.primaryColor,
                fontSize: 32,
              ),
            ),
            Gap(20),
            Text(
              'سجل واحجز عند دكتورك وانت فالبيت',
              style: TextStyles.getBody(),
            ),
            Spacer(flex: 3),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withAlpha(160),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'سجل دلوقتي كـ',
                      style: TextStyles.getHeadLine2(
                        color: AppColors.accentColor,
                      ),
                    ),
                    Gap(40),
                    MainButton(
                      radius: 24,
                      height: 70,
                      text: 'دكتور',
                      backgroundColor: AppColors.accentColor.withAlpha(200),
                      textColor: AppColors.darkColor,
                      fontWeight: FontWeight.bold,
                      onTap: () {
                        context.pushTo(
                          AppRouter.register,
                          extra: UserType.doctor,
                        );
                      },
                    ),
                    Gap(16),
                    MainButton(
                      height: 70,
                      radius: 20,
                      backgroundColor: AppColors.accentColor.withAlpha(200),
                      text: 'مريض',
                      textColor: AppColors.darkColor,
                      fontWeight: FontWeight.bold,
                      onTap: () {
                        context.pushTo(
                          AppRouter.register,
                          extra: UserType.patient,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
