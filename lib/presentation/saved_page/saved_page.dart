import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/presentation/filter_bottomsheet/filter_bottomsheet.dart';
import 'package:saumil_s_application/presentation/saved_page/widgets/saved_item_widget.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_title.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../controller/jobController.dart';
import '../../models/user_model.dart';
import '../apply_job_screen/apply_job_screen.dart';
import '../job_details_page/applyer_list_screen.dart';
import '../filter_bottomsheet/widgets/fiftyfive_item_widget.dart';

class SavedPage extends StatefulWidget {
  String? selectedJobCategory;
  String? selectedCategories;

  SavedPage({Key? key, this.selectedJobCategory, this.selectedCategories}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final jobController controller = Get.put(jobController());
  String? userRole;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchUserRole();
  }

  void fetchUserRole() async {
    final userDoc = await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
    setState(() {
      userRole = userDoc['role'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: EdgeInsets.only(left: 24.h, top: 30.v, right: 24.h),
          child: FutureBuilder<List<PostJobModel>>(
            future: controller.fetchJobDataFromFirestore(userRole.toString()),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<PostJobModel> filteredJobs = [];
                if (widget.selectedJobCategory != null) {
                  // Filter jobs based on the selected job category
                  filteredJobs = snapshot.data.where((job) => job.jobType == widget.selectedJobCategory).toList();
                } else {
                  // If no job category is selected, show all jobs
                  filteredJobs = snapshot.data;
                }

                // Apply additional filtering based on selected option
                if (widget.selectedCategories != null) {
                  filteredJobs = filteredJobs.where((job) => job.selectedOption == widget.selectedCategories).toList();
                }

                // Apply filter based on salary condition

                return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12.v);
                  },
                  itemCount: filteredJobs.length,
                  itemBuilder: (context, index) {
                    PostJobModel model = filteredJobs[index];
                    return SavedItemWidget(
                      onTapBag: () {
                        if (userRole == "e") {
                          Get.to(() => ApplyerListScreen());
                        } else {
                          Get.to(() => ApplyJobScreen(jobId: model.id,));
                        }
                      },
                      model: model,
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
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
      title: AppbarTitle(text: "Jobs"),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgFilter,
          margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 13.v),
          onTap: () {
            showFilterBottomSheet(context);
          },
        ),
      ],
    );
  }

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FilterBottomsheet(
          onJobCategorySelected: (category) {
            setState(() {
              widget.selectedJobCategory = category;
            });
          },
          onCategories: (categories) {
            setState(() {
              widget.selectedCategories = categories;
            });
          },
        );
      },
    );
  }

  void onTapImage(BuildContext context) {
    Navigator.pop(context);
  }
}