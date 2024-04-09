import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class ExperiencesettingItemWidget extends StatelessWidget {
  const ExperiencesettingItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.v),
          child: CustomIconButton(
            height: 48.adaptSize,
            width: 48.adaptSize,
            padding: EdgeInsets.all(8.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgBag,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 12.h,
            top: 5.v,
            bottom: 16.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Internship UI/UX Designer",
                style: CustomTextStyles.titleSmallSemiBold,
              ),
              SizedBox(height: 6.v),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 1.v),
                    child: Text(
                      "Shopee Sg",
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 3.h,
                      top: 1.v,
                    ),
                    child: Text(
                      "•",
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Text(
                      "2019",
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
