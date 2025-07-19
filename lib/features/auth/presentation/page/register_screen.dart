import 'dart:developer';

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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.userType});
  final UserType userType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                children: [
                  Image.asset(AppAssets.logo, width: 250),
                  Gap(8),
                  Text(
                    'سجل حساب جديد كـ"${widget.userType == UserType.doctor ? 'دكتور' : 'مريض'}"',
                    style: TextStyles.getTitle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(24),
                  MainTextFormField(
                    validator: (value) {
                      if (value!.replaceAll(' ', '').isEmpty) {
                        return 'ادخل الاسم';
                      } else if (value.replaceAll(' ', '').length < 3) {
                        return 'الاسم يجب ان يكون اكثر من 3 حروف';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    text: 'الاسم',
                    prefixIcon: Icons.person,
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
                    textInputAction: TextInputAction.next,
                    text: 'البريد الالكتروني',
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
                    text: 'كلمة المرور',
                    textInputAction: TextInputAction.done,
                    prefixIcon: Icons.lock,
                    obscureText: true,
                  ),
                  Gap(24),
                  MainButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        log('Success');
                      }
                    },
                    text: 'تسجيل حساب',
                    radius: 32,
                    fontWeight: FontWeight.bold,
                    textsize: 18,
                  ),
                  Gap(32),

                  MainTextButton(
                    clickableText: '  سجل دخول',
                    text: 'لدي حساب ؟',
                    onTap: () {
                      context.pushToReplace(
                        AppRouter.login,
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
