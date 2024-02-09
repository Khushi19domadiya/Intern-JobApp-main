import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/widgets/custom_text_form_field.dart';
import '../../theme/theme_helper.dart';
import '../../util/colors.dart';
import '../../util/common_methos.dart';
import '../home_container_screen/home_container_screen.dart';

class ApplyJobScreen extends StatefulWidget {

  String jobId;
  ApplyJobScreen({required this.jobId});


  @override
  _ApplyJobScreenState createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController frameOneController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? cvFile;

  Future<void> _uploadCV() async {
    if (cvFile != null) {
      try {
        String userId = 'unique_user_id'; // Replace with your user ID or fetch dynamically
        String cvFileName = 'cv_$userId.pdf';

        // Upload CV to Firebase Cloud Storage
        Reference storageReference =
        FirebaseStorage.instance.ref().child('cv_files/$cvFileName');
        UploadTask uploadTask = storageReference.putFile(cvFile!);
        await uploadTask.whenComplete(() => print('CV Uploaded'));

        // Get the download URL of the uploaded CV
        String downloadURL = await storageReference.getDownloadURL();

        // Store user data including CV download URL in Firestore
        await FirebaseFirestore.instance.collection('job_applications').add({
          'full_name': fullNameController.text,
          'email': emailController.text,
          'website_portfolio': frameOneController.text,
          'cv_url': downloadURL,
          'timestamp': FieldValue.serverTimestamp(),
          'userId':user!.uid,
          'jobId':widget.jobId
        });

        print('Job application data stored successfully');
      } catch (error) {
        print('Error uploading CV or storing data: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Apply Job'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildPersonalInfoFullName(context),
                  SizedBox(height: 18.0),
                  _buildPersonalInfoEmail(context),
                  SizedBox(height: 18.0),
                  _buildPersonalInfoWebsite(context),
                  SizedBox(height: 18.0),
                  _buildCvFields(),
                  SizedBox(height: 16.0),
                  SizedBox(height: 270.0),
                  _buildContinueButton(),
                  // Adjusted spacing
                ],
              ),
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
        Text("Full Name", style: theme.textTheme.titleSmall),
        SizedBox(height: 9.0),
        CustomTextFormField(
          controller: fullNameController,
          hintText: "Enter Your Full Name",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your full name';
            } else if (!value.startsWith(RegExp(r'[A-Z]'))) {
              return 'First character should start with a capital letter';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPersonalInfoEmail(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Email", style: theme.textTheme.titleSmall),
        SizedBox(height: 9.0),
        CustomTextFormField(
          controller: emailController,
          hintText: "xyz@gmail.com",
          readOnly: false,
          textInputType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            } else if (!GetUtils.isEmail(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPersonalInfoWebsite(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Website, Blog, or Portfolio", style: theme.textTheme.titleSmall),
        SizedBox(height: 9.0),
        CustomTextFormField(
          controller: frameOneController,
          hintText: "Website, Blog, or Portfolio",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your Website, Blog, or Portfolio name';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCvFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Upload CV', style: theme.textTheme.titleSmall), // Adjusted label
        SizedBox(height: 7.0),
        ElevatedButton(
          onPressed: () async {
            FilePickerResult? result;
            try {
              result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf'],
              );
            } on Exception catch (e) {
              // Handle exception, if any
              print('File picker error: $e');
            }
            if (result != null) {
              //setState(() {
              cvFile = File(result!.files.single.path!);
            }
            else if(cvFile != null)
            {
              Text(
                'Please select a CV file',
                style: TextStyle(color: Colors.red),
              );
            }
          },
          child: Text('Select CV'),
        ),
        // if (cvFile != null)
        //   Text('Selected CV: ${cvFile!.path}'),
      ],
    );
  }


  Widget _buildContinueButton() {
    return CustomElevatedButton(
      text: 'Continue',
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          // Validate successful, perform the CV upload and data storage
          await _uploadCV();
        }
      },
    );
  }


}