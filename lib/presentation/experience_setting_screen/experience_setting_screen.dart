import '../experience_setting_screen/widgets/experiencesetting_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_title.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/widgets/custom_icon_button.dart';

import '../profile_page/widgets/fortyseven_item_widget.dart';
import 'AddSkillsScreen.dart';

class ExperienceSettingScreen extends StatelessWidget {
  const ExperienceSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 28.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 5.v),
                    child: Column(
                      children: [
                        _buildExperience1(context),
                        SizedBox(height: 37.v),
                        CustomElevatedButton(
                          text: "Add New Position",
                          onPressed: () {
                            onTapAddNewPosition(context);
                          },
                        ),
                        SizedBox(height: 32.v),
                        _buildSkillsSection(context), // Updated method call
                        SizedBox(height: 32.v),
                        _buildUniversityOfOxford(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildAddNewEducation(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 51.v,
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgComponent1,
        margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 14.v),
        onTap: () {
          onTapArrowBack(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(text: "Experience"),
    );
  }

  Widget _buildSkillsSection(BuildContext context) { // Renamed the method
    return Container(
      padding: EdgeInsets.all(15.h),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSkills(
            context,
            skillsText: "Skills",
            onTapEditSquare: () {
              onTapEditSquare(context);
            },
          ),
          SizedBox(height: 15.v),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 11.5.v),
                child: SizedBox(
                  width: 295.h,
                  child: Divider(
                    height: 1.v,
                    thickness: 1.v,
                    color: appTheme.gray300,
                  ),
                ),
              );
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return FortysevenItemWidget();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExperience1(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.h),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildEducation(
            context,
            educationText: "Experience",
            onTapEditSquare: () {
              onTapEditSquare(context);
            },
          ),
          SizedBox(height: 15.v),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 11.5.v),
                child: SizedBox(
                  width: 295.h,
                  child: Divider(
                    height: 1.v,
                    thickness: 1.v,
                    color: appTheme.gray300,
                  ),
                ),
              );
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return ExperiencesettingItemWidget();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUniversityOfOxford(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.h),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEducation(
            context,
            educationText: "Education",
          ),
          SizedBox(height: 24.v),
          Padding(
            padding: EdgeInsets.only(right: 83.h),
            child: Row(
              children: [
                CustomIconButton(
                  height: 48.adaptSize,
                  width: 48.adaptSize,
                  padding: EdgeInsets.all(8.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgFrame162724,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.h, top: 5.v),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "University of Oxford",
                          style: CustomTextStyles.titleSmallSemiBold,
                        ),
                        SizedBox(height: 6.v),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 1.v),
                              child: Text(
                                "Computer Science",
                                style: theme.textTheme.labelLarge,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 4.h, top: 1.v),
                              child: Text(
                                "•",
                                style: theme.textTheme.labelLarge,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 4.h),
                              child: Text(
                                "2019",
                                style: theme.textTheme.labelLarge,
                              ),
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildAddNewEducation(BuildContext context) {
    return CustomElevatedButton(
      text: "Add New Education",
      margin: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 55.v),
      onPressed: () {
        onTapAddNewEducation(context);
      },
    );
  }

  Widget _buildSkills(
      BuildContext context, {
        required String skillsText,
        Function? onTapEditSquare,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.v),
          child: Text(
            skillsText,
            style: CustomTextStyles.titleMediumBold_1.copyWith(color: theme.colorScheme.primary),
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgEditSquarePrimary,
          height: 24.adaptSize,
          width: 24.adaptSize,
          onTap: () {
            onTapEditSquare!.call();
          },
        ),
      ],
    );
  }

  Widget _buildEducation(
      BuildContext context, {
        required String educationText,
        Function? onTapEditSquare,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.v),
          child: Text(
            educationText,
            style: CustomTextStyles.titleMediumBold_1.copyWith(color: theme.colorScheme.primary),
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgEditSquarePrimary,
          height: 24.adaptSize,
          width: 24.adaptSize,
          onTap: () {
            onTapEditSquare!.call();
          },
        ),
      ],
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowBack(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the newPositionScreen when the action is triggered.
  onTapEditSquare(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddSkillsScreen()), // Replace AddSkillsScreen with the name of your screen
    );
  }


  /// Navigates to the newPositionScreen when the action is triggered.
  onTapAddNewPosition(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.newPositionScreen);
  }

  /// Navigates to the addNewEducationScreen when the action is triggered.
  onTapAddNewEducation(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.addNewEducationScreen);
  }
}
