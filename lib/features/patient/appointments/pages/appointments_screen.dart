import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/patient/appointments/widgets/appointment_tile.dart';
import 'package:se7ety/features/patient/appointments/widgets/empty_u_i.dart';
import 'package:se7ety/features/patient/booking/data/model/appointment_model.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'مواعيد الحجز',
          style: TextStyles.getTitle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: FireBaseService.getPatientAppointments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.red.shade100,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 50),
                      Gap(16),
                      Text(
                        textAlign: TextAlign.center,
                        'Error: ${snapshot.error}',
                        style: TextStyles.getTitle(),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return EmptyUI();
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) => Gap(16),
                itemCount: snapshot.data?.docs.length ?? 0,
                itemBuilder: (context, index) {
                  AppointmentModel appointment = AppointmentModel.fromJson(
                    snapshot.data!.docs[index].data() as Map<String, dynamic>,
                  );
                  return AppointmentTile(
                    appointment: appointment,
                    appointmentId: snapshot.data!.docs[index].id,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
