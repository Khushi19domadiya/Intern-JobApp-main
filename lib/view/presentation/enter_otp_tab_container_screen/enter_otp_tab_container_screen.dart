import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/view/presentation/enter_otp_page/enter_otp_page.dart';
import 'package:job_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:job_app/widgets/app_bar/appbar_trailing_image.dart';
import 'package:job_app/widgets/app_bar/custom_app_bar.dart';

class EnterOtpTabContainerScreen extends StatefulWidget {
  const EnterOtpTabContainerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  EnterOtpTabContainerScreenState createState() =>
      EnterOtpTabContainerScreenState();
}

class EnterOtpTabContainerScreenState extends State<EnterOtpTabContainerScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 31.v),
              Text(
                "Enter OTP",
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: 10.v),
              Container(
                width: 282.h,
                margin: EdgeInsets.symmetric(horizontal: 46.h),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "We have just sent you 4 digit code via your email ",
                        style: CustomTextStyles.titleSmallBluegray400_2,
                      ),
                      TextSpan(
                        text: "example@gmail.com",
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 37.v),
              Container(
                height: 56.v,
                width: 296.h,
                child: TabBar(
                  controller: tabviewController,
                  labelPadding: EdgeInsets.zero,
                  labelColor: theme.colorScheme.primary,
                  labelStyle: TextStyle(
                    fontSize: 24.fSize,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w400,
                  ),
                  unselectedLabelColor: theme.colorScheme.primary,
                  unselectedLabelStyle: TextStyle(
                    fontSize: 24.fSize,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w700,
                  ),
                  indicator: BoxDecoration(
                    color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
                    borderRadius: BorderRadius.circular(
                      24.h,
                    ),
                    border: Border.all(
                      color: theme.colorScheme.primary,
                      width: 1.h,
                    ),
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        "4",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "3",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "2",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "|",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 508.v,
                child: TabBarView(
                  controller: tabviewController,
                  children: [
                    EnterOtpPage(),
                    EnterOtpPage(),
                    EnterOtpPage(),
                    EnterOtpPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 48.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgComponent1,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 13.v,
          bottom: 13.v,
        ),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgComponent3,
          margin: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 13.v,
          ),
        ),
      ],
    );
  }
}
