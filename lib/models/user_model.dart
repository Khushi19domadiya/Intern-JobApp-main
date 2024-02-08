import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String? password;
  final String? lname;
  final String? fname;
  final String? phonenumber;
  final String? address;
  final String? profileUrl;
  final String? role;

  const UserModel({
    required this.id,
    required this.email,
    this.password,
    this.fname,
    this.lname,
    this.phonenumber,
    this.address,
    this.profileUrl,
    this.role,
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
      role  : data['role'],
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
      if (role != null) "role": role,
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

class postjobModel {
  final String id;
  final String title;
  final String lowestsalary;
  final String highestsalary;
  final String address;
  final String experience;
  final String about;
  final String deadline;
  final String? jobType;
  final String? gender;
  final List<dynamic> selectedSkills;
  final String? selectedOption;

  postjobModel({
    required this.id,
    required this.title,
    required this.lowestsalary,
    required this.highestsalary,
    required this.address,
    required this.experience,
    required this.about,
    required this.deadline,
    this.jobType,
    this.gender,
    required this.selectedSkills,
    required  this.selectedOption,

  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'lowestsalary': lowestsalary,
      'highestsalary': highestsalary,
      'address': address,
      'experience': experience,
      'about': about,
      'deadline': deadline,
      'jobType': jobType,
      'gender': gender,
      'selectedSkills': selectedSkills,
      'selectedOption': selectedOption,
    };
  }
  factory postjobModel.fromSnapshot(Map<String, dynamic> data) =>
      postjobModel(
        id: data["id"],
        title: data["title"],
        lowestsalary: data["lowestsalary"],
        highestsalary: data["highestsalary"],
        address: data["address"],
        experience: data["experience"],
        about: data["about"],
        deadline: data["deadline"],
        jobType: data["jobType"],
        gender: data["gender"],
        selectedSkills: data["selectedSkills"],
        selectedOption: data["selectedOption"],
    );
}