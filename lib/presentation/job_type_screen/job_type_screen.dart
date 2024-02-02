import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/presentation/job_type_screen/widgets/jobtype_item_widget.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';

import '../confirmation_dialog/confirmation_dialog.dart';

class JobTypeScreen extends StatefulWidget {
  JobTypeScreen({Key? key}) : super(key: key);

  @override
  State<JobTypeScreen> createState() => _JobTypeScreenState();
}

class _JobTypeScreenState extends State<JobTypeScreen> {
  // Move the selectedJobType declaration here
  String selectedRole = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 34.v),
          child: Column(
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
              SizedBox(
                height: 234.v,
                child: JobtypeItemWidget(
                  onJobTypeSelected: (jobType) {
                    log("-----jobType-----$jobType");
                    // Update the selectedJobType variable
                    selectedRole = jobType;
                    setState(() {

                    });
                  },
                ),
              )            ],
          ),
        ),
        bottomNavigationBar: _buildContinue(context,selectedRole),
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

  Widget _buildContinue(BuildContext context,String selectedRole) {
    return CustomElevatedButton(
      text: "Continue",
      margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 55.v),
      onPressed: () {
        log("-----selectedRole-----$selectedRole");
        // Check if a job type is selected before proceeding
        if (selectedRole.isNotEmpty) {
          // Navigate to the next screen
          onTapContinue(context,selectedRole);
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

  onTapContinue(BuildContext context,String selectedRole) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: ConfirmationDialog(selectedRole:selectedRole ,),
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.only(left: 0),
        ));
  }
}
