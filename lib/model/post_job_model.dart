class JobPostModel {
  String about;
  String address;
  int applyCount;
  String createAt;
  String experience;
  String highestSalary;
  String id;
  int isDelete;
  String jobType;
  String lowestSalary;
  String selectedOption;
  List<String> selectedSkills;
  String selectedSourceOption;
  String title;
  String userId;

  JobPostModel({
    required this.about,
    required this.address,
    required this.applyCount,
    required this.createAt,
    required this.experience,
    required this.highestSalary,
    required this.id,
    required this.isDelete,
    required this.jobType,
    required this.lowestSalary,
    required this.selectedOption,
    required this.selectedSkills,
    required this.selectedSourceOption,
    required this.title,
    required this.userId,
  });

  factory JobPostModel.fromJson(Map<String, dynamic> json) => JobPostModel(
    about: json["about"],
    address: json["address"],
    applyCount: json["applyCount"],
    createAt: json["createAt"],
    experience: json["experience"],
    highestSalary: json["highestsalary"],
    id: json["id"],
    isDelete: json["isDelete"],
    jobType: json["jobType"],
    lowestSalary: json["lowestsalary"],
    selectedOption: json["selectedOption"],
    selectedSkills: List<String>.from(json["selectedSkills"].map((x) => x)),
    selectedSourceOption: json["selectedSourceOption"],
    title: json["title"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "about": about,
    "address": address,
    "applyCount": applyCount,
    "createAt": createAt,
    "experience": experience,
    "highestsalary": highestSalary,
    "id": id,
    "isDelete": isDelete,
    "jobType": jobType,
    "lowestsalary": lowestSalary,
    "selectedOption": selectedOption,
    "selectedSkills": List<dynamic>.from(selectedSkills.map((x) => x)),
    "selectedSourceOption": selectedSourceOption,
    "title": title,
    "userId": userId,
  };
}