import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/custom_error_widget.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/doctor/home/presentation/cubit/home_cubit/home_cubit.dart';
import 'package:se7ety/features/doctor/search/presentation/widgets/patient_card.dart';

class NewPatientsSection extends StatelessWidget {
  const NewPatientsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        if (state is HomeError) {
          return Center(child: CustomErrorWidget(message: state.message));
        } else if (state is HomeSuccess) {
          if (cubit.patients.isEmpty) {
            return SizedBox(
              height: 160,
              child: Center(
                child: Text(
                  'لا يوجد مرضى ',
                  style: TextStyles.getBody(color: AppColors.grayColor),
                ),
              ),
            );
          } else {
            return ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Gap(16),
              itemCount: cubit.patients.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                PatientModel patient = cubit.patients[index];
                return PatientCard(
                  patient: PatientModel(
                    name: patient.name,
                    phone: patient.phone,
                    age: patient.age,
                    image: patient.image,
                  ),
                );
              },
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
