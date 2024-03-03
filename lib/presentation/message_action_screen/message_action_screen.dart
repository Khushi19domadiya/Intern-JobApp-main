import '../message_action_screen/widgets/messageaction_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/presentation/home_page/home_page.dart';
import 'package:saumil_s_application/presentation/message_page/message_page.dart';
import 'package:saumil_s_application/presentation/profile_page/profile_page.dart';
import 'package:saumil_s_application/presentation/saved_page/saved_page.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_title.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_bottom_bar.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';
import 'package:saumil_s_application/widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class MessageActionScreen extends StatelessWidget {
  MessageActionScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 24.v),
                child: Column(children: [
                  SizedBox(height: 2.v),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.h),
                      child: CustomSearchView(
                          controller: searchController,
                          hintText: "Search Message")),
                  SizedBox(height: 24.v),
                  _buildMessageAction(context),
                  Spacer(),
                  CustomElevatedButton(
                      height: 46.v,
                      width: 137.h,
                      text: "New Chat",
                      margin: EdgeInsets.only(right: 24.h),
                      leftIcon: Container(
                          margin: EdgeInsets.only(right: 4.h),
                          child: CustomImageView(
                              imagePath:
                                  ImageConstant.imgPlusOnprimarycontainer,
                              height: 18.adaptSize,
                              width: 18.adaptSize)),
                      buttonStyle: CustomButtonStyles.fillPrimaryTL20,
                      buttonTextStyle:
                          CustomTextStyles.titleSmallOnPrimaryContainerSemiBold,
                      alignment: Alignment.centerRight)
                ])),
            ));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        height: 97.v,
        leadingWidth: 48.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgComponent1,
            margin: EdgeInsets.only(left: 24.h, top: 15.v, bottom: 16.v),
            onTap: () {
              onTapImage(context);
            }),
        centerTitle: true,
        title: AppbarTitle(text: "Message"),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgComponent3,
              margin: EdgeInsets.fromLTRB(16.h, 15.v, 16.h, 16.v))
        ]);
  }

  /// Section Widget
  Widget _buildMessageAction(BuildContext context) {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(vertical: 7.5.v),
              child: SizedBox(
                  width: 327.h,
                  child: Divider(
                      height: 1.v, thickness: 1.v, color: appTheme.gray300)));
        },
        itemCount: 4,
        itemBuilder: (context, index) {
          return MessageactionItemWidget(onTapEstherHoward: () {
            onTapEstherHoward(context);
          });
        });
  }

  /// Section Widget
  // Widget _buildBottomBar(BuildContext context) {
  //   return CustomBottomBar(onChanged: (BottomBarEnum type) {
  //     Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
  //   });
  // }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homePage;
      case BottomBarEnum.Message:
        return AppRoutes.messagePage;
      case BottomBarEnum.Saved:
        return AppRoutes.savedPage;
      case BottomBarEnum.Profile:
        return AppRoutes.profilePage;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage();
      case AppRoutes.messagePage:
        return MessagePage();
      case AppRoutes.savedPage:
        return SavedPage();
      case AppRoutes.profilePage:
        return ProfilePage();
      default:
        return DefaultWidget();
    }
  }

  /// Navigates to the chatScreen when the action is triggered.
  onTapEstherHoward(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.chatScreen);
  }

  /// Navigates back to the previous screen.
  onTapImage(BuildContext context) {
    Navigator.pop(context);
  }
}
