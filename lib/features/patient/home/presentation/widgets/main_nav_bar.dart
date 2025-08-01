import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class MainNavBar extends StatelessWidget {
  const MainNavBar({super.key, required this.selectedIndex, this.onTabChange});

  final int selectedIndex;
  final void Function(int)? onTabChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: AppColors.darkColor.withValues(alpha: 0.2),
          ),
        ],
      ),
      child: GNav(
        selectedIndex: selectedIndex,
        onTabChange: onTabChange,
        backgroundColor: AppColors.whiteColor,
        textStyle: TextStyles.getBody(color: AppColors.whiteColor),
        activeColor: AppColors.whiteColor,
        tabBackgroundColor: AppColors.primaryColor,
        tabBorderRadius: 20,
        iconSize: 22,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        tabs: [
          GButton(icon: Icons.home, text: 'الرئيسية'),
          GButton(icon: Icons.search, text: 'البحث'),
          GButton(icon: Icons.calendar_month_rounded, text: 'المواعيد'),
          GButton(icon: Icons.person, text: 'الحساب'),
        ],
      ),
    );
  }
}
