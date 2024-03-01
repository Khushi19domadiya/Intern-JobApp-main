import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  Map<String, dynamic>? jobData;

  @override
  void initState() {
    super.initState();
    fetchDocumentList();
  }

  Future<void> fetchDocumentList() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("job_applications")
          .doc(widget.jobId)
          .get();

      if (documentSnapshot.exists) {
        jobData = documentSnapshot.data() as Map<String, dynamic>;
        fullNameController.text = jobData!['full_name'];
        emailController.text = jobData!['email'];
        frameOneController.text = jobData!['website_portfolio'];
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

}
