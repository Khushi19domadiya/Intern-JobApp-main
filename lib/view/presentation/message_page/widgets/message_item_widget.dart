import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';

// ignore: must_be_immutable
class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgAvatar56x56,
          height: 56.adaptSize,
          width: 56.adaptSize,
          radius: BorderRadius.circular(
            28.h,
          ),
          margin: EdgeInsets.only(bottom: 17.v),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 12.h,
            top: 5.v,
            bottom: 17.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Chance Septimus",
                style: CustomTextStyles.titleMediumBold,
              ),
              SizedBox(height: 7.v),
              Text(
                "Lorem ipsum dolor sit amet...",
                style: CustomTextStyles.titleSmallBluegray400,
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(
            top: 7.v,
            bottom: 49.v,
          ),
          child: Text(
            "10:20",
            style: CustomTextStyles.labelLargeSemiBold,
          ),
        ),
      ],
    );
  }
}
