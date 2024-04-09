import 'package:cloud_firestore/cloud_firestore.dart';

class JobApplicationModel {
  String cvUrl;
  String email;
  String fullName;
  String id;
  String jobId;
  DateTime timestamp;
  String userId;
  String websitePortfolio;
  int status;

  JobApplicationModel({
    required this.cvUrl,
    required this.email,
    required this.fullName,
    required this.id,
    required this.jobId,
    required this.timestamp,
    required this.userId,
    required this.websitePortfolio,
    required this.status,
  });

  factory JobApplicationModel.fromSnapshot(Map<String, dynamic> json) => JobApplicationModel(
    cvUrl: json["cv_url"],
    email: json["email"],
    fullName: json["full_name"],
    id: json["id"],
    jobId: json["jobId"],
    timestamp: (json["timestamp"] as Timestamp).toDate(),
    userId: json["userId"],
    websitePortfolio: json["website_portfolio"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "cv_url": cvUrl,
    "email": email,
    "full_name": fullName,
    "id": id,
    "jobId": jobId,
    "timestamp": timestamp,
    "userId": userId,
    "website_portfolio": websitePortfolio,
    "status": status,
  };
}