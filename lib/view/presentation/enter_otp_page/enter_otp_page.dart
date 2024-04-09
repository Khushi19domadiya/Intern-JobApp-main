import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/widgets/custom_elevated_button.dart';

class EnterOtpPage extends StatefulWidget {
  const EnterOtpPage({Key? key}) : super(key: key);

  @override
  EnterOtpPageState createState() => EnterOtpPageState();
}

class EnterOtpPageState extends State<EnterOtpPage>
    with AutomaticKeepAliveClientMixin<EnterOtpPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                width: double.maxFinite,
                decoration: AppDecoration.background,
                child: Column(children: [
                  SizedBox(height: 40.v),
                  _buildContinueSection(context)
                ]))));
  }

  /// Section Widget
  Widget _buildContinueSection(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Column(children: [
          CustomElevatedButton(
              text: "Continue",
              onPressed: () {
                onTapContinue(context);
              }),
          SizedBox(height: 26.v),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.h),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Didn’t receive code?",
                    style: CustomTextStyles.titleMediumGray500),
                Text("Resend Code", style: theme.textTheme.titleMedium)
              ]))
        ]));
  }

  /// Navigates to the jobTypeScreen when the action is triggered.
  onTapContinue(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.jobTypeScreen);
  }
}
