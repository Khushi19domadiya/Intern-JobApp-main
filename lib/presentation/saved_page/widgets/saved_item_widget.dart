import '../../../models/user_model.dart';
import 'fulltime7_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class SavedItemWidget extends StatelessWidget {


  SavedItemWidget({
    Key? key,
    this.onTapBag,
    required this.model,
  }) : super(
          key: key
        );

  VoidCallback? onTapBag;

  PostJobModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBag!.call();
      },
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

            ),
            Padding(
              padding: EdgeInsets.only(
                // left: 0.h,
                top: 4.v,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: CustomTextStyles.titleMediumBold_1,
                  ),
                  SizedBox(height: 5.v),
                  Text(
                    "Experience: ${model.experience} Year",
                    style: CustomTextStyles.labelLargeGray500,
                  ),
                  // SizedBox(height: 12.v),
                  Text(
                    "Salary: (${model.highestsalary} - ${model.lowestsalary})",
                    style: theme.textTheme.labelLarge,
                  ),
                  // SizedBox(height: 12.v),
                  Text(
                    "Gender: ${model.gender} ",
                    style: theme.textTheme.labelLarge,
                  ),
                  Text(
                    "DeadLine: ${model.deadline} ",
                    style: theme.textTheme.labelLarge,
                  ),
                  Text(
                    "Skills: ${model.selectedSkills} ",
                    style: theme.textTheme.labelLarge,
                  ),
                  SizedBox(height: 5.v),
                  Wrap(
                    runSpacing: 8.v,
                    spacing: 8.h,
                    children: List<Widget>.generate(
                        1, (index) => Fulltime7ItemWidget(model: model,)),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
