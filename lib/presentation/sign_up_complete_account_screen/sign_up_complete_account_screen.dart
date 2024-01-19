import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/widgets/custom_text_form_field.dart';

import '../job_type_screen/job_type_screen.dart';

// ignore_for_file: must_be_immutable
class SignUpCompleteAccountScreen extends StatelessWidget {
  SignUpCompleteAccountScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(
                context
            ),
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
                                horizontal: 24.h, vertical: 34.v),
                            child: Column(children: [
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 15.h),
                                      child: Text("Complete your account",
                                          style:
                                          theme.textTheme.headlineSmall))),
                              SizedBox(height: 9.v),
                              Text("Lorem ipsum dolor sit amet",
                                  style:
                                  CustomTextStyles.titleSmallBluegray400),
                              SizedBox(height: 33.v),
                              _buildInputFieldEmail(context),
                              SizedBox(height: 18.v),
                              _buildInputFieldLastName(context),
                              SizedBox(height: 18.v),
                              // _buildInputFieldPassword(context),
                              // SizedBox(height: 16.v),
                              // _buildDropdown(context),
                              SizedBox(height: 40.v),
                              CustomElevatedButton(text: "Continue with Email",
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)=>JobTypeScreen()),
                                  );
                                },
                              ),
                              SizedBox(height: 28.v),
                              Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 40.h),
                                  child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text("Already have an account?",
                                              style: CustomTextStyles
                                                  .titleMediumGray500),
                                        ),

                                      ])),
                              GestureDetector(
                                  onTap: () {
                                    onTapTxtLargeLabelMedium(context);
                                  },
                                  child: Padding(
                                      padding:
                                      EdgeInsets.only(left: 3.h),
                                      child: Text(" Login",
                                          style: theme.textTheme
                                              .titleMedium))),
                              SizedBox(height: 19.v),
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
                              SizedBox(height: 5.v)
                            ])))))));
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
  Widget _buildInputFieldEmail(BuildContext context) {
    return Container(
        decoration:
        BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Email", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(
              controller: emailController, hintText: "Enter your first name")
        ]));
  }

  /// Section Widget
  Widget _buildInputFieldLastName(BuildContext context) {
    return Container(
        decoration:
        BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Last Name", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(
              controller: lastNameController, hintText: "Enter your last name")
        ]));
  }

  /// Section Widget
  Widget _buildInputFieldPassword(BuildContext context) {
    return Container(
        decoration:
        BoxDecoration(borderRadius: BorderRadiusStyle.roundedBorder8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Password", style: theme.textTheme.titleSmall),
          SizedBox(height: 9.v),
          CustomTextFormField(
            // controller: passwordController,
              hintText: "Create a password",
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              suffix: Container(
                  margin: EdgeInsets.fromLTRB(30.h, 14.v, 16.h, 14.v),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgHide,
                      height: 24.adaptSize,
                      width: 24.adaptSize)),
              suffixConstraints: BoxConstraints(maxHeight: 52.v),
              obscureText: true,
              contentPadding:
              EdgeInsets.only(left: 16.h, top: 15.v, bottom: 15.v))
        ]));
  }

  /// Section Widget
  Widget _buildDropdown(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 11.v),
        decoration: AppDecoration.outlineGray
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder24),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
              padding: EdgeInsets.only(top: 5.v),
              child: Text("Select a country",
                  style: CustomTextStyles.titleMediumMedium_1)),
          CustomImageView(
              imagePath: ImageConstant.imgArrowRight,
              height: 24.adaptSize,
              width: 24.adaptSize,
              margin: EdgeInsets.only(top: 1.v))
        ]));
  }

  /// Navigates back to the previous screen.
  onTapImage(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapTxtLargeLabelMedium(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
