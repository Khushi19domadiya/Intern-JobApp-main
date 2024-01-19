import 'package:intl/intl.dart';

class UserModel {
  final String? id;
  final String email;
  final String password;
  final String confirmpassword;

  const UserModel( {
    this.id,
    required this.email,
    required this.password,
    required this.confirmpassword,
});
  toJson(){
    return{
      "id": id,
      "Email": email,
      "Password": password,
      "Confirm Password": confirmpassword,
    };
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
    required this.description,
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
  final List<String> selectedSkills;

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
    };
  }
}
