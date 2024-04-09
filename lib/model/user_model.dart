import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? email;
  String? userId;
  String? password;
  String? lname;
  String? fname;
  String? npassowrd;
  String? phonenumber;
  String? address;
  String? profileUrl;
  String? role;
  List<String>? skills;
  String? registrationDateTime;
  String? token;
  String? status;
  String? profile;

  UserModel({
    required this.userId,
    required this.email,
    this.password,
    this.token,
    this.skills,
    this.fname,
    this.lname,
    this.registrationDateTime,
    this.npassowrd,
    this.phonenumber,
    this.address,
    this.profileUrl,
    this.status,
    this.role,
    this.profile,
  });

  factory UserModel.fromSnapshot(Map<String, dynamic> data) => UserModel(
        userId: data['userId'],
        email: data['email'],
        password: data['password'],
        token: data['token'],
        fname: data['fname'],
        registrationDateTime: data['registrationDateTime'] == null ? null : data['registrationDateTime'].toString(),
        lname: data['lname'],
        npassowrd: data['npassowrd'],
        phonenumber: data['phonenumber'],
        address: data['address'],
        profileUrl: data['profileUrl'],
        status: data['status'],
        skills: data['skills'] == null ? null : data['skills'].cast<String>(),
        role: data['role'],
        profile: data['profile'],
      );

  Map<String, dynamic> toMap() {
    return {
      if (userId != null) "userId": userId,
      if (email != null) "email": email,
      if (password != null) "password": password,
      if (fname != null) "fname": fname,
      if (token != null) "token": token,
      if (registrationDateTime != null) "registrationDateTime": registrationDateTime,
      if (lname != null) "lname": lname,
      if (npassowrd != null) "npassowrd": npassowrd,
      if (phonenumber != null) "phonenumber": phonenumber,
      if (address != null) "address": address,
      if (profileUrl != null) "profileUrl": profileUrl,
      if (role != null) "role": role,
      if (skills != null) "skills": skills,
      if (skills != null) "status": status,
      if (profile != null) "profile": profile,
    };
  }

  // Map<String, dynamic> toUpdateMap() {
  //   Map<String, dynamic> map = toMap();
  //   map.removeWhere((key, value) => value == null);
  //   return map;
  // }

  Map<String, dynamic> toUpdateMap() {
    Map<String, dynamic> map = toMap();
    map.removeWhere((key, value) => value == null || value is List && value.isEmpty);
    return map;
  }
}

class educationModel {
  final String? id;
  final String clgname;
  final String degree;
  final String field;
  final String startdate;
  final String enddate;
  final String grade;
  final String description;

  educationModel(
      {this.id,
      required this.clgname,
      required this.degree,
      required this.field,
      required this.startdate,
      required this.enddate,
      required this.grade,
      required this.description});
  toJson() {
    return {
      "Collage": clgname,
      "Degree": degree,
      "Field": field,
      "Start Date": startdate,
      "End Date": enddate,
      "Grade": grade,
      "Description": description,
    };
  }
}

class PostJobModel {
  final String id;
  final String? userId;
  final String title;
  final String lowestsalary;
  final String highestsalary;
  final String address;
  final String experience;
  final String description;
  final int? isDelete;
  // final String postJobDate;
  final String deadline;
  final String? jobType;
  final String? createAt;
  final String? gender;
  final List<dynamic> selectedSkills;
  final String? selectedOption;
  final String? selectedSourceOption;
  int applyCount = 0;

  PostJobModel({
    required this.id,
    required this.userId,
    required this.createAt,
    required this.title,
    required this.isDelete,
    required this.lowestsalary,
    required this.highestsalary,
    required this.address,
    required this.experience,
    required this.description,
    // required this.postJobDate,
    required this.deadline,
    this.jobType,
    this.gender,
    required this.selectedSkills,
    required this.selectedOption,
    required this.selectedSourceOption,
    required this.applyCount,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'createAt': createAt,
      'title': title,
      'lowestsalary': lowestsalary,
      'highestsalary': highestsalary,
      'address': address,
      'experience': experience,
      'description': description,
      'isDelete': isDelete,
      // 'postJobDate': postJobDate,
      'deadline': deadline,
      'jobType': jobType,
      'gender': gender,
      'selectedSkills': selectedSkills,
      'selectedOption': selectedOption,
      'selectedSourceOption': selectedSourceOption,
      'applyCount': applyCount
    };
  }

  factory PostJobModel.fromSnapshot(Map<String, dynamic> data) => PostJobModel(
        id: data["id"],
        userId: data["userId"],
        title: data["title"],
        createAt: data["createAt"],
        lowestsalary: data["lowestsalary"],
        highestsalary: data["highestsalary"],
        address: data["address"],
        experience: data["experience"],
        description: data["description"] ?? "",
        isDelete: data["isDelete"],
        // postJobDate: data["postJobDate"],
        deadline: data["deadline"],
        jobType: data["jobType"],
        gender: data["gender"],
        selectedSkills: data["selectedSkills"],
        selectedOption: data["selectedOption"],
        selectedSourceOption: data["selectedSourceOption"],
        applyCount: data['applyCount'] == null ? 0 : data['applyCount'],
      );
}
