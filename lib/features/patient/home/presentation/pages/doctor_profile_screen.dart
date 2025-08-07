import 'package:flutter/material.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/clinic_address_section.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/connectios_info_section.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/doctor_header_section.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key, required this.doctor});
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('بيانات الدكتور')),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DoctorHeaderSection(doctor: doctor),
                    Text(
                      'نبذه تعريفية',
                      style: TextStyles.getBody(fontWeight: FontWeight.bold),
                    ),
                    Text(doctor.bio ?? '', style: TextStyles.getBody()),
                    ClinicAddressInfoSection(doctor: doctor),
                    Divider(
                      thickness: 1.5,
                      endIndent: 16,
                      indent: 16,
                      color: AppColors.grayColor.withValues(alpha: 0.5),
                    ),
                    Text(
                      'معلومات الاتصال',
                      style: TextStyles.getBody(fontWeight: FontWeight.bold),
                    ),
                    ConnectiosInfoSection(
                      email: doctor.email ?? '',
                      phone: doctor.phone1 ?? '',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: MainButton(
                onTap: () {
                  context.pushTo(AppRouter.bookAppointment, extra: doctor);
                },
                text: 'احجز موعد الان',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
