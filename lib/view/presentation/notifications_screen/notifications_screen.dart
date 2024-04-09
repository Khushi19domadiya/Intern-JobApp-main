import 'widgets/notifications_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:job_app/widgets/app_bar/appbar_title.dart';
import 'package:job_app/widgets/app_bar/custom_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: 327.h,
                margin: EdgeInsets.fromLTRB(24.h, 30.v, 24.h, 5.v),
                padding: EdgeInsets.all(15.h),
                decoration: AppDecoration.outlineGray
                    .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Messages Notifications",
                          style: CustomTextStyles.labelLargeGray50002),
                      SizedBox(height: 19.v),
                      Expanded(
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 11.0.v),
                                    child: SizedBox(
                                        width: 295.h,
                                        child: Divider(
                                            height: 1.v,
                                            thickness: 1.v,
                                            color: appTheme.gray300)));
                              },
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return NotificationsItemWidget();
                              }))
                    ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 48.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgComponent1,
            margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 13.v),
            onTap: () {
              onTapArrowBack(context);
            }),
        centerTitle: true,
        title: AppbarTitle(text: "Notifications"));
  }

  /// Navigates back to the previous screen.
  onTapArrowBack(BuildContext context) {
    Navigator.pop(context);
  }
}
