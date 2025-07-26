import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    this.maxLines,
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
  final int? maxLines;
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
      maxLines: maxLines ?? 1,
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
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        hintText: hintText,
        filled: true,
        hintMaxLines: 3,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
