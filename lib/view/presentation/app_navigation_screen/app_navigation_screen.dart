import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildAppNavigation(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        _buildScreenTitle(
                          context,
                          screenTitle: "Splash Screen",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Onboarding Three",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign Up - Create Acount",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Sign Up - Complete Account ",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Job Type",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Speciallization",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Select a Country",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Login",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Enter OTP - Tab Container",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Home - Container",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Search",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Job Details - Tab Container",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Message Action",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Chat",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Apply Job",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle:
                              "Notifications - My Proposals - Tab Container",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Settings",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Personal Info",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Experience Setting",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "New Position",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Add New Education",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Privacy",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Language",
                        ),
                        _buildScreenTitle(
                          context,
                          screenTitle: "Notifications",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAppNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                "App Navigation",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20.h),
              child: Text(
                "Check your app's UI from the below demo screens of your app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF888888),
                  fontSize: 16.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: Color(0XFF000000),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                screenTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.v),
          SizedBox(height: 5.v),
          Divider(
            height: 1.v,
            thickness: 1.v,
            color: Color(0XFF888888),
          ),
        ],
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
