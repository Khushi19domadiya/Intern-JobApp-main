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
