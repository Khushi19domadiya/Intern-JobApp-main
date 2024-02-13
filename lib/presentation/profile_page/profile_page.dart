import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/presentation/profile_page/widgets/fortyseven_item_widget.dart';
import 'package:saumil_s_application/presentation/profile_page/widgets/profile_item_widget.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_title.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/widgets/custom_icon_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 30.v),
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.v),
              child: Column(
                children: [
                  _buildBackground(context),
                  SizedBox(height: 16.v),
                  Container(
                    width: 273.h,
                    margin: EdgeInsets.only(left: 51.h, right: 50.h),
                    child: Text(
                      "UI/UX Designer, Web Design, Mobile App Design",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.titleSmallBluegray400.copyWith(height: 1.57),
                    ),
                  ),
                  SizedBox(height: 16.v),
                  _buildJobApplied(context),
                  SizedBox(height: 24.v),
                  Divider(color: appTheme.gray300),
                  SizedBox(height: 22.v),
                  _buildAboutMe(context),
                  SizedBox(height: 24.v),
                  _buildSkillsList(context),
                  SizedBox(height: 24.v),
                  _buildExperience1(context),
                  SizedBox(height: 24.v),
                  _buildEducation1(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgComponent1,
        margin: EdgeInsets.only(left: 24.h, top: 13.v, bottom: 13.v),
        onTap: () {
          onTapImage(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(text: "Profile"),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgComponent3Primary,
          margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v),
          onTap: () {
            onTapImage1(context);
          },
        ),
      ],
    );
  }

  Widget _buildBackground(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        String firstName = snapshot.data?['fname'] ?? 'Anonymous';
        String lastName = snapshot.data?['lname'] ?? '';
        String displayName = '$firstName $lastName';

        // Check if 'photoUrl' is not null
        if (snapshot.data?['profileUrl'] != null) {
          String photoUrl = snapshot.data?['profileUrl'];
          return SizedBox(
            height: 225.v,
            width: 327.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70.h, // Increase the radius for larger photo
                  backgroundImage: NetworkImage(photoUrl),
                ),
                SizedBox(height: 9.v),
                // Display full name without truncation
                Text(
                  displayName,
                  style: CustomTextStyles.titleMediumBlack900,
                ),
                SizedBox(height: 7.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1.v),
                      child: Text(
                        "Open to work",
                        style: CustomTextStyles.titleSmallGray500SemiBold_1,
                      ),
                    ),
                    Container(
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      margin: EdgeInsets.only(left: 10.h, bottom: 3.v),
                      padding: EdgeInsets.all(3.h),
                      decoration: AppDecoration.success.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgCheck,
                        height: 9.adaptSize,
                        width: 9.adaptSize,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          // Placeholder widget or nothing if photoUrl is null
          return SizedBox(
            height: 225.v,
            width: 327.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display full name without truncation
                Text(
                  displayName,
                  style: CustomTextStyles.titleMediumBlack900,
                ),
                SizedBox(height: 7.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 1.v),
                      child: Text(
                        "Open to work",
                        style: CustomTextStyles.titleSmallGray500SemiBold_1,
                      ),
                    ),
                    Container(
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                      margin: EdgeInsets.only(left: 10.h, bottom: 3.v),
                      padding: EdgeInsets.all(3.h),
                      decoration: AppDecoration.success.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder8,
                      ),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgCheck,
                        height: 9.adaptSize,
                        width: 9.adaptSize,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }


  Widget _buildJobApplied(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 12.v),
              decoration: AppDecoration.fillGray.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2.v),
                    child: Text(
                      "25",
                      style: CustomTextStyles.titleMediumBold_1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.v),
                    child: Text(
                      "Applied",
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: CustomElevatedButton(
              height: 48.v,
              text: "10",
              margin: EdgeInsets.only(left: 19.h),
              buttonStyle: CustomButtonStyles.fillGrayTL241,
              buttonTextStyle: CustomTextStyles.titleMediumBold_1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutMe(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 12.v),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.v),
          _buildSkills(
            context,
            skillsText: "About Me",
            editSquareImage: ImageConstant.imgEditSquare,
          ),
          SizedBox(height: 14.v),
          Container(
            width: 272.h,
            margin: EdgeInsets.only(right: 22.h),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Libero, cursus molestie nullam ac pharetra est nec enim. Vel eleifend semper nunc faucibus donec pretium.",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: CustomTextStyles.titleSmallBluegray400.copyWith(height: 1.57),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsList(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 23.h),
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 15.v),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.h),
            child: _buildSkills(
              context,
              skillsText: "Skills",
              editSquareImage: ImageConstant.imgEditSquare,
            ),
          ),
          SizedBox(height: 12.v),
          Wrap(
            runSpacing: 12.v,
            spacing: 12.h,
            children: List<Widget>.generate(
              8,
                  (index) => FortysevenItemWidget(),
            ),
          ),
          SizedBox(height: 17.v),
        ],
      ),
    );
  }

  Widget _buildExperience1(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.h),
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 14.v),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSkills(
            context,
            skillsText: "Experience",
            editSquareImage: ImageConstant.imgEditSquarePrimary,
          ),
          SizedBox(height: 22.v),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 11.5.v),
                child: SizedBox(
                  width: 235.h,
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
              return ProfileItemWidget();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEducation1(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.h),
      padding: EdgeInsets.all(15.h),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkills(
            context,
            skillsText: "Education",
            editSquareImage: ImageConstant.imgEditSquarePrimary,
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
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(top: 1.v),
                                child: Text(
                                  "Computer Science",
                                  style: theme.textTheme.labelLarge,
                                ),
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

  Widget _buildSkills(
      BuildContext context, {
        required String skillsText,
        required String editSquareImage,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.v),
          child: Text(
            skillsText,
            style: theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.primary),
          ),
        ),
        CustomImageView(
          imagePath: editSquareImage,
          height: 24.adaptSize,
          width: 24.adaptSize,
        ),
      ],
    );
  }

  void onTapImage(BuildContext context) {
    Navigator.pop(context);
  }

  void onTapImage1(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settingsScreen);
  }
}
