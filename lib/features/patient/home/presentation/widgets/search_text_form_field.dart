import 'package:flutter/material.dart';
import 'package:se7ety/components/inputs/main_text_form_field.dart';
import 'package:se7ety/core/utils/app_colors.dart';

class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({
    super.key,
    required this.onPressed,
    this.controller,
  });
  final void Function()? onPressed;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.grayColor.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: MainTextFormField(
        controller: controller,
        hintText: 'ابحث عن دكتور',
        suffixIcon: IconButton(
          color: AppColors.whiteColor,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          icon: Icon(Icons.search),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
