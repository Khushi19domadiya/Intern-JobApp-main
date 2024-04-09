import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';

// ignore: must_be_immutable
class EnglishukItemWidget extends StatelessWidget {
  const EnglishukItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5.v),
          child: Text(
            "English (UK)",
            style: CustomTextStyles.titleMediumGray900,
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgCheckmarkGreenA700,
          height: 24.adaptSize,
          width: 24.adaptSize,
          margin: EdgeInsets.only(bottom: 2.v),
        ),
      ],
    );
  }
}
