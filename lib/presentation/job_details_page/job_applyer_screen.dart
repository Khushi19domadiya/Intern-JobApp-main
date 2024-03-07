import 'dart:io';
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
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("job_applications").doc(widget.jobId).get();

      if (documentSnapshot.exists) {
        jobData = documentSnapshot.data() as Map<String, dynamic>;
        fullNameController.text = jobData!['full_name'];
        emailController.text = jobData!['email'];
        frameOneController.text = jobData!['website_portfolio'];
        userId = jobData?["userId"];
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
        title: Text('Job Applyer Screen'),
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
                _buildPersonalInfoWebsite(context),
                SizedBox(height: 18.0),
                _buildCvFields(),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        text: 'Approve',
                        // child: Text('Approve'),
                        onPressed: () async {
                          String token = "";
                          allUserList.forEach((element) {
                            if (element.id == userId) {
                              token = (element.token ?? "");
                            }
                          });

                          // Add your approve logic here
                          Dio dio = Dio();
                          var url = 'https://fcm.googleapis.com/fcm/send';
//queryParameters will the parameter required by your API.
//In my case I had to send the headers also, which we can send using //Option parameter in request. Here are my headers Map:
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
                                "body": "You are approve for next process",
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
                        },
                        height: 46,
                      ),
                    ),
                    SizedBox(width: 16), // Add some spacing between the buttons
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
                        // child: Text('Reject'),
                        onPressed: () {
                          // Add your reject logic here
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
        Text("Full Name", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 9.0),
        Text(fullNameController.text, style: TextStyle(fontSize: 16.0)),
      ],
    );
  }

  Widget _buildPersonalInfoEmail(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 9.0),
        Text(emailController.text, style: TextStyle(fontSize: 16.0)),
      ],
    );
  }

  Widget _buildPersonalInfoWebsite(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Website, Blog, or Portfolio", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 9.0),
        Text(frameOneController.text, style: TextStyle(fontSize: 16.0)),
      ],
    );
  }

  Widget _buildCvFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload CV',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 7.0),
        SizedBox(
          height: 30.0, // Set the desired height
          width: 120.0, // Make the button take full width
          child: ElevatedButton(
            onPressed: () async {
              Get.to(() => PdfViewerPage(pdfUrl: jobData!['cv_url']));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black, // Set the button's background color
              onPrimary: Colors.white, // Set the text color
            ),
            child: Text('View CV'),
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
      users.add(UserModel.fromMap(doc.data())); // Assuming UserModel.fromJson is your model constructor
    });
    setState(() {
      allUserList = users;
    });
    // Proceed with the rest of your logic here
  }
}
