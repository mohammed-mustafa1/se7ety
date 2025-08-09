import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/custom_error_widget.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/doctor/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:se7ety/features/doctor/home/presentation/widgets/appointment_card.dart';
import 'package:se7ety/features/patient/booking/data/model/appointment_model.dart';

class TodayAppointments extends StatelessWidget {
  const TodayAppointments({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        if (state is HomeError) {
          return CustomErrorWidget(message: state.message);
        } else if (state is HomeSuccess) {
          if (cubit.todayAppointments.isEmpty) {
            return SizedBox(
              height: 160,
              child: Center(
                child: Text(
                  'لا توجد حجوزات اليوم',
                  style: TextStyles.getBody(color: AppColors.grayColor),
                ),
              ),
            );
          }
          return SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: cubit.todayAppointments.length,
              itemBuilder: (context, index) {
                AppointmentModel appointment = cubit.todayAppointments[index];
                return TodayAppointmentCard(appointment: appointment);
              },
              separatorBuilder: (context, index) {
                return Gap(8);
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
