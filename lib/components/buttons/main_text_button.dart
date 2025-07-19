import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class MainTextButton extends StatelessWidget {
  const MainTextButton({
    super.key,
    required this.text,
    required this.clickableText,
    this.onTap,
  });
  final String text;
  final String clickableText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: TextStyles.getSmall(fontSize: 15)),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
          child: Text(
            clickableText,
            style: TextStyles.getSmall(
              fontSize: 16,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
