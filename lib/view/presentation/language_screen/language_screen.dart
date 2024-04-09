import '../language_screen/widgets/chineses_item_widget.dart';
import '../language_screen/widgets/englishuk_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:job_app/widgets/app_bar/appbar_title.dart';
import 'package:job_app/widgets/app_bar/custom_app_bar.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 28.v),
                child: Column(children: [
                  _buildSuggestedLanguages(context),
                  SizedBox(height: 24.v),
                  _buildOtherLanguages(context),
                  SizedBox(height: 5.v)
                ]))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 51.v,
        leadingWidth: 48.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgComponent1,
            margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 14.v),
            onTap: () {
              onTapArrowBack(context);
            }),
        centerTitle: true,
        title: AppbarTitle(text: "Language"));
  }

  /// Section Widget
  Widget _buildSuggestedLanguages(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 20.v),
        decoration: AppDecoration.outlineGray
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 2.v),
              Text("Suggested Languages",
                  style: CustomTextStyles.labelLargeSemiBold),
              SizedBox(height: 16.v),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 7.0.v),
                        child: SizedBox(
                            width: 295.h,
                            child: Divider(
                                height: 1.v,
                                thickness: 1.v,
                                color: appTheme.gray300)));
                  },
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return EnglishukItemWidget();
                  })
            ]));
  }

  /// Section Widget
  Widget _buildOtherLanguages(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15.h),
        decoration: AppDecoration.outlineGray
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 3.v),
              Text("Other Languages",
                  style: CustomTextStyles.labelLargeSemiBold),
              SizedBox(height: 19.v),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.v),
                        child: SizedBox(
                            width: 295.h,
                            child: Divider(
                                height: 1.v,
                                thickness: 1.v,
                                color: appTheme.gray300)));
                  },
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return ChinesesItemWidget();
                  })
            ]));
  }

  /// Navigates back to the previous screen.
  onTapArrowBack(BuildContext context) {
    Navigator.pop(context);
  }
}
