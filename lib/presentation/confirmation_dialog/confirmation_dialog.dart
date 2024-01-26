import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                      text: TextSpan(children: [
                        TextSpan(
                            text: "I agree to the ",
                            style: CustomTextStyles.titleMediumGray500_1),
                        TextSpan(
                            text: "Terms of Service",
                            style: theme.textTheme.titleMedium),
                        TextSpan(
                            text: " and ",
                            style: CustomTextStyles.titleMediumGray500_1),
                        TextSpan(
                            text: "Conditions of Use",
                            style: theme.textTheme.titleMedium),
                        TextSpan(
                            text:
                                " including consent to electronic communications and I affirm that the information provided is my own.",
                            style: CustomTextStyles.titleMediumGray500_1)
                      ]),
                      textAlign: TextAlign.center)),
              SizedBox(height: 17.v),
              CustomElevatedButton(
                  height: 54.v,
                  width: 181.h,
                  text: "Agree and continue",
                  buttonTextStyle:
                      CustomTextStyles.titleSmallOnPrimaryContainerSemiBold,
                  onPressed: () {
                    onTapAgreeAndContinue(context);
                  }),
              SizedBox(height: 24.v),
              CustomElevatedButton(
                  height: 54.v,
                  width: 181.h,                text: "Disgree",
                buttonTextStyle: CustomTextStyles.titleSmallOnPrimary,
                  onPressed: () {
                    onTapAgreeAndContinue(context);
                    Navigator.pushNamed(context,AppRoutes.speciallizationScreen);
                  }),
            ]));
  }

  /// Navigates to the homeContainerScreen when the action is triggered.
  onTapAgreeAndContinue(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeContainerScreen);
  }
}
