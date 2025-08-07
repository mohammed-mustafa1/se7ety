import 'package:flutter/material.dart';
import 'package:se7ety/components/custom_error_widget.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/intro/profile/presentation/widgets/profile_header.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/connectios_info_section.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  PatientModel? patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context
                  .pushTo(AppRouter.settings)
                  .then((value) => setState(() {}));
            },
            icon: Icon(Icons.settings),
          ),
        ],
        title: Text(
          'الحساب الشخصي',
          style: TextStyles.getTitle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
            } else {
              patient = PatientModel.fromJson(
                snapshot.data?.data() as Map<String, dynamic>,
              );
              return SingleChildScrollView(
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileHeaderSection(
                      imageUrl: patient?.image ?? '',
                      name: patient?.name ?? '',
                      location: patient?.city ?? '',
                    ),
                    Text(
                      'نبذة تعريفية',
                      style: TextStyles.getBody(fontWeight: FontWeight.bold),
                    ),
                    Text(patient?.bio ?? 'لم تضاف'),
                    Divider(endIndent: 16, indent: 16),
                    Text(
                      'معلومات الاتصال',
                      style: TextStyles.getBody(fontWeight: FontWeight.bold),
                    ),
                    ConnectiosInfoSection(
                      phone: patient?.phone ?? '',
                      email: patient?.email ?? '',
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
