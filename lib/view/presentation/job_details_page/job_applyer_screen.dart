import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/model/job_app_model.dart';
import 'package:job_app/model/user_model.dart';
import 'package:job_app/utils/firebase_functions.dart';
import 'package:job_app/view/presentation/home_page/pdf_viewer_screen.dart';
import 'package:job_app/widgets/custom_elevated_button.dart';

class JobApplyerScreen extends StatefulWidget {
  final String jobId;

  JobApplyerScreen({required this.jobId});

  @override
  _ApplyJobScreenState createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<JobApplyerScreen> {
  JobApplicationModel? jobApplicationModel;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getModelValues();
    });
    // fetchAllUsers();
  }

  Future getModelValues() async {
    jobApplicationModel = await AppFunctions().getJobApplierData(widget.jobId);
    userModel = await AppFunctions().getUserData(jobApplicationModel!.userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Applier Screen'),
      ),
      body: jobApplicationModel == null || userModel == null
          ? Center(
              child: SizedBox(
                height: 50,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
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

                      (jobApplicationModel!.status == 0 || jobApplicationModel!.status == 1)
                          ? Row(
                        children: [
                          (jobApplicationModel!.status == 0)
                              ? Text("Application is already Rejected")
                              : Text("Application is already Approved"),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () async {
                              await AppFunctions()
                                  .updateApplicationStatus(
                                  docId: jobApplicationModel!.id,
                                  status: 2);
                              await getModelValues();
                            },
                            child: Text('Edit Status',
                            style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue),),
                          ),
                        ],
                      )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CustomElevatedButton(
                                    text: 'Approve',
                                    onPressed: () async {
                                      await AppFunctions()
                                          .updateApplicationStatus(
                                              docId: jobApplicationModel!.id,
                                              status: 1); // Approved
                                      sendNotification(userModel!.token!,
                                          'Your application has been approved.\nYou will be notified about the next steps.\nThank You.');
                                      Get.back();
                                    },
                                    height: 46,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: CustomElevatedButton(
                                    height: 46,
                                    buttonStyle: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          return Colors.red;
                                        },
                                      ),
                                    ),
                                    text: 'Reject',
                                    onPressed: () async {
                                      await AppFunctions()
                                          .updateApplicationStatus(
                                              docId: jobApplicationModel!.id,
                                              status: 0); // Approved

                                      sendNotification(userModel!.token!,
                                          'Your application is rejected. Better luck for the next time.\nThank You.');
                                      Get.back();
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

  Widget _buildPersonalInfoFullName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Full Name",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 9.0),
        Text('${userModel!.fname} ${userModel!.lname}',
            style: TextStyle(fontSize: 16.0)),
      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 9.0),
        Text(userModel!.email!, style: TextStyle(fontSize: 16.0)),
      ],
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
              Get.to(() => PdfViewerPage(pdfUrl: jobApplicationModel!.cvUrl));
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
            ),
            child: Text('View Resume'),
          ),
        ),
      ],
    );
  }

  // List<UserModel> allUserList = [];
  // fetchAllUsers() async {
  //   QuerySnapshot userDocs =
  //       await FirebaseFirestore.instance.collection('Users').get();
  //   List<UserModel> users = [];
  //   userDocs.docs.forEach((doc) {
  //     users.add(UserModel.fromSnapshot(doc.data() as Map<String, dynamic>));
  //   });
  //   setState(() {
  //     allUserList = users;
  //   });
  // }

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
