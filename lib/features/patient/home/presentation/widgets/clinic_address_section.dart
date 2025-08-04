import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';

class ClinicAddressInfoSection extends StatelessWidget {
  const ClinicAddressInfoSection({super.key, required this.doctor});

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
                child: Icon(
                  Icons.watch_later_outlined,
                  color: AppColors.whiteColor,
                ),
              ),
              Gap(16),
              Text(
                '${TimeOfDay.fromDateTime(doctor.openHour!.toDate()).format(context)} - ${TimeOfDay.fromDateTime(doctor.closeHour!.toDate()).format(context)}',
                style: TextStyles.getBody(),
              ),
            ],
          ),
          Gap(16),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.location_on, color: AppColors.whiteColor),
              ),
              Gap(16),
              Flexible(
                child: Text(doctor.address ?? '', style: TextStyles.getBody()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
