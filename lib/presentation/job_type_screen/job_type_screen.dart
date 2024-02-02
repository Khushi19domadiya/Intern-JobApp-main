import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/presentation/job_type_screen/widgets/jobtype_item_widget.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';

import '../../controller/authController.dart';
import '../confirmation_dialog/confirmation_dialog.dart';

// Import JobtypeItemWidget here

class JobTypeScreen extends StatelessWidget {
   JobTypeScreen({Key? key}) : super(key: key);

  // Move the selectedJobType declaration here
  String selectedJobType = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 34.v),
          child: Expanded(
            child: ListView(
              children: [
                Column(
                  children: [
                    Text("Choose Job Type", style: theme.textTheme.headlineSmall),
                    SizedBox(height: 7.v),
                    SizedBox(
                      width: 209.h,
                      child: Text(
                        "Are you looking for a new job or looking for a new employee",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: CustomTextStyles.titleSmallBluegray400.copyWith(height: 1.57),
                      ),
                    ),
                    SizedBox(height: 37.v),
                    _buildJobType(context),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildContinue(context),
      ),
    );
  }
  

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgComponent1,
        margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 13.v),
        onTap: () {
          onTapImage(context);
        },
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgComponent3,
          margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v),
        ),
      ],
    );
  }

  Widget _buildJobType(BuildContext context) {
    return SizedBox(
      height: 234.v,
      child: JobtypeItemWidget(
        onJobTypeSelected: (jobType) {
          // Update the selectedJobType variable
          selectedJobType = jobType;
        },
      ),
    );
  }

  Widget _buildContinue(BuildContext context) {
    return CustomElevatedButton(
      text: "Continue",
      margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 55.v),
      onPressed: () async {
        // Check if a job type is selected before navigating
        if (selectedJobType.isNotEmpty) {
          // Store the selected job type along with the email in Firestore
          await _storeSelectedJobTypeInFirebase(selectedJobType);
          // Navigate to the next screen
          onTapContinue(context);
        } else {
          // Show an error message or handle the case when no job type is selected
          print("Error: No job type selected");
        }
      },
    );
  }

  onTapImage(BuildContext context) {
    Navigator.pop(context);
  }

  onTapContinue(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: ConfirmationDialog(),
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.only(left: 0),
        ));
  }  }

  Future<void> _storeSelectedJobTypeInFirebase(String selectedJobType) async {
    try {
      await Firebase.initializeApp(); // Initialize Firebase if not initialized

      // Fetch the email of the logged-in user using your authController
      String? loggedInUserEmail = AuthController().getLoggedInUserEmail();

      // Ensure the email is not null before proceeding
      if (loggedInUserEmail != null) {
        // Assuming you have a 'job_types' collection in Firestore
        await FirebaseFirestore.instance.collection('job_types').add({
          'selected_job_type': selectedJobType,
          'timestamp': FieldValue.serverTimestamp(),
          'Email': loggedInUserEmail,
        });

        print('Selected job type and user email stored in Firebase: $selectedJobType, $loggedInUserEmail');
      } else {
        print('Error: Logged-in user email is null.');
      }
    } catch (e) {
      print('Error storing selected job type and user email: $e');
    }
  }

