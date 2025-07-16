import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class MainTextFormField extends StatefulWidget {
  const MainTextFormField({
    super.key,
    required this.text,
    this.obscureText,
    this.validator,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
  });
  final String text;
  final bool? obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  @override
  State<MainTextFormField> createState() => _MainTextFormFieldState();
}

class _MainTextFormFieldState extends State<MainTextFormField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.validator,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      obscureText: obscureText,
      style: TextStyles.getSmall(fontSize: 15),
      decoration: InputDecoration(
        errorMaxLines: 4,
        hintText: widget.text,
        filled: true,
        fillColor:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkColor
                : AppColors.accentColor,
        contentPadding: EdgeInsets.all(16),
        hintStyle: TextStyles.getSmall(
          fontSize: 15,
          color: AppColors.grayColor,
        ),
        suffixIconConstraints: BoxConstraints(minHeight: 22, minWidth: 22),
        suffixIcon:
            widget.obscureText == true
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => obscureText = !obscureText);
                    },
                    // child: SvgPicture.asset(AppAssets.fluentEyeSvg),
                  ),
                )
                : null,
      ),
    );
  }
}
