import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.onTap,
    required this.text,
    this.textColor,
    this.backgroundColor,
    this.borderColor,
    this.height,
    this.width,
    this.fontWeight,
    this.radius,
    this.textsize,
  });

  final void Function() onTap;
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final FontWeight? fontWeight;
  final double? radius;
  final double? textsize;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(radius ?? 8),
          border:
              borderColor != null
                  ? Border.all(color: borderColor ?? AppColors.darkColor)
                  : null,
        ),
        child: Text(
          text,
          style: TextStyles.getBody(
            color: textColor ?? AppColors.whiteColor,
            fontWeight: fontWeight,
            fontSize: textsize,
          ),
        ),
      ),
    );
  }
}
