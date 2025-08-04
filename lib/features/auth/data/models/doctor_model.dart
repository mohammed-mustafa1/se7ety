import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  String? userId;
  String? name;
  String? email;
  String? phone1;
  String? phone2;
  String? address;
  String? image;
  int? rating;
  String? specialization;
  String? bio;
  Timestamp? openHour;
  Timestamp? closeHour;

  DoctorModel({
    this.userId,
    this.name,
    this.email,
    this.phone1,
    this.phone2,
    this.address,
    this.image,
    this.rating,
    this.specialization,
    this.bio,
    this.openHour,
    this.closeHour,
  });

  DoctorModel.fromJson(Map<String, dynamic> json) {
    userId = json['uid'];
    name = json['name'];
    email = json['email'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    address = json['address'];
    image = json['image'];
    rating = json['rating'];
    specialization = json['specialization'];
    bio = json['bio'];
    openHour = json['openHour'];
    closeHour = json['closeHour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone1'] = phone1;
    data['phone2'] = phone2;
    data['address'] = address;
    data['image'] = image;
    data['rating'] = rating;
    data['specialization'] = specialization;
    data['bio'] = bio;
    data['openHour'] = openHour;
    data['closeHour'] = closeHour;
    return data;
  }

  Map<String, dynamic> toUpgradeDoctorData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userId != null) data['uid'] = userId;
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (phone1 != null) data['phone1'] = phone1;
    if (phone2 != null) data['phone2'] = phone2;
    if (address != null) data['address'] = address;
    if (image != null) data['image'] = image;
    if (rating != null) data['rating'] = rating;
    if (specialization != null) data['specialization'] = specialization;
    if (bio != null) data['bio'] = bio;
    if (openHour != null) data['openHour'] = openHour;
    if (closeHour != null) data['closeHour'] = closeHour;
    return data;
  }
}
