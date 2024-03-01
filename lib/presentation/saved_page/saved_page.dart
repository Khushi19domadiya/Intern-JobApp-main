import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saumil_s_application/core/utils/image_constant.dart';
import 'package:saumil_s_application/core/utils/size_utils.dart';
import 'package:saumil_s_application/presentation/saved_page/widgets/saved_item_widget.dart';
import '../../controller/jobController.dart';
// import '../../models/post_job_model.dart';
import '../../models/user_model.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../apply_job_screen/apply_job_screen.dart';
import '../job_details_page/applyer_list_screen.dart';
import '../filter_bottomsheet/widgets/fiftyfive_item_widget.dart';
import '../filter_bottomsheet/filter_bottomsheet.dart';
import '../../controller/jobController.dart';


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
            future: _controller.fetchUserPostedJobs(_user!.uid), // Fetch only user's posted jobs
            builder: (context, AsyncSnapshot<List<PostJobModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final List<PostJobModel>? userPostedJobs = snapshot.data;

                if (userPostedJobs == null || userPostedJobs.isEmpty) {
                  // Display a message or widget indicating that no jobs are available
                  return Center(child: Text("No jobs available."));
                }

                // Apply filters
                List<PostJobModel> filteredJobs = userPostedJobs;

                if (widget.minSalary != null && widget.maxSalary != null) {
                  filteredJobs = filteredJobs.where((job) =>
                  double.parse(job.lowestsalary) >= widget.minSalary! &&
                      double.parse(job.highestsalary) <= widget.maxSalary!
                  ).toList();
                }

                if (widget.selectedJobCategory != null) {
                  filteredJobs = filteredJobs.where((job) => job.jobType == widget.selectedJobCategory).toList();
                }

                if (widget.selectedCategories != null) {
                  filteredJobs = filteredJobs.where((job) => job.selectedOption == widget.selectedCategories).toList();
                }

                // Filter out jobs with expired deadlines
                filteredJobs = filteredJobs.where((job) {
                  // Parse deadline date string to DateTime object
                  DateTime deadline = DateTime.parse(job.deadline);
                  // Check if the deadline has already passed
                  return deadline.isAfter(DateTime.now());
                }).toList();

                if (filteredJobs.isEmpty) {
                  // Display a message or widget indicating that no jobs are available
                  return Center(child: Text("No jobs available after applying filters."));
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
}