import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';

// ignore: must_be_immutable
class MessageactionItemWidget extends StatelessWidget {
  MessageactionItemWidget({
    Key? key,
    this.onTapEstherHoward,
  }) : super(
          key: key,
        );

  VoidCallback? onTapEstherHoward;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapEstherHoward!.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 56.adaptSize,
            width: 56.adaptSize,
            margin: EdgeInsets.only(bottom: 17.v),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgImage56x56,
                  height: 56.adaptSize,
                  width: 56.adaptSize,
                  radius: BorderRadius.circular(
                    28.h,
                  ),
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 16.adaptSize,
                    width: 16.adaptSize,
                    decoration: BoxDecoration(
                      color: appTheme.green600,
                      borderRadius: BorderRadius.circular(
                        8.h,
                      ),
                      border: Border.all(
                        color:
                            theme.colorScheme.onPrimaryContainer.withOpacity(1),
                        width: 1.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12.h,
              top: 3.v,
              bottom: 17.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Esther Howard",
                  style: CustomTextStyles.titleMediumBold,
                ),
                SizedBox(height: 9.v),
                Text(
                  "Lorem ipsum dolor sit amet...",
                  style: CustomTextStyles.titleSmallBluegray400,
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              top: 7.v,
              bottom: 17.v,
            ),
            child: Column(
              children: [
                Text(
                  "10:20",
                  style: CustomTextStyles.labelLargeSemiBold,
                ),
                SizedBox(height: 8.v),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 24.adaptSize,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.h,
                      vertical: 5.v,
                    ),
                    decoration: AppDecoration.fillPrimary.copyWith(
                      borderRadius: BorderRadiusStyle.circleBorder12,
                    ),
                    child: Text(
                      "2",
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
