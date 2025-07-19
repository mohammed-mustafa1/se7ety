import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/buttons/main_text_button.dart';
import 'package:se7ety/components/inputs/main_text_form_field.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/extensions/validation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/user_enum.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.userType});
  final UserType userType;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset(AppAssets.logo, width: 250)),
                  Gap(8),
                  Center(
                    child: Text(
                      'سجل دخول الان كـ"${widget.userType == UserType.doctor ? 'دكتور' : 'مريض'}"',
                      style: TextStyles.getTitle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Gap(24),
                  MainTextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ' ادخل البريد الالكتروني';
                      } else if (!value.isValidEmail()) {
                        return 'ادخل بريد الكتروني صحيح';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    text: 'البريد الالكتروني',
                    textInputAction: TextInputAction.next,
                    prefixIcon: Icons.email,
                  ),
                  Gap(24),
                  MainTextFormField(
                    validator: (value) {
                      if (value!.replaceAll(' ', '').isEmpty) {
                        return 'ادخل كلمة المرور';
                      } else if (value.replaceAll(' ', '').length < 6) {
                        return 'كلمة المرور يجب ان تكون اكثر من 6 حروف';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    text: 'كلمة المرور',
                    prefixIcon: Icons.lock,
                    obscureText: true,
                  ),
                  Gap(12),
                  Text('نسيت كلمة السر ؟', style: TextStyles.getBody()),
                  Gap(24),
                  MainButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {}
                    },
                    text: 'تسجيل الدخول',
                    radius: 32,
                    fontWeight: FontWeight.bold,
                    textsize: 18,
                  ),
                  Gap(32),

                  MainTextButton(
                    clickableText: '  سجل الان',
                    text: 'ليس لدي حساب ؟',
                    onTap: () {
                      context.pushToReplace(
                        AppRouter.register,
                        extra: widget.userType,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
