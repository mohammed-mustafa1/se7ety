import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class TopCard extends StatelessWidget {
  const TopCard({
    super.key,
    required this.name,
    required this.value,
    required this.backgroundColor,
    required this.icon,
  });
  final String name;
  final String value;
  final Color backgroundColor;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(minHeight: 100, maxHeight: 150),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor.withValues(alpha: 0.8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Icon(icon, color: AppColors.whiteColor, size: 36),
            Text(
              textAlign: TextAlign.center,
              name,
              style: TextStyles.getSmall(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              value,
              style: TextStyles.getTitle(
                fontWeight: FontWeight.bold,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
