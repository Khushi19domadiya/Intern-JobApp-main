import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/presentation/home_page/pdf_viewer_screen.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';

class JobApplyerScreen extends StatefulWidget {
  final String jobId;

  JobApplyerScreen({required this.jobId});

  @override
  _ApplyJobScreenState createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<JobApplyerScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController frameOneController = TextEditingController();
  String userId = "";

  Map<String, dynamic>? jobData;

  @override
  void initState() {
    super.initState();
    fetchDocumentList();
    fetchAllUsers();
  }

  Future<void> fetchDocumentList() async {
    print("jobID ${widget.jobId}");
    try {

      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("job_applications")
          .where('id', isEqualTo: widget.jobId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // print(jobData!['full_name']);
        jobData = snapshot as Map<String, dynamic>;
        // fullNameController.text = jobData!['full_name'];
        // emailController.text = jobData!['email'];
        // frameOneController.text = jobData!['website_portfolio'];
        print("data: $jobData");
        userId = jobData?["userId"];
        print("usr: $userId");
        setState(() {});
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print("Error fetching document: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Applier Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            padding: EdgeInsets.only(top: 20.0), // Add padding from top
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPersonalInfoFullName(context),
                SizedBox(height: 18.0),
                _buildPersonalInfoEmail(context),
                SizedBox(height: 18.0),
                // _buildPersonalInfoWebsite(context),
                // SizedBox(height: 18.0),
                _buildCvFields(),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        text: 'Approve',
                        onPressed: () async {
                          String token = "";
                          String currentStatus = "";

                          allUserList.forEach((element) {
                            if (element.userId == userId) {
                              currentStatus = element.status ?? "";
                              token = element.token ?? "";
                            }
                          });

                          if (currentStatus == 'A' || currentStatus == 'R') {
                              print("current status ${currentStatus}");
                              print("current user ${userId}");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(

                                content: Text('You have already been processed for this job application.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            await FirebaseFirestore.instance.collection('Applications').doc(widget.jobId).update({'status': 'A'});
                            sendNotification(token, 'Your application has been approved. You will be notified about the next steps.');
                            Get.back();
                          }

                        },
                        height: 46,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: CustomElevatedButton(
                        height: 46,
                        buttonStyle: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return Colors.red;
                            },
                          ),
                        ),
                        text: 'Reject',
                        onPressed: () async {
                          String token = "";
                          String currentStatus = "";

                          allUserList.forEach((element) {
                            if (element.userId == userId) {
                              currentStatus = element.status ?? "";
                              token = element.token ?? "";
                            }
                          });

                          if (currentStatus == 'A' || currentStatus == 'R') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('You have already been processed for this job application.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            FirebaseFirestore.instance.collection('Applications').doc(widget.jobId).update({'status': 'R'});
                            sendNotification(token, 'You are rejected for the next process');
                            Get.back();
                          }
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildPersonalInfoFullName(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text("Full Name", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
  //       SizedBox(height: 9.0),
  //       Text(userId, style: TextStyle(fontSize: 16.0)),
  //     ],
  //   );
  // }

  Widget _buildPersonalInfoFullName(BuildContext context) {
    print("UserID: $userId");
    if (userId.isEmpty) {
      return Text("User ID is empty");
    }
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Users').doc(userId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // or any loading indicator widget
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('User not found');
        }

        // Extract first name and last name from user document
        Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
        // String firstName = userData['fname'] ?? '';
        // String lastName = userData['lname'] ?? '';
        String fullName = '${userData['fname']} ${userData['lname']}';


        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Full Name", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 9.0),
            Text(fullName, style: TextStyle(fontSize: 16.0)),
          ],
        );
      },
    );
  }



  // Widget _buildPersonalInfoEmail(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text("Email", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
  //       SizedBox(height: 9.0),
  //       Text(emailController.text, style: TextStyle(fontSize: 16.0)),
  //     ],
  //   );
  // }

  Widget _buildPersonalInfoEmail(BuildContext context) {
    if (userId.isEmpty) {
      return Text("User ID is empty");
    }
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('Applications').doc(widget.jobId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // or any loading indicator widget
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Text('User not found');
        }

        // Extract email from user document
        Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
        String email = userData['email'] ?? '';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 9.0),
            Text(email, style: TextStyle(fontSize: 16.0)),
          ],
        );
      },
    );
  }



  bool isValidUrl = true; // Flag to track if URL is valid


  Widget _buildCvFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Click below button for download Resume',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 7.0),
        SizedBox(
          height: 46.0,
          width: 120.0,
          child: ElevatedButton(
            onPressed: () async {
              Get.to(() => PdfViewerPage(pdfUrl: jobData!['cv_url']));
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.black,
            ),
            child: Text('View Resume'),
          ),
        ),
      ],
    );
  }




  List<UserModel> allUserList = [];
  fetchAllUsers() async {
    QuerySnapshot userDocs = await FirebaseFirestore.instance.collection('Users').get();
    List<UserModel> users = [];
    userDocs.docs.forEach((doc) {
      users.add(UserModel.fromSnapshot(doc.data() as Map<String, dynamic>));
    });
    setState(() {
      allUserList = users;
    });
  }

  void sendNotification(String token, String message) async {
    Dio dio = Dio();
    var url = 'https://fcm.googleapis.com/fcm/send';
    var headers = {
      'Content-type': 'application/json; charset=utf-8',
      "Authorization":
      "key=AAAA1QAzqrM:APA91bEEnfurICv3y2DkrX1qZRk0gUUHjkv-VH8UVpb2MBNzpMfdx50Xo3_LZCrTGaA6j89mFZfSB7NOyntJAUME-wxHSO5oqFb0SvuBlMw5b56YE_Yv3858xmrp3Ub5eSXcncRV4b_p"
    };
    var responce = await dio.post(
      url,
      data: {
        "notification": {
          "title": "Job App",
          "body": message,
          "sound": "default"
        },
        "priority": "High",
        "to": token,
      },
      options: Options(headers: headers),
    );
    if (responce.statusCode == 200) {
      print("-dfdf----${responce.data.toString}");
      Get.back();
    }
  }
}
