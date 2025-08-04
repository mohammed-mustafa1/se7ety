import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String? patientId;
  final String? doctorId;
  final String? patientName;
  final String? phone;
  final String? description;
  final String? doctorName;
  final String? location;
  final Timestamp? date;
  final bool? isComplete;
  final int? rating;

  AppointmentModel({
    required this.patientId,
    required this.doctorId,
    required this.patientName,
    required this.phone,
    required this.description,
    required this.doctorName,
    required this.location,
    required this.date,
    required this.isComplete,
    required this.rating,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        patientId: json['patientId'],
        doctorId: json['doctorId'],
        patientName: json['patientName'],
        phone: json['phone'],
        description: json['description'],
        doctorName: json['doctorName'],
        location: json['location'],
        date: json['time'],
        isComplete: json['isComplete'],
        rating: json['rating'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'patientId': patientId,
    'doctorId': doctorId,
    'patientName': patientName,
    'phone': phone,
    'description': description,
    'doctorName': doctorName,
    'location': location,
    'time': date,
    'isComplete': isComplete,
    'rating': rating,
  };
}
