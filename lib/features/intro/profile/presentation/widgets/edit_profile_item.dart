import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class EditProfileItem extends StatelessWidget {
  const EditProfileItem({
    super.key,
    this.onTap,
    required this.title,
    required this.subtitle,
  });
  final void Function()? onTap;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.accentColor,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: AppColors.accentColor.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: Offset(5, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(title, style: TextStyles.getBody(fontWeight: FontWeight.bold)),
            Spacer(),
            Text(subtitle, style: TextStyles.getBody()),
          ],
        ),
      ),
    );
  }
}
