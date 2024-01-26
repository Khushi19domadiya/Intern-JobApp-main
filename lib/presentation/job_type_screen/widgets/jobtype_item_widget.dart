import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/custom_icon_button.dart';

import '../../../controller/authController.dart';

class JobtypeItemWidget extends StatefulWidget {
  const JobtypeItemWidget({Key? key}) : super(key: key);

  @override
  _JobtypeItemWidgetState createState() => _JobtypeItemWidgetState();
}

class _JobtypeItemWidgetState extends State<JobtypeItemWidget> {
  String selectedJobType = '';
  AuthController authController = AuthController();


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildJobTypeContainer(
          imagePath: ImageConstant.imgWork,
          title: "Find a job",
          description: "It’s easy to find your dream jobs here with us.",
          jobType: "j",
        ),
        SizedBox(width: 10.h), // Add spacing between containers
        _buildJobTypeContainer(
          imagePath: ImageConstant.imgWork,
          title: "Find an employee",
          description: "It's easy to find an employee.",
          jobType: "e",
        ),
      ],
    );
  }

  Widget _buildJobTypeContainer({
    required String imagePath,
    required String title,
    required String description,
    required String jobType,
  }) {
    return InkWell(
      onTap: () async {
        setState(() {
          selectedJobType = jobType;
        });

        // Perform Firebase operation
        await _storeSelectedJobTypeInFirebase(selectedJobType);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 17.h,
          vertical: 20.v,
        ),
        decoration: AppDecoration.outlinePrimary.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder24,
          border: Border.all(
            color: selectedJobType == jobType
                ? theme.colorScheme.primary
                : Colors.transparent,
          ),
        ),
        width: 156.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 2.v),
            CustomIconButton(
              height: 54.adaptSize,
              width: 64.adaptSize,
              padding: EdgeInsets.all(16.h),
              decoration: IconButtonStyleHelper.fillGrayTL16,
              child: CustomImageView(
                imagePath: imagePath,
              ),
            ),
            SizedBox(height: 29.v),
            Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 9.v),
            SizedBox(
              width: 120.h,
              child: Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.labelLargeGray500_1.copyWith(
                  height: 1.67,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _storeSelectedJobTypeInFirebase(String selectedJobType) async {
    try {
      await Firebase.initializeApp(); // Initialize Firebase if not initialized

      // Fetch the email of the logged-in user
      String? loggedInUserEmail = authController.getLoggedInUserEmail();

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

}
