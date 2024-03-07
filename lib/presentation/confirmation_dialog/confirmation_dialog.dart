import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/servies/firebase_messing.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';

import '../../models/personal_information.dart';

class ConfirmationDialog extends StatelessWidget {
  final String selectedRole;
  const ConfirmationDialog({Key? key,required this.selectedRole}) : super(key: key);

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
            onPressed: () async {
              User? currentUser = FirebaseAuth.instance.currentUser;
              if(currentUser != null){
                log("-----11----selectedRole----11---->>>>> ${selectedRole.toString()}");
                await StoreData().addOrUpdateUserData(UserModel(id: currentUser.uid, email: currentUser.email.toString(),role: selectedRole,token: storage.read("fcmToken")));
                Navigator.pushNamed(
                    context, AppRoutes.homeContainerScreen);
              }

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
                  context, AppRoutes.jobTypeScreen);
            },
          ),
        ],
      ),
    );
  }

  /// Check Firestore and redirect accordingly

}
