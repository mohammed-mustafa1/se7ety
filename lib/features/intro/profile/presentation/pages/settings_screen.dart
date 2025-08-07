import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/dialogs/main_dialog.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/services/shared_prefs.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/intro/profile/presentation/widgets/setting_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الاعدادات', style: TextStyles.getTitle())),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 16,
                  children: [
                    SettingItem(
                      text: 'اعدادات الحساب',
                      icon: Icons.person,
                      onTap: () {
                        context.pushTo(AppRouter.editProfile);
                      },
                    ),
                    SettingItem(text: 'كلمة السر', icon: Icons.security),
                    SettingItem(
                      text: 'اعدادات الاشعارات',
                      icon: Icons.notifications_active,
                    ),
                    SettingItem(text: 'الخصوصية', icon: Icons.privacy_tip),
                    SettingItem(text: 'المساعدة والدعم', icon: Icons.help),
                    SettingItem(
                      text: 'دعوة صديق',
                      icon: Icons.person_add_alt_1,
                    ),
                  ],
                ),
              ),
            ),
            Gap(16),
            MainButton(
              height: 60,
              onTap: () async {
                showLoadingDialog(context);
                await FirebaseAuth.instance.signOut();
                await SharedPrefs.clearAllData().then(
                  (value) => context.pushToBase(AppRouter.welcome),
                );
              },
              text: 'تسجيل الخروج',
              fontWeight: FontWeight.bold,
              backgroundColor: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
