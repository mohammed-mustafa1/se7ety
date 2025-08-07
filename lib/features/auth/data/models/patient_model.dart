class PatientModel {
  String? userId;
  String? name;
  String? image;
  int? age;
  String? email;
  String? phone;
  String? bio;
  String? city;
  PatientModel({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.city,
    this.image,
    this.bio,
    this.age,
  });

  PatientModel.fromJson(Map<String, dynamic> json) {
    userId = json['uid'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    city = json['city'];
    image = json['image'];
    bio = json['bio'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['city'] = city;
    data['image'] = image;
    data['bio'] = bio;
    data['age'] = age;
    return data;
  }

  Map<String, dynamic> toUpdatePatientData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userId != null) data['uid'] = userId;
    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (city != null) data['city'] = city;
    if (image != null) data['image'] = image;
    if (bio != null) data['bio'] = bio;
    if (age != null) data['age'] = age;
    return data;
  }
}
