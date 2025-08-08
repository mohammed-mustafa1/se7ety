import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/buttons/main_text_button.dart';
import 'package:se7ety/components/inputs/main_text_form_field.dart';
import 'package:se7ety/components/dialogs/main_dialog.dart';
import 'package:se7ety/core/constants/app_assets.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/extensions/validation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/services/shared_prefs.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/user_enum.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.userType});
  final UserType userType;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showLoadingDialog(context);
        } else if (state is AuthError) {
          context.pop();
          showMainSnackBar(
            context,
            text: state.errorMessage,
            type: DialogType.error,
          );
        } else if (state is AuthSuccess) {
          context.pop();
          SharedPrefs.isDataCompleted().then((isCompleted) {
            if (isCompleted) {
              context.pushToBase(AppRouter.mainScreen);
            } else {
              widget.userType == UserType.doctor
                  ? context.pushToBase(AppRouter.doctorRegister)
                  : context.pushToBase(AppRouter.patientRegister);
            }
          });
        }
      },
      builder: (context, state) {
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
                        controller: _nameController,
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
                        hintText: 'الاسم',
                        prefixIcon: Icons.person,
                      ),
                      Gap(24),
                      MainTextFormField(
                        controller: _emailController,
                        texAlign: TextAlign.end,
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
                        hintText: 'Email@Example.com',
                        prefixIcon: Icons.email,
                      ),
                      Gap(24),
                      MainTextFormField(
                        controller: _passwordController,
                        texAlign: TextAlign.end,
                        validator: (value) {
                          if (value!.replaceAll(' ', '').isEmpty) {
                            return 'ادخل كلمة المرور';
                          } else if (value.replaceAll(' ', '').length < 6) {
                            return 'كلمة المرور يجب ان تكون اكثر من 6 حروف';
                          }
                          return null;
                        },
                        hintText: '**********',
                        textInputAction: TextInputAction.done,
                        prefixIcon: Icons.lock,
                        obscureText: showPassword,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Gap(24),
                      MainButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().register(
                              name: _nameController.text.toLowerCase(),
                              userType: widget.userType,
                              emailAddress: _emailController.text,
                              password: _passwordController.text,
                            );
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
      },
    );
  }
}
