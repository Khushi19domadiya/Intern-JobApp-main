import 'fulltime3_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class EightyeightItemWidget extends StatelessWidget {
  final Map<String, dynamic> jobData; // Add this variable to hold job data
  const EightyeightItemWidget({Key? key, required this.jobData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.all(15.h),
        decoration: AppDecoration.outlineGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 1.v,
                bottom: 67.v,
              ),
              child: CustomIconButton(
                height: 48.adaptSize,
                width: 48.adaptSize,
                padding: EdgeInsets.all(8.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgSettings,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 4.v),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                jobData['title'], // Use job title from jobData
                                style: CustomTextStyles.titleMediumBold_1,
                              ),
                              SizedBox(height: 5.v),
                              Text(
                                jobData['company'], // Use company name from jobData
                                style: CustomTextStyles.labelLargeGray500,
                              ),
                            ],
                          ),
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgComponent3,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                          margin: EdgeInsets.only(bottom: 22.v),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.v),
                    Text(
                      jobData['salary'], // Use salary from jobData
                      style: theme.textTheme.labelLarge,
                    ),
                    SizedBox(height: 13.v),
                    Wrap(
                      runSpacing: 8.v,
                      spacing: 8.h,
                      children: List<Widget>.generate(
                          2, (index) => Fulltime3ItemWidget()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}