import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/presentation/saved_page/widgets/saved_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../controller/jobController.dart';
import '../../models/user_model.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../apply_job_screen/apply_job_screen.dart';
import '../job_details_page/applyer_list_screen.dart';
import '../filter_bottomsheet/widgets/fiftyfive_item_widget.dart';
import '../filter_bottomsheet/filter_bottomsheet.dart';

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
                List<PostJobModel> filteredJobs = snapshot.data;

                // Filter jobs based on selected price range
                if (widget.minSalary != null && widget.maxSalary != null) {
                  filteredJobs = filteredJobs.where((job) =>
                  double.parse(job.lowestsalary) >= widget.minSalary! && double.parse(job.highestsalary) <= widget.maxSalary!
                  ).toList();
                }

                // Apply other filters
                if (widget.selectedJobCategory != null) {
                  filteredJobs = filteredJobs.where((job) => job.jobType == widget.selectedJobCategory).toList();
                }

                if (widget.selectedCategories != null) {
                  filteredJobs = filteredJobs.where((job) => job.selectedOption == widget.selectedCategories).toList();
                }

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
}
