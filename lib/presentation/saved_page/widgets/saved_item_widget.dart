import 'fulltime7_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class SavedItemWidget extends StatelessWidget {
  SavedItemWidget({
    Key? key,
    this.onTapBag,
  }) : super(
          key: key,
        );

  VoidCallback? onTapBag;

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
                top: 4.v,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "UX Designer",
                    style: CustomTextStyles.titleMediumBold_1,
                  ),
                  SizedBox(height: 5.v),
                  Text(
                    "Motorola",
                    style: CustomTextStyles.labelLargeGray500,
                  ),
                  SizedBox(height: 12.v),
                  Text(
                    "560 - 12.000/Month",
                    style: theme.textTheme.labelLarge,
                  ),
                  SizedBox(height: 13.v),
                  Wrap(
                    runSpacing: 8.v,
                    spacing: 8.h,
                    children: List<Widget>.generate(
                        2, (index) => Fulltime7ItemWidget()),
                  ),
                ],
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgComponent3,
              height: 24.adaptSize,
              width: 24.adaptSize,
              margin: EdgeInsets.only(
                left: 30.h,
                bottom: 92.v,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
