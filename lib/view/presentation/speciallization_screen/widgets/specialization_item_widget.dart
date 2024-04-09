import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';

// ignore: must_be_immutable
class SpecializationItemWidget extends StatelessWidget {
  const SpecializationItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 9.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder24,
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgCheckmark,
            height: 24.adaptSize,
            width: 24.adaptSize,
            margin: EdgeInsets.symmetric(vertical: 1.v),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              top: 5.v,
            ),
            child: Text(
              "Design & Creative",
              style: theme.textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
