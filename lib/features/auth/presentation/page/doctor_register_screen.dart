import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/components/buttons/camera_icon_button.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/dialogs/loading_dialog.dart';
import 'package:se7ety/components/inputs/main_dropdown_button_form_field.dart';
import 'package:se7ety/components/inputs/main_text_form_field.dart';
import 'package:se7ety/components/snack_bars/main_snack_bar.dart';
import 'package:se7ety/core/constants/specialization.dart';
import 'package:se7ety/core/extensions/theme.dart';
import 'package:se7ety/core/function/show_bottom_sheet.dart';
import 'package:se7ety/core/services/shared_prefs.dart';
import 'package:se7ety/core/services/upload_image.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/widgets/profile_image.dart';

class DoctorRegisterScreen extends StatefulWidget {
  const DoctorRegisterScreen({super.key});

  @override
  State<DoctorRegisterScreen> createState() => _DoctorRegisterScreenState();
}

class _DoctorRegisterScreenState extends State<DoctorRegisterScreen> {
  String? specialization;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController specializationController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController openHourController = TextEditingController();
  TextEditingController closeHourController = TextEditingController();
  TextEditingController phoneController1 = TextEditingController();
  TextEditingController phoneController2 = TextEditingController();
  TimeOfDay openTime = TimeOfDay.now();
  TimeOfDay closeTime = TimeOfDay.now();
  File imageFile = File('');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        title: Text(
          'إكمال عملية التسجيل',
          style: TextStyles.getTitle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            ProfileImage(imageFile: imageFile),
                            Positioned(
                              bottom: 0,
                              child: CameraIconButton(
                                onTap: () {
                                  showPickImageBottomSheet(
                                    context,
                                    onTapCamera: () {
                                      uploadImage(context, ImageSource.camera);
                                    },
                                    onTapGallery: () {
                                      uploadImage(context, ImageSource.gallery);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text('التخصص', style: TextStyles.getBody()),
                      MainDropdownButtonFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء اختيار التخصص';
                          }
                          return null;
                        },

                        items:
                            specializations.map((e) {
                              return DropdownMenuItem(value: e, child: Text(e));
                            }).toList(),
                        value: specialization,
                        onChanged: (value) {
                          specialization = value ?? specializations[0];
                          setState(() {});
                        },
                      ),
                      Text('نبذة تعريفية', style: TextStyles.getBody()),

                      MainTextFormField(
                        controller: bioController,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'من فضلك ادخل نبذة تعريفية'
                                    : null,
                        maxLines: 5,
                        hintText:
                            'سجل المعلومات الطبية مثل تعليمك الأكاديمي وخبراتك السابقة...',
                      ),

                      Divider(
                        indent: 16,
                        endIndent: 16,
                        thickness: 3,
                        color:
                            context.brightness == Brightness.dark
                                ? AppColors.darkColor.withValues(alpha: 6)
                                : AppColors.accentColor,
                      ),
                      Text('عنوان العيادة ', style: TextStyles.getBody()),
                      MainTextFormField(
                        controller: addressController,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'من فضلك ادخل عنوان العيادة'
                                    : null,
                        hintText: '5 شارع مصدق - الدقي - الجيزة',
                      ),
                      timeSelection(context),
                      Text('رقم الهاتف 1', style: TextStyles.getBody()),

                      MainTextFormField(
                        controller: phoneController1,
                        keyboardType: TextInputType.phone,
                        maxLength: 11,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل رقم الهاتف';
                          } else if (value.length < 11) {
                            return 'من فضلك ادخل رقم هاتف صحيح';
                          } else {
                            return null;
                          }
                        },
                        hintText: '+20XXXXXXXXXX',
                      ),
                      Text('رقم الهاتف 2 اختياري', style: TextStyles.getBody()),

                      MainTextFormField(
                        maxLength: 11,
                        controller: phoneController2,
                        keyboardType: TextInputType.phone,
                        hintText: '+20XXXXXXXXXX',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator:
                            phoneController2.text.isNotEmpty
                                ? (value) {
                                  if (value != null && value.length < 11) {
                                    return 'من فضلك ادخل رقم هاتف صحيح';
                                  } else {
                                    return null;
                                  }
                                }
                                : null,
                      ),
                    ],
                  ),
                ),
              ),
              Gap(22),
              MainButton(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    showLoadingDialog(context);
                    String imageUrl = await UploadImageService.uploadToImageKit(
                      imageFile,
                    );
                    await context
                        .read<AuthCubit>()
                        .registerDoctorData(
                          doctorModel: DoctorModel(
                            userId: SharedPrefs.getUserID(),
                            address: addressController.text,
                            phone1: phoneController1.text,
                            phone2: phoneController2.text,
                            specialization: specialization,
                            bio: bioController.text,
                            openHour: openHourController.text,
                            closeHour: closeHourController.text,
                            image: imageUrl,
                          ),
                        )
                        .then((value) {
                          context.pop();
                          showMainSnackBar(
                            context,
                            text: 'تمت عملية التسجيل بنجاح',
                            type: SnackBarType.success,
                          );
                        });
                  }
                },
                text: 'التسجيل',
                fontWeight: FontWeight.bold,
                radius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row timeSelection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ساعات العمل من', style: TextStyles.getBody()),
              MainTextFormField(
                controller: openHourController,
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    if (value != null) {
                      openHourController.text = value.format(context);
                      openTime = value;
                    }
                    setState(() {});
                  });
                },
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك حدد ساعات العمل';
                  } else if (openTime == closeTime) {
                    return 'لا يمكن ان يكون وقت الاغلاق ووقت الفتح نفسه';
                  }
                  return null;
                },
                suffixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),
                hintText: '10:00 ص',
                maxLines: 1,
              ),
            ],
          ),
        ),
        Gap(16),
        Expanded(
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('الي', style: TextStyles.getBody()),
              MainTextFormField(
                controller: closeHourController,
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(hour: openTime.hour + 1, minute: 0),
                  ).then((value) {
                    if (value != null) {
                      closeHourController.text = value.format(context);
                      closeTime = value;
                    }
                    setState(() {});
                  });
                },
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك حدد ساعات العمل';
                  } else if (openTime.isAfter(closeTime)) {
                    return 'لا يمكن ان يكون وقت الاغلاق قبل وقت الفتح';
                  } else if (openTime == closeTime) {
                    return 'لا يمكن ان يكون وقت الاغلاق ووقت الفتح نفسه';
                  }
                  return null;
                },
                hintText: '10:00 ص',
                maxLines: 1,
                suffixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void uploadImage(BuildContext context, ImageSource source) {
    UploadImageService.pickImage(source: source).then((value) {
      if (value != null) {
        imageFile = value;
        setState(() {});
      }
    });
    context.pop();
  }
}
