import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saumil_s_application/controller/jobController.dart';
import 'package:saumil_s_application/core/utils/image_constant.dart';
import 'package:saumil_s_application/core/utils/size_utils.dart';
import 'package:saumil_s_application/presentation/saved_page/widgets/saved_item_widget.dart';
import 'package:saumil_s_application/presentation/apply_job_screen/apply_job_screen.dart';
import 'package:saumil_s_application/presentation/job_details_page/applyer_list_screen.dart';
import 'package:saumil_s_application/presentation/filter_bottomsheet/widgets/fiftyfive_item_widget.dart';
import 'package:saumil_s_application/presentation/filter_bottomsheet/filter_bottomsheet.dart';
// import 'package:saumil_s_application/controller/jobController.dart';
import 'package:saumil_s_application/models/user_model.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_leading_image.dart';
import 'package:saumil_s_application/widgets/app_bar/appbar_trailing_image.dart';
import 'package:saumil_s_application/widgets/app_bar/custom_app_bar.dart';
import 'package:saumil_s_application/widgets/custom_search_view.dart';

import '../../widgets/app_bar/appbar_title.dart';
import '../job_details_page/job_details_page.dart';

class SavedPage extends StatefulWidget {
  // String? selectedJobCategory;
  // String? selectedCategories;
  // double? minSalary;
  // double? maxSalary;

  // SavedPage({
  //   Key? key,
  //   this.selectedJobCategory,
  //   this.selectedCategories,
  //   this.minSalary,
  //   this.maxSalary,
  // }) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {

  final TextEditingController _searchController = TextEditingController();
  var  jobController = Get.put(JobController());


  getData() async {}

  @override
  void initState() {
    super.initState();
    getData();
    fetchUserRole();
  }

  void fetchUserRole() async {
    final userDoc = await FirebaseFirestore.instance.collection('Users').doc(jobController.user!.uid).get();
    setState(() {
      jobController.userRole = userDoc['role'];
    });
    jobController.jobList.value = await jobController.getJobsFuture();
    jobController.tempSearchJob = jobController.jobList;
    jobController.isLoading.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: StreamBuilder(
          stream: jobController.isLoading.stream,
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
                            if (jobController.userRole == "e") {
                              // Search by skills
                              jobController.jobList.value = jobController.tempSearchJob
                                  .where((element) =>
                                  element.selectedSkills
                                      .toString()
                                      .toLowerCase()
                                      .contains(text.toLowerCase()))
                                  .toList();
                            } else if (jobController.userRole == "j") {
                              // Search by title
                              jobController.jobList.value = jobController.tempSearchJob
                                  .where((element) =>
                                  element.title
                                      .toString()
                                      .toLowerCase()
                                      .contains(text.toLowerCase()))
                                  .toList();
                            }
                          } else {
                            jobController.jobList = jobController.tempSearchJob;
                          }
                          jobController.refresh();
                        },

