import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class MainTextFormField extends StatelessWidget {
  const MainTextFormField({
    super.key,
    required this.hintText,
    this.obscureText,
    this.validator,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.prefixIcon,
    this.texAlign,
    this.maxline,
    this.readOnly,
    this.onTap,
    this.suffixIcon,
    this.maxLength,
  });
  final String hintText;
  final bool? obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon;
  final TextAlign? texAlign;
  final int? maxline;
  final bool? readOnly;
  final void Function()? onTap;
  final Widget? suffixIcon;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      onTap: onTap,
      readOnly: readOnly ?? false,
      maxLines: maxline ?? 1,
      textAlign: texAlign ?? TextAlign.start,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      obscureText: obscureText ?? false,
      style: TextStyles.getSmall(fontSize: 15),
      decoration: InputDecoration(
        prefixIcon:
            prefixIcon != null
                ? Icon(prefixIcon, color: AppColors.primaryColor)
                : null,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(24),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(24),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(24),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(24),
        ),
        errorMaxLines: 4,
        hintText: hintText,
        filled: true,
        fillColor:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkColor.withValues(alpha: 3)
                : AppColors.accentColor,
        contentPadding: EdgeInsets.all(16),
        hintMaxLines: 3,
        hintStyle: TextStyles.getSmall(color: AppColors.grayColor),
        suffixIconConstraints: BoxConstraints(minHeight: 22, minWidth: 22),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
