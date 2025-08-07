import 'package:flutter/material.dart';
import 'package:se7ety/components/custom_error_widget.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/auth/data/models/user_enum.dart';
import 'package:se7ety/features/profile/presentation/widgets/profile_header.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/connectios_info_section.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, required this.userType});
  final UserType userType;
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  PatientModel? patient;
  DoctorModel? doctor;

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
          future:
              widget.userType == UserType.patient
                  ? FireBaseService.getPatientData()
                  : FireBaseService.getDoctorData(),
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
              Object user;
              if (widget.userType == UserType.patient) {
                user = PatientModel.fromJson(
                  snapshot.data?.data() as Map<String, dynamic>,
                );
                return PatientUI(user: user as PatientModel);
              } else {
                user = DoctorModel.fromJson(
                  snapshot.data?.data() as Map<String, dynamic>,
                );
                return DoctorUI(user: user as DoctorModel);
              }
            }
          },
        ),
      ),
    );
  }
}

class PatientUI extends StatelessWidget {
  const PatientUI({super.key, required this.user});

  final PatientModel? user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeaderSection(
            imageUrl: user?.image ?? '',
            name: user?.name ?? '',
            location: user?.city ?? '',
          ),
          Text(
            'نبذة تعريفية',
            style: TextStyles.getBody(fontWeight: FontWeight.bold),
          ),
          Text(user?.bio ?? 'لم تضاف'),
          Divider(endIndent: 16, indent: 16),
          Text(
            'معلومات الاتصال',
            style: TextStyles.getBody(fontWeight: FontWeight.bold),
          ),
          ConnectiosInfoSection(
            phone: user?.phone ?? '',
            email: user?.email ?? '',
          ),
        ],
      ),
    );
  }
}

class DoctorUI extends StatelessWidget {
  const DoctorUI({super.key, required this.user});

  final DoctorModel? user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeaderSection(
            imageUrl: user?.image ?? '',
            name: user?.name ?? '',
            location: user?.specialization ?? '',
          ),

          Text(
            'نبذة تعريفية',
            style: TextStyles.getBody(fontWeight: FontWeight.bold),
          ),
          Text(user?.bio ?? 'لم تضاف'),
          Divider(endIndent: 16, indent: 16),
          Text(
            'معلومات الاتصال',
            style: TextStyles.getBody(fontWeight: FontWeight.bold),
          ),
          ConnectiosInfoSection(
            phone: user?.phone1 ?? '',
            email: user?.email ?? '',
          ),
        ],
      ),
    );
  }
}
