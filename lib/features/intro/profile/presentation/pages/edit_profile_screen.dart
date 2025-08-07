import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/components/custom_error_widget.dart';
import 'package:se7ety/components/dialogs/main_dialog.dart';
import 'package:se7ety/core/extensions/theme.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/intro/profile/presentation/widgets/edit_profile_item.dart';

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
                'subtitle': patient.age ?? '',
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
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
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
          content: TextField(
            inputFormatters:
                editType == EditType.age || editType == EditType.phone
                    ? [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
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
          actions: [
            MainButton(
              height: 60,
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
                }
                context.pop();
              },
              text: 'حفظ التعديل',
            ),
          ],
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
        age: editType == EditType.age ? value : null,
      ),
    );
    if (editType == EditType.name) {
      FirebaseAuth.instance.currentUser!.updateDisplayName(value);
    }
  }
}

enum EditType { email, name, phone, city, bio, age, image }
