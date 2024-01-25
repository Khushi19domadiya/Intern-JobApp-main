import 'fulltime1_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/custom_icon_button.dart';


class FrameItemWidget extends StatelessWidget {
  const FrameItemWidget({Key? key})
      : super(
    key: key,
  );


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 273.h,
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
                child: CustomIconButton(
                  height: 48.adaptSize,
                  width: 48.adaptSize,
                  padding: EdgeInsets.all(8.h),
                  decoration: IconButtonStyleHelper.fillOnPrimaryContainer,
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
                      "Senior UI/UX Designer",
                      style: CustomTextStyles.titleSmallOnPrimaryContainerBold,
                    ),
                    SizedBox(height: 7.v),
                    Opacity(
                      opacity: 0.8,
                      child: Text(
                        "Shopee",
                        style: CustomTextStyles
                            .labelLargeOnPrimaryContainerSemiBold,
                      ),
                    ),
                    SizedBox(height: 11.v),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        "Jakarta, Indonesia (Remote)",
                        style: CustomTextStyles.labelLargeOnPrimaryContainer_1,
                      ),
                    ),
                    SizedBox(height: 9.v),
                    Text(
                      "1100 - 12.000/Month",
                      style: CustomTextStyles.labelLargeOnPrimaryContainer_3,
                    ),
                    SizedBox(height: 17.v),
                    Wrap(
                      runSpacing: 7.v,
                      spacing: 7.h,
                      children: List<Widget>.generate(
                          2, (index) => Fulltime1ItemWidget()),
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
