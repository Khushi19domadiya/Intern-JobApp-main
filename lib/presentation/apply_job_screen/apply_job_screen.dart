import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/widgets/custom_text_form_field.dart';
import '../../theme/theme_helper.dart';
import '../../util/colors.dart';
import '../../util/common_methos.dart';
import '../home_container_screen/home_container_screen.dart';

class ApplyJobScreen extends StatefulWidget {
  final String jobId;

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
        String userId = user?.uid ?? 'unique_user_id';
        String cvFileName = 'cv_$userId.pdf';

        Reference storageReference = FirebaseStorage.instance.ref().child('cv_files/$cvFileName');
        UploadTask uploadTask = storageReference.putFile(cvFile!);
        await uploadTask.whenComplete(() => print('CV Uploaded'));

        String downloadURL = await storageReference.getDownloadURL();

        // Get a reference to the 'job_applications' collection
        CollectionReference jobApplications = FirebaseFirestore.instance.collection('job_applications');

        // Add a new document to the 'job_applications' collection
        DocumentReference docRef = await jobApplications.add({
          'full_name': fullNameController.text,
          'email': emailController.text,
          'website_portfolio': frameOneController.text,
          'cv_url': downloadURL,
          'timestamp': FieldValue.serverTimestamp(),
          'userId': user?.uid,
          'jobId':widget.jobId
        });


        var docApplyCount = FirebaseFirestore.instance.collection('postJob').doc(widget.jobId);

        FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(docApplyCount);

          // if (!snapshot.exists) {
          //   throw Exception("Document does not exist!"); // Handle case where document does not exist
          // }

          if (snapshot.data() is Map<String, dynamic> && (snapshot.data() as Map<String, dynamic>).containsKey('applyCount')) {
            var applyCount = snapshot.get('applyCount') ?? 0; // Get current apply count or default to 0
            applyCount++; // Increment apply count

            transaction.update(docApplyCount, {'applyCount': applyCount}); // Update document with new apply count
          } else {

            transaction.update(docApplyCount, {'applyCount': 1}); //
          }

        });



        // Now update the document with the job ID
        await docRef.update({'id': docRef.id});

        print('Job application data stored successfully');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Application submitted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeContainerScreen()),
        );
      } catch (error) {
        print('Error uploading CV or storing data: $error');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting application. Please try again later.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  _buildCvFields(context),
                  SizedBox(height: 16.0),
                  SizedBox(height: 270.0),
                  _buildContinueButton(),
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

  Widget _buildCvFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Upload CV", style: theme.textTheme.titleSmall),
        SizedBox(height: 7.v),
        DottedBorder(
          color: appTheme.gray300,
          padding: EdgeInsets.only(left: 1.h, top: 1.v, right: 1.h, bottom: 1.v),
          strokeWidth: 1.h,
          radius: Radius.circular(24),
          dashPattern: [6, 6],
          child: GestureDetector(
            onTap: () async {
              FilePickerResult? result;
              try {
                result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );
              } on Exception catch (e) {
                print('File picker error: $e');
              }
              if (result != null && result.files.isNotEmpty) {
                setState(() {
                  cvFile = File(result?.files.first.path ?? '');
                });
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 124.h, vertical: 39.v),
              decoration: AppDecoration.outlineGray300.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgCloudUpload1,
                    height: 40.adaptSize,
                    width: 40.adaptSize,
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    "Upload File",
                    style: CustomTextStyles.titleSmallSemiBold,
                  ),
                  if (cvFile != null)
                    Text(
                      'Selected CV: ${cvFile!.path}',
                      style: TextStyle(color: Colors.black),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return CustomElevatedButton(
      text: 'Continue',
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          await _uploadCV();
        }
      },
    );
  }
}
