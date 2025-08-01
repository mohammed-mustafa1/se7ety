import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/extensions/navigation.dart';
import 'package:se7ety/core/routers/app_routers.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/patient/home/presentation/widgets/doctor_card.dart';

class TopRatedDoctorListView extends StatelessWidget {
  const TopRatedDoctorListView({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FireBaseService.getTopRatedDoctors(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DoctorModel doctor = DoctorModel.fromJson(
                snapshot.data?.docs[index].data() as Map<String, dynamic>,
              );
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
            itemCount: snapshot.data?.docs.length ?? 0,
          );
        }
      },
    );
  }
}
