import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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
      },
    );
  }
}
