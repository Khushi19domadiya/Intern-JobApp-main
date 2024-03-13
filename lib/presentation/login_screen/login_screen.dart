import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saumil_s_application/aDMIN/admin_home_screen.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/presentation/home_page/admin_screen.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/widgets/custom_outlined_button.dart';
import 'package:saumil_s_application/widgets/custom_text_form_field.dart';

import '../../controller/authController.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var controller = Get.put(AuthController());

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.h, vertical: 31.v),
                            child: Column(children: [
                              Text("Hi, Welcome Back! 👋",
                                  style: theme.textTheme.headlineSmall),
                              SizedBox(height: 11.v),
                              Text("Lorem ipsum dolor sit amet",
                                  style: CustomTextStyles.titleSmallGray500),
                              SizedBox(height: 31.v),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 33.h),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.v),
                                            child: SizedBox(
                                                width: 40.h,
                                                child: Divider(color:
                                            appTheme.blueGray100))),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 12.h),
                                            child: Text("Or continue with",
                                                style: CustomTextStyles
                                                    .titleSmallGray500SemiBold_1)),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.v),
                                            child: SizedBox(
                                                width: 74.h,
                                                child: Divider(indent: 12.h)))
                                      ])),
                              SizedBox(height: 28.v),
                              _buildInputField(context),
                              SizedBox(height: 40.v),
                              CustomElevatedButton(text: "Continue with Email",
                              onPressed: (){
                                // controller
                                //     .signInWithEmailAndPassword(context);

                                if (emailController.text.toString().toLowerCase() == "admin@gmail.com" && passwordController.text.toString().toLowerCase() == "admin@123") {
                                  // Navigate to the admin screen
                                  // Navigator.push(
                                  print("-------------------${emailController.text.toString()}-------------------");
                                  print("-------------------${passwordController.text.toString()}-------------------");
                                    Get.to(()=> AdminHomeScreen());
                                  // );
                                } else {
                                  // For other users, perform the login operation
                                  controller.signInWithEmailAndPassword(context);
                                }
                              },),

                              SizedBox(height: 26.v),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 41.h),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 1.v),
                                            child: Text(
                                                "Don’t have an account?",
                                                style: CustomTextStyles
                                                    .titleMediumGray500)),
                                        // ),
                                        // GestureDetector(
                                        //     onTap: () {
                                        //       onTapTxtLargeLabelMedium(context);
                                        //     },
                                        //     child: Padding(
                                        //         padding:
                                        //             EdgeInsets.only(left: 2.h),
                                        //         child: Text(" Sign up",
                                        //             style: theme.textTheme
                                        //                 .titleMedium)))
                                      ])),
                              GestureDetector(
                                  onTap: () {
                                    onTapTxtLargeLabelMedium(context);
                                  },
                                  child: Padding(
                                      padding:
                                      EdgeInsets.only(left: 2.h),
                                      child: Text(" Sign up",
                                          style: theme.textTheme
                                              .titleMedium))),

                              SizedBox(height: 84.v),
                              Container(
                                  width: 245.h,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 40.h),
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
                              SizedBox(height: 9.v)
                            ])))))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        // leadingWidth: 48.h,
        // leading: AppbarLeadingImage(
        //     imagePath: ImageConstant.imgComponent1,
        //     margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 13.v),
        //     onTap: () {
        //       onTapImage(context);
        //     }),
        // actions: [
        //   AppbarTrailingImage(
        //       imagePath: ImageConstant.imgComponent3,
        //       margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v))
        // ]
        );
  }

  /// Section Widget
  /// Section Widget
  Widget _buildInputField(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(
            controller: emailController,
            hintText: "Enter your email address",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16.v),
          Text("Password", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(
            // You can use a different controller for the password field if needed
            controller: passwordController,
            hintText: "Enter your password",
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
          ),
        ],
      ),
    );
  }


  /// Navigates back to the previous screen.
  onTapImage(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the signUpCreateAcountScreen when the action is triggered.
  onTapTxtLargeLabelMedium(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpCreateAcountScreen);
  }
}
