class UserModel {
  final String id;
  final String email;
  final String? password;
  final String? fname;
  final String? lname;
  final String? phonenumber;
  final String? address;
  final String? profileUrl;

  const UserModel({
    required this.id,
    required this.email,
    this.password,
    this.fname,
    this.lname,
    this.phonenumber,
    this.address,
    this.profileUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      email: data['email'],
      password: data['password'],
      fname: data['fname'],
      lname: data['lname'],
      phonenumber: data['phonenumber'],
      address: data['address'],
      profileUrl: data['profileUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id,
      if (email != null) "email": email,
      if (password != null) "password": password,
      if (fname != null) "fname": fname,
      if (lname != null) "lname": lname,
      if (phonenumber != null) "phonenumber": phonenumber,
      if (address != null) "address": address,
      if (profileUrl != null) "profileUrl": profileUrl,
    };
  }

  // Map<String, dynamic> toUpdateMap() {
  //   Map<String, dynamic> map = toMap();
  //   map.removeWhere((key, value) => value == null);
  //   return map;
  // }

  Map<String, dynamic> toUpdateMap() {
    Map<String, dynamic> map = toMap();
    map.removeWhere(
        (key, value) => value == null || value is List && value.isEmpty);
    return map;
  }
}

class educationModel{
  final String? id;
  final String clgname;
  final String degree;
  final String field;
  final String startdate;
  final String enddate;
  final String grade;
  final String description;

  educationModel({
    this.id,
    required this.clgname,
    required this.degree,
    required this.field,
    required this.startdate,
    required this.enddate,
    required this.grade,
    required this.description
  });
  toJson()
  {
    return{
      "Collage" : clgname,
      "Degree" : degree,
      "Field" : field,
      "Start Date" : startdate,
      "End Date" : enddate,
      "Grade" : grade,
      "Description" : description,
    };
  }
}
