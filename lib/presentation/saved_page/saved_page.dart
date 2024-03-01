import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saumil_s_application/core/utils/image_constant.dart';
import 'package:saumil_s_application/core/utils/size_utils.dart';
import 'package:saumil_s_application/presentation/saved_page/widgets/saved_item_widget.dart';
import 'package:saumil_s_application/presentation/apply_job_screen/apply_job_screen.dart';
import 'package:saumil_s_application/presentation/job_details_page/applyer_list_screen.dart';
import 'package:saumil_s_application/presentation/filter_bottomsheet/widgets/fiftyfive_item_widget.dart';
import 'package:saumil_s_application/presentation/filter_bottomsheet/filter_bottomsheet.dart';
import 'package:saumil_s_application/controller/jobController.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';

import '../../widgets/app_bar/appbar_title.dart';

class SavedPage extends StatefulWidget {
  String? selectedJobCategory;
  String? selectedCategories;
  double? minSalary;
  double? maxSalary;

  SavedPage({
    Key? key,
    this.selectedJobCategory,
    this.selectedCategories,
    this.minSalary,
    this.maxSalary,
  }) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final jobController _controller = Get.put(jobController());
  String? userRole;
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    fetchUserRole();
  }

  void fetchUserRole() async {
    final userDoc = await FirebaseFirestore.instance.collection('Users').doc(_user!.uid).get();
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
            future: _getJobsFuture(), // Future based on user role
            builder: (context, AsyncSnapshot<List<PostJobModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final List<PostJobModel>? jobs = snapshot.data;

                if (jobs == null || jobs.isEmpty) {
                  return Center(child: Text("No jobs available."));
                }

                return ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 12.v);
                  },
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    PostJobModel model = jobs[index];
                    return SavedItemWidget(
                      onTapBag: () {
                        if (userRole == "e") {
                          Get.to(() => ApplyerListScreen());
                        } else {
                          Get.to(() => ApplyJobScreen(jobId: model.id));
                        }
                      },
                      model: model,
                    );
                  },
                );
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
          minSalary: widget.minSalary ?? 5000,
          maxSalary: widget.maxSalary ?? 100000,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          widget.minSalary = value['minSalary'];
          widget.maxSalary = value['maxSalary'];
        });
      }
    });
  }

  void onTapImage(BuildContext context) {
    Navigator.pop(context);
  }

  Future<List<PostJobModel>> _getJobsFuture() async {
    if (userRole == 'e') {
      // Fetch only current user's posted jobs
      return _controller.fetchUserPostedJobs(_user!.uid);
    } else {
      // Fetch all jobs
      return _controller.fetchJobDataFromFirestore(userRole!);
    }
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 2ab727349c9d1061f40b03ce2a3534336efe7eda
