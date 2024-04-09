import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/widgets/custom_elevated_button.dart';

// ignore_for_file: must_be_immutable
class ApplyJobPopupDialog extends StatelessWidget {
  const ApplyJobPopupDialog({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 302.h,
      padding: EdgeInsets.symmetric(
        horizontal: 32.h,
        vertical: 28.v,
      ),
      decoration: AppDecoration.white.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 4.v),
          CustomImageView(
            imagePath: ImageConstant.imgThumbsUp11,
            height: 101.adaptSize,
            width: 101.adaptSize,
          ),
          SizedBox(height: 25.v),
          Text(
            "Success",
            style: CustomTextStyles.titleMediumBold,
          ),
          SizedBox(height: 9.v),
          Text(
            "Your Application is succesfully sent",
            style: CustomTextStyles.titleSmallBluegray400SemiBold,
          ),
          SizedBox(height: 19.v),
          CustomElevatedButton(
            height: 54.v,
            width: 127.h,
            text: "Continue",
            buttonTextStyle:
                CustomTextStyles.titleSmallOnPrimaryContainerSemiBold,
          ),
        ],
      ),
    );
  }
}
