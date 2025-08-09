import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/services/firebase_service.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/patient/booking/data/model/appointment_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  TextEditingController searchController = TextEditingController();
  User user = FirebaseAuth.instance.currentUser!;
  List<DoctorModel> doctors = [];
  List<AppointmentModel> allAppointments = [];
  List<AppointmentModel> todayAppointments = [];
  List<PatientModel> patients = [];
  Future<void> getTodayDoctorAppointments() async {
    emit(HomeLoading());
    try {
      final value = await FireBaseService.getTodayDoctorAppointments();
      todayAppointments =
          value.docs.map((appointment) {
            return AppointmentModel.fromJson(
              appointment.data() as Map<String, dynamic>,
            );
          }).toList();
      emit(HomeSuccess());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> getAllAppointments() async {
    emit(HomeLoading());
    try {
      final value = await FireBaseService.getDoctorAppointments();
      allAppointments =
          value.docs.map((appointment) {
            return AppointmentModel.fromJson(
              appointment.data() as Map<String, dynamic>,
            );
          }).toList();
      emit(HomeSuccess());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> getPatients() async {
    emit(HomeLoading());
    try {
      final doc = await FireBaseService.getPatientsForDoctor(keyword: '');
      patients =
          doc.map((patient) {
            return PatientModel.fromJson(
              patient.data() as Map<String, dynamic>,
            );
          }).toList();
      emit(HomeSuccess());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
