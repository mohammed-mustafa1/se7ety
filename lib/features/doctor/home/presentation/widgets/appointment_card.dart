import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/extensions/media_query.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/booking/data/model/appointment_model.dart';

class TodayAppointmentCard extends StatelessWidget {
  const TodayAppointmentCard({super.key, required this.appointment});

  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: context.width * .50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.grayColor.withValues(alpha: 0.3),
            blurRadius: 3,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: AppColors.accentColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  appointment.patientName ?? '',
                  style: TextStyles.getSmall(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Gap(8),
          Text(
            'الوقت: ${TimeOfDay.fromDateTime(appointment.date!.toDate()).format(context)}',
            style: TextStyles.getBody(color: AppColors.grayColor),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              appointment.isComplete ?? false ? 'مكتمل' : 'غير مكتمل',
              style: TextStyles.getSmall(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
