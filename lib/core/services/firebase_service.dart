import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se7ety/core/services/shared_prefs.dart';
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

  static Future<void> createDoctor({required DoctorModel doctorModel}) async {
    await _doctorCollection.doc(doctorModel.userId).set(doctorModel.toJson());
  }

  static Future<void> createPatient({
    required PatientModel patientModel,
  }) async {
    await _patientsCollection
        .doc(patientModel.userId)
        .set(patientModel.toJson());
  }

  static Future<void> updateDoctorData({
    required DoctorModel doctorModel,
  }) async {
    await _doctorCollection
        .doc(SharedPrefs.getUserID())
        .update(doctorModel.toUpgradeDoctorData());
  }

  static Future<QuerySnapshot<Object?>> getTopRatedDoctors() async {
    return await _doctorCollection.orderBy('rating', descending: true).get();
  }

  static Future<DocumentSnapshot<Object?>> getPatientData() async {
    return await _patientsCollection.doc(SharedPrefs.getUserID()).get();
  }

  static Future<DocumentSnapshot<Object?>> getDoctorData() async {
    return await _doctorCollection.doc(SharedPrefs.getUserID()).get();
  }

  static Future<List<DocumentSnapshot>> getPatientsForDoctor({
    required String keyword,
  }) async {
    // get all appointments for current doctor
    final appointmentsSnapshot =
        await _appointmentsCollection
            .where('doctorId', isEqualTo: SharedPrefs.getUserID())
            .get();

    // get all patient ids
    final patientIds =
        appointmentsSnapshot.docs
            .map((doc) => doc['patientId'] as String)
            .toSet()
            .toList();
    // check if patient ids is empty
    if (patientIds.isEmpty) return [];

    // get all patients
    final patientsSnapshot =
        await _patientsCollection
            .where(FieldPath.documentId, whereIn: patientIds.take(10).toList())
            .get();

    // return patients where name contains keyword
    return patientsSnapshot.docs.where((doc) {
      final name = (doc['name'] as String).toLowerCase();
      return name.contains(keyword.toLowerCase());
    }).toList();
  }

  static Future<void> updatePatientData({
    required PatientModel patientModel,
  }) async {
    return await _patientsCollection
        .doc(SharedPrefs.getUserID())
        .update(patientModel.toUpdatePatientData());
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

  static Future<QuerySnapshot<Object?>> getPatientAppointments() async {
    return await _appointmentsCollection
        .where('patientId', isEqualTo: SharedPrefs.getUserID())
        .orderBy('time', descending: false)
        .get();
  }

  static Future<QuerySnapshot<Object?>> getDoctorAppointments() async {
    return await _appointmentsCollection
        .where('doctorId', isEqualTo: SharedPrefs.getUserID())
        .orderBy('time', descending: false)
        .get();
  }

  static Future<void> deletePatientAppointment({
    required String documentID,
  }) async {
    return await _appointmentsCollection.doc(documentID).delete();
  }
}
