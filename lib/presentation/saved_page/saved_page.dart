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
import 'package:saumil_s_application/widgets/custom_search_view.dart';

import '../../widgets/app_bar/appbar_title.dart';
import '../job_details_page/job_details_page.dart';

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
  final TextEditingController _searchController = TextEditingController();
  final jobController _controller = Get.put(jobController());
  List<PostJobModel> jobList = <PostJobModel>[];
  RxBool isLoading = false.obs;
  String? userRole;

  final User? _user = FirebaseAuth.instance.currentUser;

  getData() async {}

  @override
  void initState() {
    super.initState();
    getData();
    fetchUserRole();
  }

  void fetchUserRole() async {
    final userDoc = await FirebaseFirestore.instance.collection('Users').doc(_user!.uid).get();
    setState(() {
      userRole = userDoc['role'];
    });
    jobList = await _getJobsFuture();
    tempSearchJob = jobList;
    isLoading.refresh();
  }

  List<PostJobModel> tempSearchJob = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: StreamBuilder(
          stream: isLoading.stream,
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.only(left: 24.h, top: 30.v, right: 24.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (String text) {
                          if (text.isNotEmpty) {
                            if (userRole == "e") {
                              // Search by skills
                              jobList = tempSearchJob
                                  .where((element) =>
                                  element.selectedSkills
                                      .toString()
                                      .toLowerCase()
                                      .contains(text.toLowerCase()))
                                  .toList();
                            } else if (userRole == "j") {
                              // Search by title
                              jobList = tempSearchJob
                                  .where((element) =>
                                  element.title
                                      .toString()
                                      .toLowerCase()
                                      .contains(text.toLowerCase()))
                                  .toList();
                            }
                          } else {
                            jobList = tempSearchJob;
                          }
                          isLoading.refresh();
                        },

                        decoration: InputDecoration(
                          hintText: "Search...",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              // Clear text when the clear icon is clicked
                              setState(() {
                                jobList = tempSearchJob;
                                isLoading.refresh();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (jobList.isNotEmpty)
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 12.v);
                        },
                        itemCount: jobList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          PostJobModel model = jobList[index];
                          return SavedItemWidget(
                            onTapBag: () {
                              if (userRole == "e") {
                                Get.to(() => ApplyerListScreen(
                                  jobId: model.id,
                                ));
                              } else {
                                // Get.to(() => ApplyJobScreen(
                                //   jobId: model.id, jobTitle:model.title,
                                // ));
                                Get.to(() => JobDetailsPage(
                                  postJobModel: model,
                                ));
                              }
                            },
                            model: model,
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
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
          // Filter the job list based on the selected criteria
          jobList = _getFilteredJobs();
        });
      }
    });
  }

  List<PostJobModel> _getFilteredJobs() {
    List<PostJobModel> filteredJobs = [];

    // Filter job list based on selected criteria
    filteredJobs = tempSearchJob.where((job) {
      bool matchesJobCategory = true;
      bool matchesSelectedCategories = true;

      // Filter by job category
      if (widget.selectedJobCategory != null && widget.selectedJobCategory != '') {
        matchesJobCategory = (job.selectedOption == widget.selectedJobCategory);
      }

      // Filter by selected categories
      if (widget.selectedCategories != null && widget.selectedCategories != '') {
        // Split selected categories into a list
        List<String> selectedCategoriesList = widget.selectedCategories!.split(',');

        // Check if any of the selected categories match job's selectedOption
        matchesSelectedCategories = selectedCategoriesList.contains(job.selectedOption);
      }

      // Include job if it matches job category and selected categories
      // Also, include if the job category is "Part Time" or "Full Time"
      return (matchesJobCategory || job.selectedOption == widget.selectedJobCategory) && matchesSelectedCategories;
    }).toList();

    return filteredJobs;
  }



  // void showFilterBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return FilterBottomsheet(
  //         onJobCategorySelected: (category) {
  //           setState(() {
  //             widget.selectedJobCategory = category;
  //           });
  //         },
  //         onCategories: (categories) {
  //           setState(() {
  //             widget.selectedCategories = categories;
  //           });
  //         },
  //         minSalary: widget.minSalary ?? 5000,
  //         maxSalary: widget.maxSalary ?? 100000,
  //       );
  //     },
  //   ).then((value) {
  //     if (value != null) {
  //       setState(() {
  //         widget.minSalary = value['minSalary'];
  //         widget.maxSalary = value['maxSalary'];
  //       });
  //     }
  //   });
  // }

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
}
