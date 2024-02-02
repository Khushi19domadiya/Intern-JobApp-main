import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 331.h,
      padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 39.v),
      decoration: AppDecoration.fillWhiteA
          .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 3.v),
          SizedBox(
            width: 279.h,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "I agree to the ",
                    style: CustomTextStyles.titleMediumGray500_1,
                  ),
                  TextSpan(
                    text: "Terms of Service",
                    style: theme.textTheme.titleMedium,
                  ),
                  TextSpan(
                    text: " and ",
                    style: CustomTextStyles.titleMediumGray500_1,
                  ),
                  TextSpan(
                    text: "Conditions of Use",
                    style: theme.textTheme.titleMedium,
                  ),
                  TextSpan(
                    text:
                    " including consent to electronic communications and I affirm that the information provided is my own.",
                    style: CustomTextStyles.titleMediumGray500_1,
                  )
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 17.v),
          CustomElevatedButton(
            height: 54.v,
            width: 181.h,
            text: "Agree and continue",
            buttonTextStyle:
            CustomTextStyles.titleSmallOnPrimaryContainerSemiBold,
            onPressed: () {
              onTapAgreeAndContinue(context);
            },
          ),
          SizedBox(height: 24.v),
          CustomElevatedButton(
            height: 54.v,
            width: 181.h,
            text: "Disagree",
            buttonTextStyle: CustomTextStyles.titleSmallOnPrimary,
            onPressed: () {
              // Updated logic: Redirect to the 'specializationScreen' when the user disagrees
              Navigator.pushNamed(
                  context, AppRoutes.speciallizationScreen);
            },
          ),
        ],
      ),
    );
  }

  /// Check Firestore and redirect accordingly
  void onTapAgreeAndContinue(BuildContext context) async {
    try {
      // Assuming 'job_types' is the collection name in Firestore
      final snapshot =
      await FirebaseFirestore.instance.collection('job_types').get();

      // Check if there is any document in the collection
      if (snapshot.docs.isNotEmpty) {
        // Iterate through documents
        for (final document in snapshot.docs) {
          // Check if the stored job type is 'j'
          if (document['selected_job_type'] == 'j') {
            // Redirect to the profile page
            Navigator.pushNamed(context, AppRoutes.savedPage);
            return; // Stop iterating since we found a match
          }
          // Check if the stored job type is 'e'
          else if (document['selected_job_type'] == 'e') {
            // Redirect to the settings screen
            Navigator.pushNamed(context, AppRoutes.homeContainerScreen);
            return; // Stop iterating since we found a match
          }
          // Handle other cases if needed
        }
      }

      // If no match is found, redirect to the 'speciallizationScreen'
      Navigator.pushNamed(context, AppRoutes.speciallizationScreen);
    } catch (e) {
      print('Error checking Firestore: $e');
    }
  }

}
