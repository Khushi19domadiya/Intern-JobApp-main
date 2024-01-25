import '../job_type_screen/widgets/jobtype_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';

class JobTypeScreen extends StatelessWidget {
  const JobTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 34.v),
                child: Expanded(
                  child: ListView(
                    children: [
                      Column(children: [
                        Text("Choose Job Type", style: theme.textTheme.headlineSmall),
                        SizedBox(height: 7.v),
                        SizedBox(
                            width: 209.h,
                            child: Text(
                                "Are you looking for a new job or looking for new employee",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: CustomTextStyles.titleSmallBluegray400
                                    .copyWith(height: 1.57))),
                        SizedBox(height: 37.v),
                        _buildJobType(context)
                      ]),
                    ],
                  ),
                )),
            bottomNavigationBar: _buildContinue(context)));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 48.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgComponent1,
            margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 13.v),
            onTap: () {
              onTapImage(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgComponent3,
              margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v))
        ]);
  }

  /// Section Widget
  Widget _buildJobType(BuildContext context) {
    return SizedBox(
        height: 234.v,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(width: 15.h);
            },
            itemCount: 1,
            itemBuilder: (context, index) {
              return JobtypeItemWidget();
            }));
  }

  /// Section Widget
  Widget _buildContinue(BuildContext context) {
    return CustomElevatedButton(
        text: "Continue",
        margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 55.v),
        onPressed: () {
          onTapContinue(context);
        });
  }

  /// Navigates back to the previous screen.
  onTapImage(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the speciallizationScreen when the action is triggered.
  onTapContinue(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.speciallizationScreen);
  }
}
