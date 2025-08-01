import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';

class ConnectiosInfoSection extends StatelessWidget {
  const ConnectiosInfoSection({super.key, required this.doctor});

  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.accentColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.email, color: AppColors.whiteColor),
              ),
              Gap(16),
              Text(doctor.email ?? '', style: TextStyles.getBody()),
            ],
          ),
          Gap(16),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.phone, color: AppColors.whiteColor),
              ),
              Gap(16),
              Text(doctor.phone1 ?? '', style: TextStyles.getBody()),
            ],
          ),
        ],
      ),
    );
  }
}
