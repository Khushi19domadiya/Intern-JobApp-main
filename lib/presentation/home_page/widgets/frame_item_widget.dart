import '../../../models/user_model.dart';
import 'fulltime1_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/custom_icon_button.dart';


class FrameItemWidget extends StatelessWidget {
   FrameItemWidget({ Key? key,
     this.onTapBag,
     required this.model,
   }) : super(
       key: key
   );

   VoidCallback? onTapBag;

   postjobModel model;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.h,
      child: Align(
        alignment: Alignment.centerRight,
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
              Padding(
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
                        style: CustomTextStyles
                            .labelLargeOnPrimaryContainer_3,
                      ),
                    ),
                    SizedBox(height: 11.v),
                Opacity(
                  opacity: 0.8,
                  child:
                       Text(
                        "Salary: (${model.highestsalary} - ${model.lowestsalary})",
                        style: CustomTextStyles.labelLargeOnPrimaryContainer_3,
                      ),
                ),
                    SizedBox(height: 9.v),
                Opacity(
                  opacity: 0.8,
                  child:
                    Text(
                      "DeadLine: ${model.deadline} ",
                      style: CustomTextStyles.labelLargeOnPrimaryContainer_3,
                    ),
                ),
                    SizedBox(height: 9.v),
                Opacity(
                  opacity: 0.8,
                  child:
                    Text(
                      "JobType: ${model.jobType} ",
                      style: CustomTextStyles.labelLargeOnPrimaryContainer_3,
                    ),
                ),
                    SizedBox(height: 9.v),
                    Opacity(
                      opacity: 0.8,
                      child:
                      Text(
                        "Gender: ${model.gender} ",
                        style: CustomTextStyles.labelLargeOnPrimaryContainer_3,
                      ),
                    ),
                    SizedBox(height: 9.v),
                    Opacity(
                      opacity: 0.8,
                      child:
                      Text(
                        "Skills: ${model.selectedSkills} ",
                        style: CustomTextStyles.labelLargeOnPrimaryContainer_3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
