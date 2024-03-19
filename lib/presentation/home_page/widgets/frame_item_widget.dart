import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';

import '../../../models/user_model.dart';

class FrameItemWidget extends StatelessWidget {
  FrameItemWidget({
    Key? key,
    this.onTapBag,
    required this.model,
    required this.searchQuery,
  }) : super(key: key);

  VoidCallback? onTapBag;
  final PostJobModel model;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    bool showItem = model.title.contains(searchQuery);

    return showItem
        ? SizedBox(
      width: 300.h,
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: onTapBag,
          child: Container(
            padding: EdgeInsets.all(16.h),
            decoration: AppDecoration.fillPrimary.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 96.v),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12.h,
                      top: 4.v,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: CustomTextStyles.titleSmallOnPrimaryContainerBold,
                        ),
                        SizedBox(height: 7.v),
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            "Experience: ${model.experience} Year",
                            style: CustomTextStyles.labelLargeOnPrimaryContainer_3,
                          ),
                        ),
                        SizedBox(height: 11.v),
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            "Salary: (${model.lowestsalary} - ${model.highestsalary})",
                            style: CustomTextStyles.labelLargeOnPrimaryContainer_3,
                          ),
                        ),
                        SizedBox(height: 9.v),
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            "DeadLine: ${model.deadline} ",
                            style: CustomTextStyles.labelLargeOnPrimaryContainer_3,
                          ),
                        ),
                        SizedBox(height: 9.v),
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            "JobType: ${model.jobType} ",
                            style: CustomTextStyles.labelLargeOnPrimaryContainer_3,
                          ),
                        ),
                        SizedBox(height: 9.v),
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            "Gender: ${model.gender} ",
                            style: CustomTextStyles.labelLargeOnPrimaryContainer_3,
                          ),
                        ),
                        SizedBox(height: 9.v),
                        Opacity(
                          opacity: 0.8,
                          child: Text(
                            "Skills: ${model.selectedSkills} ",
                            style: CustomTextStyles.labelLargeOnPrimaryContainer_3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        : Container();
  }
}
