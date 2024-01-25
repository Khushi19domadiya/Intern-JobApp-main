import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class JobdetailstabcontainerItemWidget extends StatelessWidget {
  const JobdetailstabcontainerItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.h,
      child: Column(
        children: [
          CustomIconButton(
            height: 48.adaptSize,
            width: 48.adaptSize,
            padding: EdgeInsets.all(15.h),
            decoration: IconButtonStyleHelper.fillGreen,
            child: CustomImageView(
              imagePath: ImageConstant.imgWallet,
            ),
          ),
          SizedBox(height: 9.v),
          Text(
            "Salary",
            style: CustomTextStyles.labelLargeGray500_1,
          ),
          SizedBox(height: 0.v),
          Text(
            "6k - 11k",
            style: CustomTextStyles.titleSmallSemiBold,
          ),
        ],
      ),
    );
  }
}
