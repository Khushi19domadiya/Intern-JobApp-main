import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/model/user_model.dart';
import 'package:job_app/util/colors.dart';
import 'package:job_app/util/common_methos.dart';
import 'package:job_app/view/presentation/home_page/edit_page.dart';
import 'package:job_app/view/presentation/job_details_page/applyer_list_screen.dart';
import '../home_container_screen/home_container_screen.dart';

class JobDetailsPageE extends StatefulWidget {
  final PostJobModel? postJobModel;
  const JobDetailsPageE({Key? key, this.postJobModel}) : super(key: key);

  @override
  JobDetailsPageEState createState() => JobDetailsPageEState();
}

class JobDetailsPageEState extends State<JobDetailsPageE>
    with AutomaticKeepAliveClientMixin<JobDetailsPageE> {

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false, // Remove back button
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
              ),
              Text(
                'Job Details Page',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor, // Set the text color to white
                ),
              ),
              Spacer(),
              PopupMenuButton(
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text('View Job Applicant'),
                    value: 'View Job Applicant',
                  ),
                  PopupMenuItem(
                    child: Text('Edit Posted Job'),
                    value: 'Edit Posted Job',
                  ),
                  PopupMenuItem(
                    child: Text('Delete Posted Job'),
                    value: 'Delete Posted Job',
                  ),
                ],
                onSelected: (value) async {
                  if (value == 'View Job Applicant') {
                    // Handle edit action
                    Get.to(()=> ApplyerListScreen(jobId: widget.postJobModel!.id,));
                  } else if (value == 'Edit Posted Job') {
                    Get.to(()=> EditPage(jobId: widget.postJobModel!.id,));
                  }else if (value == 'Delete Posted Job') {
                    CollectionReference jobCollection = FirebaseFirestore.instance.collection("postJob");

                    // Check if the document exists before attempting to update it
                    DocumentSnapshot documentSnapshot = await jobCollection.doc(widget.postJobModel!.id).get();
                    // Handle delete action
                    if (documentSnapshot.exists) {
                      await jobCollection.doc(widget.postJobModel!.id).update({
                        'isDelete': 1,

                      });
                      // Show success message
                      await CommonMethod()
                          .getXSnackBar("Success", 'Job deleted successfully', success)
                          .whenComplete(() => Get.to(() => HomeContainerScreen()));
                    }else {
                      // Document does not exist
                      CommonMethod().getXSnackBar("Error", "Job not deleted", Colors.red);
                      // Handle this case accordingly, e.g., show an error message
                    }
                    // Get.to(()=> EditPage(jobId: widget.postJobModel!.id,));
                  }
                },
              ),
            ],
          ),
        ),
        body: _buildJobDescription(context),
      ),
    );
  }
  // {
  //   return SafeArea(child: Scaffold(body: _buildJobDescription(context)));
  //
  // }

  /// Section Widget
  Widget _buildJobDescription(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 5.v),
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
                SizedBox(height: 40),
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
                        "${widget.postJobModel?.description  ?? ""}",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.titleSmallBluegray400
                            .copyWith(height: 1.57))),
                SizedBox(height: 40.v),
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
                SizedBox(height: 40.v),
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
                SizedBox(height: 40.v),
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
                SizedBox(height: 40.v),
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
                SizedBox(height: 40.v),
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
                SizedBox(height: 40.v),
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
                SizedBox(height: 40.v),
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
                SizedBox(height: 40.v),
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
                SizedBox(height: 40.v),
              ])
            ])));
  }

  /// Navigates to the applyJobScreen when the action is triggered.
  onTapApplyNow(BuildContext context) {
    // Navigator.pushNamed(context, AppRoutes.ApplyJobScreen);
  }
}