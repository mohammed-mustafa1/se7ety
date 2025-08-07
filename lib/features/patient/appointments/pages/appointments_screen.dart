import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/custom_error_widget.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/features/patient/appointments/widgets/appointment_tile.dart';
import 'package:se7ety/features/patient/appointments/widgets/empty_u_i.dart';
import 'package:se7ety/features/patient/booking/data/model/appointment_model.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('مواعيد الحجز')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: FireBaseService.getPatientAppointments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return CustomErrorWidget(message: snapshot.error.toString());
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
