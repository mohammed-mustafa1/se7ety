import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/booking/data/model/appointment_model.dart';

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({
    super.key,
    required this.appointment,
    required this.onDelete,
  });
  final AppointmentModel appointment;
  final Function() onDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentColor.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            'د. ${appointment.doctorName}',
            style: TextStyles.getTitle(color: AppColors.primaryColor),
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          childrenPadding: EdgeInsets.all(20),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          subtitle: Column(
            children: [
              Gap(16),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.primaryColor,
                  ),
                  Gap(16),
                  Text(
                    DateFormat(
                      'dd-MM-yyyy',
                      'en_US',
                    ).format(appointment.date!.toDate()),
                    style: TextStyles.getBody(),
                  ),
                  Gap(32),
                  Visibility(
                    visible:
                        appointment.date!.toDate().day == DateTime.now().day,
                    child: Text(
                      'اليوم',
                      style: TextStyles.getBody(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(16),
              Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    color: AppColors.primaryColor,
                  ),
                  Gap(16),
                  Text(
                    TimeOfDay.fromDateTime(
                      appointment.date!.toDate(),
                    ).format(context),
                    style: TextStyles.getBody(),
                  ),
                ],
              ),
            ],
          ),
          children: [
            Row(
              spacing: 16,
              children: [
                Icon(Icons.person, color: AppColors.primaryColor),
                Flexible(
                  child: Text(
                    appointment.patientName ?? '',
                    style: TextStyles.getBody(),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 16,
              children: [
                Icon(Icons.location_on, color: AppColors.primaryColor),
                Flexible(
                  child: Text(
                    appointment.location ?? '',
                    style: TextStyles.getBody(),
                  ),
                ),
              ],
            ),
            Gap(16),
            MainButton(
              height: 40,
              backgroundColor: Colors.red,
              onTap: onDelete,
              text: 'حذف الحجز',
            ),
          ],
        ),
      ),
    );
  }
}
