import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/custom_error_widget.dart';
import 'package:se7ety/components/dialogs/main_dialog.dart';
import 'package:se7ety/components/inputs/main_dropdown_button_form_field.dart';
import 'package:se7ety/core/constants/specialization.dart';
import 'package:se7ety/core/extensions/theme.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/profile/presentation/widgets/edit_profile_item.dart';

class DoctorEditProfileScreen extends StatefulWidget {
  const DoctorEditProfileScreen({super.key});

  @override
  State<DoctorEditProfileScreen> createState() =>
      _DoctorEditProfileScreenState();
}

class _DoctorEditProfileScreenState extends State<DoctorEditProfileScreen> {
  DoctorModel? doctor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اعدادات الحساب')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: FireBaseService.getDoctorData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return CustomErrorWidget(message: snapshot.error.toString());
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            doctor = DoctorModel.fromJson(
              snapshot.data!.data() as Map<String, dynamic>,
            );

            List widgets = [
              {
                'title': 'الاسم',
                'subtitle': doctor!.name ?? '',
                'editType': EditType.name,
              },
              {
                'title': 'رقم الهاتف 1',
                'subtitle': doctor!.phone1 ?? '',
                'editType': EditType.phone,
              },
              {
                'title': 'رقم الهاتف 2',
                'subtitle': doctor!.phone1 ?? '',
                'editType': EditType.phone,
              },
              {
                'title': 'العنوان',
                'subtitle': doctor!.address ?? '',
                'editType': EditType.city,
              },
              {
                'title': 'نبذة تعريفية',
                'subtitle': doctor!.bio ?? '',
                'editType': EditType.bio,
              },
              {
                'title': 'التخصص',
                'subtitle': doctor!.specialization ?? '',
                'editType': EditType.specialization,
              },

              {
                'title': 'وقت الفتح',
                'subtitle': TimeOfDay.fromDateTime(
                  doctor?.openHour!.toDate() ?? DateTime.now(),
                ).format(context),
                'editType': EditType.openHour,
              },
              {
                'title': 'وقت الاغلاق',
                'subtitle': TimeOfDay.fromDateTime(
                  doctor?.closeHour!.toDate() ?? DateTime.now(),
                ).format(context),
                'editType': EditType.closeHour,
              },
            ];

            return SingleChildScrollView(
              child: Column(
                spacing: 16,
                children: [
                  ...widgets.map(
                    (e) => EditProfileItem(
                      title: e['title'] ?? '',
                      subtitle: e['subtitle'] ?? '',
                      onTap: () async {
                        await showEditDialog(
                          context,
                          title: 'ادخل ${e['title']}',
                          content: e['subtitle'] ?? '',
                          editType: e['editType'],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> showEditDialog(
    BuildContext context, {
    required String title,
    required String content,
    required EditType editType,
  }) {
    TextEditingController controller = TextEditingController(text: content);
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? editingValue;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.primaryColor, width: 2),
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(title, textAlign: TextAlign.center),
          titleTextStyle: TextStyles.getTitle(
            color:
                context.brightness == Brightness.light
                    ? AppColors.darkColor
                    : AppColors.whiteColor,

            fontWeight: FontWeight.bold,
          ),
          content: Form(
            key: formKey,
            child:
                editType == EditType.specialization
                    ? MainDropdownButtonFormField(
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
                      value: editingValue ?? specializations[0],
                      onChanged: (value) {
                        editingValue = value ?? specializations[0];
                      },
                    )
                    : TextFormField(
                      readOnly:
                          editType == EditType.specialization ||
                          editType == EditType.openHour ||
                          editType == EditType.closeHour,
                      onTap: () {
                        editType == EditType.openHour ||
                                editType == EditType.closeHour
                            ? showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(
                                hour: DateTime.now().hour + 1,
                                minute: DateTime.now().minute,
                              ),
                            ).then((value) {
                              if (value != null) {
                                editingValue =
                                    DateTime(
                                      2025,
                                      7,
                                      1,
                                      value.hour,
                                      value.minute,
                                    ).toString();
                                controller.text = TimeOfDay.fromDateTime(
                                  DateTime.parse(editingValue!),
                                ).format(context);
                              }
                            })
                            : null;
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().isEmpty) {
                          return 'الحقل مطلوب';
                        }

                        if (editType == EditType.phone) {
                          if (value.length != 11) {
                            return 'رقم الهاتف غير صالح';
                          }
                        }
                        return null;
                      },
                      maxLength: editType == EditType.phone ? 11 : null,
                      maxLines: null,
                      inputFormatters:
                          editType == EditType.phone
                              ? [
                                FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]'),
                                ),
                                FilteringTextInputFormatter.digitsOnly,
                              ]
                              : [],
                      keyboardType:
                          editType == EditType.phone
                              ? TextInputType.number
                              : TextInputType.text,
                      onChanged: (value) {
                        editingValue = value;
                      },
                      decoration: InputDecoration(filled: true),
                      style: TextStyles.getSmall(fontWeight: FontWeight.bold),
                      controller: controller,
                    ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: MainButton(
                    height: 45,
                    onTap: () => context.pop(),
                    text: 'الغاء',
                    backgroundColor: Colors.red,
                  ),
                ),
                Gap(16),
                Expanded(
                  child: MainButton(
                    height: 45,
                    onTap: () async {
                      if (formKey.currentState!.validate() &&
                          editingValue != null) {
                        if (editType == EditType.openHour) {
                          if (DateTime.parse(
                                editingValue!,
                              ).isAfter(doctor!.closeHour!.toDate()) ||
                              DateTime.parse(
                                editingValue!,
                              ).isAtSameMomentAs(doctor!.closeHour!.toDate())) {
                            showMainSnackBar(
                              context,
                              text: 'وقت الفتح يجب ان يكون قبل وقت الاغلاق',
                              type: DialogType.error,
                            );
                            return;
                          }
                        }
                        if (editType == EditType.closeHour) {
                          if (DateTime.parse(
                                editingValue!,
                              ).isBefore(doctor!.openHour!.toDate()) ||
                              DateTime.parse(
                                editingValue!,
                              ).isAtSameMomentAs(doctor!.openHour!.toDate())) {
                            showMainSnackBar(
                              context,
                              text: 'وقت الاغلاق يجب ان يكون بعد وقت الفتح',
                              type: DialogType.error,
                            );
                            return;
                          }
                        }
                        showLoadingDialog(context);
                        await updateUsereData(
                          editType: editType,
                          value: editingValue!,
                        );
                        setState(() {
                          context.pop();
                          context.pop();
                        });
                      }
                    },
                    text: 'حفظ',
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> updateUsereData({
    required EditType editType,
    required String value,
  }) async {
    await FireBaseService.updateDoctorData(
      doctorModel: DoctorModel(
        name: editType == EditType.name ? value : null,
        phone1: editType == EditType.phone ? value : null,
        address: editType == EditType.city ? value : null,
        bio: editType == EditType.bio ? value : null,
        specialization: editType == EditType.specialization ? value : null,
        openHour:
            editType == EditType.openHour
                ? Timestamp.fromDate(DateTime.parse(value))
                : null,
        closeHour:
            editType == EditType.closeHour
                ? Timestamp.fromDate(DateTime.parse(value))
                : null,
      ),
    );
    if (editType == EditType.name) {
      FirebaseAuth.instance.currentUser!.updateDisplayName(value);
    }
  }
}

enum EditType {
  name,
  phone,
  city,
  bio,
  image,
  specialization,
  openHour,
  closeHour,
}
