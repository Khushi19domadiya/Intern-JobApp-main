import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../home_page/pdf_viewer_screen.dart';
import '../job_details_page/job_details_page.dart';
import '../job_details_tab_container_screen/widgets/framefive_item_widget.dart';
import '../job_details_tab_container_screen/widgets/jobdetailstabcontainer_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_title.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';

class JobDetailsTabContainerScreen extends StatefulWidget {
  const JobDetailsTabContainerScreen({Key? key})
      : super(
    key: key,
  );

  @override
  JobDetailsTabContainerScreenState createState() =>
      JobDetailsTabContainerScreenState();
}

class JobDetailsTabContainerScreenState
    extends State<JobDetailsTabContainerScreen> with TickerProviderStateMixin {
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 30.v),
            child: SizedBox(
              height: 688.v,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  _buildTabBarView(context),
                  Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCardanoOne(context),
                        SizedBox(height: 22.v),
                        _buildJobDetailsTabContainer(context),
                        SizedBox(height: 26.v),
                        _buildTabview(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
          left: 20.h,
          top: 13.v,
          bottom: 13.v,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Job Details",
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

  /// Section Widget
  Widget _buildTabBarView(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 419.v),
      height: 269.v,
      child: TabBarView(
        controller: tabviewController,
        children: [],
      ),
    );
  }

  /// Section Widget
  Widget _buildCardanoOne(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35.h),
      padding: EdgeInsets.symmetric(
        horizontal: 65.h,
        vertical: 30.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 79.adaptSize,
            width: 85.adaptSize,
            padding: EdgeInsets.all(19.h),
            decoration: AppDecoration.fillGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder39,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgCardano1,
              height: 40.adaptSize,
              width: 50.adaptSize,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: 20.v),
          Text(
            "Senior UI/UX Designer",
            style: CustomTextStyles.titleSmallBold,
          ),
          SizedBox(height: 7.v),
          Text(
            "Shopee Sg",
            style: theme.textTheme.labelLarge,
          ),
          SizedBox(height: 12.v),
          Wrap(
            runSpacing: 9.v,
            spacing: 15.h,
            children:
            List<Widget>.generate(2, (index) => FramefiveItemWidget()),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildJobDetailsTabContainer(BuildContext context) {
    return SizedBox(
      height: 100.v,
      child: ListView.separated(
        padding: EdgeInsets.only(
          left: 15.h,
          right: 49.h,
        ),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (
            context,
            index,
            ) {
          return SizedBox(
            width: 54.h,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return JobdetailstabcontainerItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  /// Section Widget
  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 44.v,
      width: 340.h,
      child: TabBar(
        controller: tabviewController,
        isScrollable: true,
        labelColor: theme.colorScheme.primary,
        labelStyle: TextStyle(
          fontSize: 12.fSize,
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelColor: appTheme.gray500,
        unselectedLabelStyle: TextStyle(
          fontSize: 12.fSize,
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w600,
        ),
        indicator: BoxDecoration(
          color: appTheme.gray100,
          borderRadius: BorderRadius.circular(22.h),
        ),
        tabs: [
          Tab(
            child: InkWell(
              onTap: () {
                // Navigate to the description page when the tab is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobDetailsPage(), // Replace with your description page
                  ),
                );
              },
              child: Text("Description"),
            ),
          ),
          Tab(
            child: GestureDetector(onTap: (){
                  Get.to(() => PdfViewerPage(
                        pdfUrl:
                            'https://firebasestorage.googleapis.com/v0/b/jobapp-55512.appspot.com/o/cv_files%2Fcv_unique_user_id.pdf?alt=media&token=be80f6c1-c19b-4e67-ae80-40b236935f7e',
                      ));
            },child: Text("Requirement")),
          ),
          Tab(
            child: Text("Responsibilities"),
          ),
        ],
      ),
    );
  }

}