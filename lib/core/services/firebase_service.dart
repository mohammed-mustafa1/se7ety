import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';
import 'package:se7ety/features/patient/booking/data/model/appointment_model.dart';

class FireBaseService {
  static late FirebaseFirestore _firestore;
  static late CollectionReference _doctorCollection;
  static late CollectionReference _patientsCollection;
  static late CollectionReference _appointmentsCollection;
  static init() async {
    _firestore = FirebaseFirestore.instance;
    _doctorCollection = _firestore.collection('doctors');
    _patientsCollection = _firestore.collection('patients');
    _appointmentsCollection = _firestore.collection('appointments');
  }

  static createDoctor({required DoctorModel doctorModel}) async {
    await _doctorCollection.doc(doctorModel.userId).set(doctorModel.toJson());
  }

  static createPatient({required PatientModel patientModel}) async {
    await _patientsCollection
        .doc(patientModel.userId)
        .set(patientModel.toJson());
  }

  static updateDoctorData({required DoctorModel doctorModel}) async {
    await _doctorCollection
        .doc(doctorModel.userId)
        .update(doctorModel.toUpgradeDoctorData());
  }

  static Future<QuerySnapshot<Object?>> getTopRatedDoctors() async {
    return await _doctorCollection.orderBy('rating', descending: true).get();
  }

  static Future<QuerySnapshot<Object?>> seachDoctorsByName({
    required String startAt,
    required String endAt,
  }) async {
    return await _doctorCollection
        .orderBy('name')
        .startAt([startAt.toLowerCase()])
        .endAt(['${endAt.toLowerCase()}\uf8ff'])
        .get();
  }

  static Future<QuerySnapshot<Object?>> getDoctorsBySpecialization({
    required String keyword,
  }) async {
    return await _doctorCollection
        .where('specialization', isEqualTo: keyword.toLowerCase())
        .get();
  }

  static Future<void> createAppointment({
    required AppointmentModel appointmentModel,
  }) async {
    return await _appointmentsCollection.doc().set(appointmentModel.toJson());
  }
}
