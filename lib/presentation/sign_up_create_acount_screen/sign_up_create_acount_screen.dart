
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/util/colors.dart';
import 'package:saumil_s_application/util/common_methos.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/widgets/custom_outlined_button.dart';
import 'package:saumil_s_application/widgets/custom_text_form_field.dart';


import '../../controller/authController.dart';
import '../sign_up_complete_account_screen/sign_up_complete_account_screen.dart';

// ignore_for_file: must_be_immutable
class SignUpCreateAcountScreen extends StatelessWidget {
  SignUpCreateAcountScreen({Key? key}) : super(key: key);

  // TextEditingController emailController = TextEditingController();

  // GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var controller = Get.put(AuthController());

  var  collection = FirebaseFirestore.instance.collection("register");
  User? userId = FirebaseAuth.instance.currentUser;
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.h, vertical: 31.v),
                          child: Column(children: [
                            Text("Create account",
                                style: theme.textTheme.headlineSmall),
                            SizedBox(height: 11.v),
                            Text("Lorem ipsum dolor sit amet",
                                style: CustomTextStyles.titleMediumBluegray400),
                            SizedBox(height: 28.v),
                            CustomOutlinedButton(
                                text: "Continue with Google",
                                onPressed: () {
                                  controller.handleSignInGoogle();
                                },
                                leftIcon: Container(
                                    margin: EdgeInsets.only(right: 12.h),
                                    child: CustomImageView(
                                        imagePath:
                                        ImageConstant.imgGooglesymbol1,
                                        height: 23.v,
                                        width: 24.h))),
                            // SizedBox(height: 16.v),
                            // CustomOutlinedButton(
                            //     text: "Continue with Apple",
                            //     leftIcon: Container(
                            //         margin: EdgeInsets.only(right: 12.h),
                            //         child: CustomImageView(
                            //             imagePath: ImageConstant.imgIconApple,
                            //             height: 24.adaptSize,
                            //             width: 24.adaptSize))),
                            SizedBox(height: 26.v),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 33.h),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.v),
                                            child: SizedBox(
                                              // width: 62.h,
                                                child: Divider(
                                                    color:
                                                    appTheme.blueGray100))),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 12.h),
                                          child: Text("Or continue with",
                                              style: CustomTextStyles
                                                  .titleSmallGray500SemiBold_1)),
                                      Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.v),
                                            child: SizedBox(
                                              // width: 74.h,
                                                child: Divider(indent: 12.h))),
                                      )
                                    ])),
                            SizedBox(height: 28.v),
                            _buildInputField(context),
                            SizedBox(height: 20.v),
                            _buildInputField1(context),

                            SizedBox(height: 20.v),
                            _buildInputField2(context),
                            SizedBox(height: 30.v),

                            // CustomElevatedButton(
                            //     text: "Continue with Email",
                            //     onPressed: () async {
                            //       await controller.registerWithEmailAndPassword(context);
                            //       await onTapContinueWithEmail(context);
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 SignUpCompleteAccountScreen()),
                            //       );
                            //     }),
                            CustomElevatedButton(
                              text: "Continue with Email",
                              onPressed: () async {
                                //   await controller.registerWithEmailAndPassword(context);
                                //   await onTapContinueWithEmail(context);

                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => SignUpCompleteAccountScreen(),
                                //     ),
                                //   );
                                if (controller.emailController.text.isEmpty) {
                                    CommonMethod().getXSnackBar(
                                        'Error', 'Please enter email', red);

                                } else if (!emailRegex.hasMatch(
                                    controller.emailController.text)) {
                                  CommonMethod().getXSnackBar(
                                      'Error', 'Please enter valid email', red);
                                } else if (controller
                                    .passwordController.text.isEmpty) {
                                  CommonMethod().getXSnackBar(
                                      'Error', 'Please enter password', red);
                                } else if (controller
                                    .confirmPasswordController.text.isEmpty) {
                                  CommonMethod().getXSnackBar('Error',
                                      'Please enter confirm password', red);
                                } else if (controller.passwordController.text !=
                                    controller.confirmPasswordController.text) {
                                  CommonMethod().getXSnackBar(
                                      'Error', 'Passwords do not match!', red);
                                } else {
                                await  controller
                                      .registerWithEmailAndPassword(context);
                                }

                              },
                            ),

                            SizedBox(height: 28.v),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40.h),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text("Already have an account?",
                                            style: CustomTextStyles
                                                .titleMediumGray500),
                                      ),
                                      // Expanded(
                                      //   child: GestureDetector(
                                      //       onTap: () {
                                      //         onTapTxtLargeLabelMedium(context);
                                      //       },
                                      //       child: Padding(
                                      //           padding:
                                      //               EdgeInsets.only(left: 3.h),
                                      //           child: Text(
                                      //             " Login",
                                      //             style: theme
                                      //                 .textTheme.titleMedium,
                                      //           ))),
                                      // )
                                    ])),

                            GestureDetector(
                                onTap: () {
                                  onTapTxtLargeLabelMedium(context);
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(left: 3.h),
                                    child: Text(
                                      " Login",
                                      style: theme.textTheme.titleMedium,
                                    ))),
                            SizedBox(height: 84.v),

                            Container(
                                width: 245.h,
                                margin: EdgeInsets.symmetric(horizontal: 40.h),
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                          "By signing up you agree to our ",
                                          style: CustomTextStyles
                                              .titleSmallGray500SemiBold),
                                      TextSpan(
                                          text: "Terms",
                                          style: CustomTextStyles
                                              .titleSmallBlack900),
                                      TextSpan(
                                          text: " and ",
                                          style: CustomTextStyles
                                              .titleSmallGray500SemiBold),
                                      TextSpan(
                                          text: "Conditions of Use",
                                          style: CustomTextStyles
                                              .titleSmallBlack900)
                                    ]),
                                    textAlign: TextAlign.center)),
                            SizedBox(height: 8.v)
                          ])),
                    ],
                  ),
                ),
              ],
            )));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 48.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgComponent1,
            margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 13.v),
            onTap: () {
              onTapImage(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgComponent3,
              margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v))
        ]);
  }

  /// Section Widget
  Widget _buildInputField(BuildContext context) {
    return Container(
        decoration:
        BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Email", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(
              controller: controller.emailController,
              hintText: "Enter your email address",
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.emailAddress)
        ]));
  }

  /// Section Widget
  Widget _buildInputField1(BuildContext context) {
    return Container(
        decoration:
        BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Password", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(
              controller: controller.passwordController,
              hintText: "Enter password",
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.emailAddress)
        ]));
  }

  /// Section Widget
  Widget _buildInputField2(BuildContext context) {
    return Container(
        decoration:
        BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Confirm Password", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(
              controller: controller.confirmPasswordController,
              hintText: "Enter confirm password",
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.emailAddress)
        ]));
  }

  /// Navigates back to the previous screen.
  onTapImage(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the signUpCompleteAccountScreen when the action is triggered.
  onTapContinueWithEmail(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }


  /// Navigates to the loginScreen when the action is triggered.
  onTapTxtLargeLabelMedium(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
