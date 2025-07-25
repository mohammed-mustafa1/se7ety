import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';

class MainDropdownButtonFormField extends StatelessWidget {
  const MainDropdownButtonFormField({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.validator,
  });

  final String? value;
  final Function(String? value) onChanged;
  final List<DropdownMenuItem<String>> items;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: validator,
      decoration: InputDecoration(
        errorMaxLines: 2,
        filled: true,
        fillColor:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkColor.withValues(alpha: 3)
                : AppColors.accentColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
      ),
      dropdownColor:
          Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkColor.withValues(alpha: 3)
              : AppColors.accentColor,
      borderRadius: BorderRadius.circular(24),
      hint: Text('اختر من التخصصات المتاحة'),
      isExpanded: true,
      icon: Icon(
        Icons.expand_circle_down_outlined,
        color: AppColors.primaryColor,
      ),
      iconEnabledColor: AppColors.primaryColor,
      value: value,
      onChanged: (value) => onChanged(value),

      items: items,
    );
  }
}
