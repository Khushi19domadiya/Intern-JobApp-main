import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/presentation/apply_job_screen/apply_job_screen.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';

import '../apply_job_screen/apply_job_screen.dart';
import '../apply_job_screen/apply_job_screen.dart';
import '../apply_job_screen/apply_job_screen.dart';

class JobDetailsPage extends StatefulWidget {
  final PostJobModel? postJobModel;
  const JobDetailsPage({Key? key, this.postJobModel}) : super(key: key);

  @override
  JobDetailsPageState createState() => JobDetailsPageState();
}

class JobDetailsPageState extends State<JobDetailsPage>
    with AutomaticKeepAliveClientMixin<JobDetailsPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: _buildJobDescription(context)));
  }

  /// Section Widget
  Widget _buildJobDescription(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 10.v),
            child: Column(children: [
              SizedBox(height: 40.v),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text("Title",
                            style: CustomTextStyles.titleMediumBold_1))),
                SizedBox(height: 20.v),
                Container(
                    width: 319.h,
                    margin: EdgeInsets.only(left: 31.h, right: 24.h),
                    child: Text(
                        "${widget.postJobModel?.title  ?? ""}",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.titleSmallBluegray400
                            .copyWith(height: 1.57))),
                SizedBox(height: 30),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text("About",
                            style: CustomTextStyles.titleMediumBold_1))),
                SizedBox(height: 20.v),
                Container(
                    width: 319.h,
                    margin: EdgeInsets.only(left: 31.h, right: 24.h),
                    child: Text(
                        "${widget.postJobModel?.about  ?? ""}",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.titleSmallBluegray400
                            .copyWith(height: 1.57))),
                SizedBox(height: 3.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text("Address",
                            style: CustomTextStyles.titleMediumBold_1))),
                SizedBox(height: 20.v),
                Container(
                    width: 319.h,
                    margin: EdgeInsets.only(left: 31.h, right: 24.h),
                    child: Text(
                        "${widget.postJobModel?.address  ?? ""}",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.titleSmallBluegray400
                            .copyWith(height: 1.57))),
                SizedBox(height: 3.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text("Deadline",
                            style: CustomTextStyles.titleMediumBold_1))),
                SizedBox(height: 20.v),
                Container(
                    width: 319.h,
                    margin: EdgeInsets.only(left: 31.h, right: 24.h),
                    child: Text(
                        "${widget.postJobModel?.deadline  ?? ""}",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.titleSmallBluegray400
                            .copyWith(height: 1.57))),
                SizedBox(height: 3.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text("Lowest Salary",
                            style: CustomTextStyles.titleMediumBold_1))),
                SizedBox(height: 20.v),
                Container(
                    width: 319.h,
                    margin: EdgeInsets.only(left: 31.h, right: 24.h),
                    child: Text(
                        "${widget.postJobModel?.lowestsalary  ?? ""}",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.titleSmallBluegray400
                            .copyWith(height: 1.57))),
                SizedBox(height: 3.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text("Highest Salary",
                            style: CustomTextStyles.titleMediumBold_1))),
                SizedBox(height: 20.v),
                Container(
                    width: 319.h,
                    margin: EdgeInsets.only(left: 31.h, right: 24.h),
                    child: Text(
                        "${widget.postJobModel?.highestsalary  ?? ""}",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.titleSmallBluegray400
                            .copyWith(height: 1.57))),
                SizedBox(height: 3.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text("Gender",
                            style: CustomTextStyles.titleMediumBold_1))),
                SizedBox(height: 20.v),
                Container(
                    width: 319.h,
                    margin: EdgeInsets.only(left: 31.h, right: 24.h),
                    child: Text(
                        "${widget.postJobModel?.gender  ?? ""}",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.titleSmallBluegray400
                            .copyWith(height: 1.57))),
                SizedBox(height: 3.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text("Experience",
                            style: CustomTextStyles.titleMediumBold_1))),
                SizedBox(height: 20.v),
                Container(
                    width: 319.h,
                    margin: EdgeInsets.only(left: 31.h, right: 24.h),
                    child: Text(
                        "${widget.postJobModel?.experience  ?? ""}",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.titleSmallBluegray400
                            .copyWith(height: 1.57))),
                SizedBox(height: 3.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text("Category",
                            style: CustomTextStyles.titleMediumBold_1))),
                SizedBox(height: 20.v),
                Container(
                    width: 319.h,
                    margin: EdgeInsets.only(left: 31.h, right: 24.h),
                    child: Text(
                        "${widget.postJobModel?.selectedOption  ?? ""}",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.titleSmallBluegray400
                            .copyWith(height: 1.57))),
                SizedBox(height: 3.v),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 24.h),
                        child: Text("Skills",
                            style: CustomTextStyles.titleMediumBold_1))),
                SizedBox(height: 20.v),
                Container(
                    width: 319.h,
                    margin: EdgeInsets.only(left: 31.h, right: 24.h),
                    child: Text(
                        "${widget.postJobModel?.selectedSkills  ?? ""}",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.titleSmallBluegray400
                            .copyWith(height: 1.57))),
                SizedBox(height: 3.v),
                Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 24.h, vertical: 28.v),
                    decoration: AppDecoration.linear,
                    child: Column(children: [
                      SizedBox(height: 50.v),
                      CustomElevatedButton(

                          text: "Apply Now",
                          onPressed: () {
                            // onTapApplyNow(context);
                            Get.to(()=>ApplyJobScreen(jobId: widget.postJobModel!.id, jobTitle: widget.postJobModel!.title,postUserId: widget.postJobModel!.userId,));
                          })
                    ]))
              ])
            ])));
  }

  /// Navigates to the applyJobScreen when the action is triggered.
  onTapApplyNow(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.ApplyJobScreen);
  }
}