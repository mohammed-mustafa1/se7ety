import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/custom_error_widget.dart';
import 'package:se7ety/components/dialogs/main_dialog.dart';
import 'package:se7ety/core/extensions/theme.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/profile/presentation/widgets/edit_profile_item.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اعدادات الحساب')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: FireBaseService.getPatientData(),
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
            PatientModel patient = PatientModel.fromJson(
              snapshot.data!.data() as Map<String, dynamic>,
            );

            List widgets = [
              {
                'title': 'الاسم',
                'subtitle': patient.name ?? '',
                'editType': EditType.name,
              },
              {
                'title': 'رقم الهاتف',
                'subtitle': patient.phone ?? '',
                'editType': EditType.phone,
              },
              {
                'title': 'المدينة',
                'subtitle': patient.city ?? '',
                'editType': EditType.city,
              },
              {
                'title': 'نبذة تعريفية',
                'subtitle': patient.bio ?? '',
                'editType': EditType.bio,
              },
              {
                'title': 'العمر',
                'subtitle': patient.age.toString(),
                'editType': EditType.age,
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
    String? editingValue;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
              top: 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyles.getTitle(
                      color:
                          context.brightness == Brightness.light
                              ? AppColors.darkColor
                              : AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(16),
                  TextField(
                    maxLines: null,
                    maxLength: editType == EditType.phone ? 11 : null,
                    inputFormatters:
                        editType == EditType.age || editType == EditType.phone
                            ? [
                              FilteringTextInputFormatter.allow(
                                RegExp('[0-9]'),
                              ),
                              FilteringTextInputFormatter.digitsOnly,
                            ]
                            : [],
                    keyboardType:
                        editType == EditType.age || editType == EditType.phone
                            ? TextInputType.number
                            : TextInputType.text,
                    onChanged: (value) {
                      editingValue = value;
                    },
                    decoration: InputDecoration(filled: true),
                    style: TextStyles.getSmall(fontWeight: FontWeight.bold),
                    controller: controller,
                  ),
                  Gap(16),
                  Row(
                    children: [
                      Expanded(
                        child: MainButton(
                          onTap: () => context.pop(),
                          text: 'الغاء',
                          backgroundColor: Colors.red,
                        ),
                      ),
                      Gap(16),
                      Expanded(
                        child: MainButton(
                          onTap: () {
                            if (editingValue != null) {
                              showLoadingDialog(context);
                              updateProfileData(
                                editType: editType,
                                value: editingValue!,
                              ).then((value) {
                                context.pop();
                                setState(() {});
                              });
                            } else {
                              context.pop();
                            }
                          },
                          text: 'حفظ',
                        ),
                      ),
                    ],
                  ),
                  Gap(16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> updateProfileData({
    required EditType editType,
    required String value,
  }) async {
    await FireBaseService.updatePatientData(
      patientModel: PatientModel(
        name: editType == EditType.name ? value : null,
        phone: editType == EditType.phone ? value : null,
        city: editType == EditType.city ? value : null,
        bio: editType == EditType.bio ? value : null,
        age: editType == EditType.age ? int.tryParse(value) : null,
      ),
    );
    if (editType == EditType.name) {
      FirebaseAuth.instance.currentUser!.updateDisplayName(value);
    }
  }
}

enum EditType { email, name, phone, city, bio, age, image }
