import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/extensions/theme.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

enum DialogType { success, error }

showMainSnackBar(
  BuildContext context, {
  required String text,
  required DialogType type,
}) => ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    backgroundColor: type == DialogType.success ? Colors.green : Colors.red,
    content: Text(text),
  ),
);

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
showAlertDialog(
  BuildContext context, {
  required String text,
  required DialogType type,
  required void Function() onTap,
}) => showDialog(
  context: context,
  builder:
      (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: AppColors.accentColor,
          content: Text(text, textAlign: TextAlign.center),
          contentTextStyle: TextStyles.getTitle(
            color:
                context.brightness == Brightness.light
                    ? AppColors.darkColor
                    : AppColors.whiteColor,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            MainButton(height: 40, width: 100, onTap: onTap, text: 'حسناً'),
          ],
        ),
      ),
);