                        decoration: InputDecoration(
                          hintText: "Search...",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              // Clear text when the clear icon is clicked
                              setState(() {
                                jobController.jobList = jobController.tempSearchJob;
                                jobController.isLoading.refresh();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Obx(()=>
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 12.v);
                          },
                          itemCount: jobController.jobList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            PostJobModel model = jobController.jobList[index];
                            if(model.isDelete != 1){
                              return SavedItemWidget(
                                onTapBag: () {
                                  if (jobController.userRole == "e") {
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
                            }
                         return SizedBox();
                          },
                        )),
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
  //         // Filter the job list based on the selected criteria
  //         jobList = _getFilteredJobs();
  //       });
  //     }
  //   });
  // }



  void showFilterBottomSheet(BuildContext context) {

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FilterBottomsheet(
//           onJobCategorySelected: (category) {
// log("-----onJobCategorySelected----${category}");
//             setState(() {
//               selectedJobCategory = category;
//             });
//           },
//           onCategories: (categories) {
//             log("-----onCategories----${categories}");
//
//             setState(() {
//               selectedCategories = categories;
//             });
//           },
//           minSalary: minSalary ?? 5000,
//           maxSalary: maxSalary ?? 100000,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          // minSalary = value['minSalary'];
          // maxSalary = value['maxSalary'];
          // // Update selected type
          // selectedJobCategory = value['selectedType'];
          // // Filter the job list based on the selected criteria
          // jobList = _getFilteredJobs();
        });
      }
    });
  }

  // List<PostJobModel> _getFilteredJobs() {
  //   List<PostJobModel> filteredJobs = [];
  //
  //   // Filter job list based on selected criteria
  //   filteredJobs = tempSearchJob.where((job) {
  //     bool matchesJobCategory = true;
  //     bool matchesSelectedCategories = true;
  //     bool matchesSalaryRange = true;
  //
  //     // Filter by job category
  //     if (widget.selectedJobCategory != null && widget.selectedJobCategory != '') {
  //       matchesJobCategory = (job.selectedOption == widget.selectedJobCategory);
  //     }
  //
  //     // Filter by selected categories
  //     if (widget.selectedCategories != null && widget.selectedCategories != '') {
  //       // Split selected categories into a list
  //       List<String> selectedCategoriesList = widget.selectedCategories!.split(',');
  //
  //       // Check if any of the selected categories match job's selectedOption
  //       matchesSelectedCategories = selectedCategoriesList.contains(job.selectedOption);
  //     }
  //
  //     // Convert minSalary and maxSalary from string to double for comparison
  //     double? minSalary = double.tryParse(job.lowestsalary);
  //     double? maxSalary = double.tryParse(job.highestsalary);
  //
  //     // Check if conversion was successful before comparison
  //     if (minSalary != null && maxSalary != null && widget.minSalary != null && widget.maxSalary != null) {
  //       // Filter by salary range
  //       matchesSalaryRange = minSalary >= widget.minSalary! && maxSalary <= widget.maxSalary!;
  //     }
  //
  //     // Include job if it matches job category, selected categories, and salary range
  //     return (matchesJobCategory || job.selectedOption == widget.selectedJobCategory) &&
  //         matchesSelectedCategories && matchesSalaryRange;
  //   }).toList();
  //
  //   return filteredJobs;
  // }


//   List<PostJobModel> _getFilteredJobs() {
//     List<PostJobModel> filteredJobs = [];
// log("----widget.selectedJobCategory---${selectedJobCategory}");
// log("----widget.selectedCategories---${selectedJobCategory}");
//     // Filter job list based on selected criteria
//     filteredJobs = tempSearchJob.where((job) {
//       bool matchesJobCategory = true;
//       bool matchesSelectedCategories = true;
//       bool matchesSalaryRange = true;
//       bool matchesType = true;
//
//       // Filter by job category
//       if (selectedJobCategory != null && selectedJobCategory != '') {
//         matchesJobCategory = (job.selectedOption == selectedJobCategory);
//       }
//
//       // Filter by selected categories
//       if (selectedCategories != null && selectedCategories != '') {
//         // Split selected categories into a list
//         List<String> selectedCategoriesList = selectedCategories!.split(',');
//
//         // Check if any of the selected categories match job's selectedOption
//         matchesSelectedCategories = selectedCategoriesList.contains(job.selectedOption);
//       }
//
//       // Convert minSalary and maxSalary from string to double for comparison
//       double? minSalary = double.tryParse(job.lowestsalary);
//       double? maxSalary = double.tryParse(job.highestsalary);
//
//       // Check if conversion was successful before comparison
//       if (minSalary != null && maxSalary != null && minSalary != null && maxSalary != null) {
//         // Filter by salary range
//         matchesSalaryRange = minSalary >= minSalary! && maxSalary <= maxSalary!;
//       }
//
//       // Filter by type
//       if (selectedJobCategory != null &&selectedJobCategory != '') {
//         matchesType = (job.jobType == selectedJobCategory);
//       }
//
//       // Include job if it matches job category, selected categories, salary range, and type
//       return matchesJobCategory && matchesSelectedCategories && matchesSalaryRange && matchesType;
//     }).toList();
//
//     return filteredJobs;
//   }
//



  // void showFilterBottomSheet(BuildContext context) {+
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


}