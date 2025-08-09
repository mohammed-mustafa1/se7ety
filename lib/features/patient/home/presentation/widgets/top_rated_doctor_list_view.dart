import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/custom_error_widget.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/doctor/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/doctor_card.dart';

class TopRatedDoctorListView extends StatelessWidget {
  const TopRatedDoctorListView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var doctors = context.read<HomeCubit>().topRatedDoctors;
        if (state is HomeError) {
          return CustomErrorWidget(message: state.message);
        } else if (state is HomeSuccess) {
          if (doctors.isEmpty) {
            return SizedBox(
              height: 160,
              child: Center(
                child: Text(
                  'لا يوجد أطباء ',
                  style: TextStyles.getBody(color: AppColors.grayColor),
                ),
              ),
            );
          }
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DoctorModel doctor = doctors[index];
              if (doctor.specialization == '' ||
                  doctor.specialization == null) {
                return Container();
              } else {
                return GestureDetector(
                  onTap: () {
                    context.pushTo(AppRouter.doctorProfile, extra: doctor);
                  },
                  child: DoctorCard(doctor: doctor),
                );
              }
            },
            separatorBuilder: (context, index) => Gap(16),
            itemCount: doctors.length,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
