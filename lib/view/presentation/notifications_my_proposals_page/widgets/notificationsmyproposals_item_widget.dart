import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/widgets/custom_elevated_button.dart';
import 'package:job_app/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class NotificationsmyproposalsItemWidget extends StatelessWidget {
  const NotificationsmyproposalsItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomIconButton(
              height: 48.adaptSize,
              width: 48.adaptSize,
              padding: EdgeInsets.all(7.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgGroupRed800,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 12.h,
                top: 4.v,
                bottom: 3.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Senior UI/UX Designer",
                    style: CustomTextStyles.titleSmallBold,
                  ),
                  SizedBox(height: 6.v),
                  Text(
                    "Shell",
                    style: CustomTextStyles.labelLargeGray500,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.v),
        CustomElevatedButton(
          height: 28.v,
          width: 81.h,
          text: "Opened",
          margin: EdgeInsets.only(left: 60.h),
          buttonStyle: CustomButtonStyles.fillGreen,
          buttonTextStyle: CustomTextStyles.bodySmallGreen600,
        ),
      ],
    );
  }
}
