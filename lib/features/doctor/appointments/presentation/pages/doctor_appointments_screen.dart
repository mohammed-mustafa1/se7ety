import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:se7ety/components/custom_error_widget.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/features/doctor/appointments/presentation/widgets/doctor_appointment_tile.dart';
import 'package:se7ety/features/patient/appointments/widgets/empty_u_i.dart';
import 'package:se7ety/features/patient/booking/data/model/appointment_model.dart';

class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  State<DoctorAppointmentsScreen> createState() =>
      _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('مواعيد الحجز')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: FireBaseService.getDoctorAppointments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              log(snapshot.error.toString());
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
                  return DoctorAppointmentTile(
                    appointment: appointment,
                    appointmentId: snapshot.data!.docs[index].id,
                    onDelete: () {
                      context.pop();
                      setState(() {});
                    },
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
