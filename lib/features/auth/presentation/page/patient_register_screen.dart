import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety/components/buttons/camera_icon_button.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/inputs/main_text_form_field.dart';
import 'package:se7ety/components/dialogs/main_dialog.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/extensions/theme.dart';
import 'package:se7ety/core/function/show_bottom_sheet.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/services/shared_prefs.dart';
import 'package:se7ety/core/services/upload_image.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:se7ety/features/auth/presentation/widgets/profile_image.dart';

class PatientRegisterScreen extends StatefulWidget {
  const PatientRegisterScreen({super.key});

  @override
  State<PatientRegisterScreen> createState() => _PatientRegisterScreenState();
}

class _PatientRegisterScreenState extends State<PatientRegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController bioController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
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
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Stack(
                            children: [
                              ProfileImage(
                                imageNetworkUrl: imageFile.path,
                                imageFile: imageFile,
                              ),
                              Positioned(
                                bottom: 0,
                                child: CameraIconButton(
                                  onTap: () {
                                    showPickImageBottomSheet(
                                      context,
                                      onTapCamera: () {
                                        uploadImage(
                                          context,
                                          ImageSource.camera,
                                        );
                                      },
                                      onTapGallery: () {
                                        uploadImage(
                                          context,
                                          ImageSource.gallery,
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text('العمر', style: TextStyles.getBody()),
                      MainTextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك ادخل العمر';
                          }
                          return null;
                        },
                        hintText: '18',
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
                      Text('المدينة', style: TextStyles.getBody()),
                      MainTextFormField(
                        controller: addressController,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'من فضلك ادخل المدينة'
                                    : null,
                        hintText: '5 شارع مصدق - الدقي - الجيزة',
                      ),
                      Text('رقم الهاتف ', style: TextStyles.getBody()),
                      MainTextFormField(
                        controller: phoneController,
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
                        .registerPatientData(
                          patientModel: PatientModel(
                            userId: SharedPrefs.getUserID(),
                            city: addressController.text,
                            phone: phoneController.text,
                            bio: bioController.text,
                            image: imageUrl,
                            age: int.parse(ageController.text),
                          ),
                        )
                        .then((value) {
                          context.pop();
                          showMainSnackBar(
                            context,
                            text: 'تمت عملية التسجيل بنجاح',
                            type: DialogType.success,
                          );
                          context.pushToBase(AppRouter.mainScreen);
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
