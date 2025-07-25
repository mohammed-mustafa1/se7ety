import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se7ety/features/auth/data/models/doctor_model.dart';
import 'package:se7ety/features/auth/data/models/patient_model.dart';

class FireBaseService {
  static late FirebaseFirestore _firestore;
  static late CollectionReference _doctorCollection;
  static late CollectionReference _patientsCollection;
  static init() {
    _firestore = FirebaseFirestore.instance;
    _doctorCollection = _firestore.collection('doctors');
    _patientsCollection = _firestore.collection('patients');
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
}
