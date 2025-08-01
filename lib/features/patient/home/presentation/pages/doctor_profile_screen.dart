import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button.dart';
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
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        centerTitle: true,
        title: Text(
          'بيانات الدكتور',
          style: TextStyles.getTitle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DoctorHeaderSection(doctor: doctor),
                    Gap(16),

                    Text(
                      'نبذه تعريفية',
                      style: TextStyles.getBody(fontWeight: FontWeight.bold),
                    ),
                    Gap(16),
                    Text(doctor.bio ?? '', style: TextStyles.getBody()),
                    Gap(16),
                    ClinicAddressInfoSection(doctor: doctor),
                    Divider(
                      thickness: 1.5,
                      endIndent: 16,
                      indent: 16,
                      color: AppColors.grayColor.withValues(alpha: 0.5),
                    ),
                    Gap(16),
                    Text(
                      'معلومات الاتصال',
                      style: TextStyles.getBody(fontWeight: FontWeight.bold),
                    ),
                    Gap(16),
                    ConnectiosInfoSection(doctor: doctor),
                    Gap(16),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: MainButton(
                onTap: () {},
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
