import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saumil_s_application/core/app_export.dart';
import 'package:saumil_s_application/presentation/filter_bottomsheet/widgets/fiftyfive_item_widget.dart';
import 'package:saumil_s_application/presentation/filter_bottomsheet/widgets/jobs_item_widget.dart';
import 'package:saumil_s_application/widgets/custom_elevated_button.dart';

import '../../controller/jobController.dart';

class FilterBottomsheet extends StatefulWidget {
  // Function(String?) onJobCategorySelected;
  // Function(String?) onCategories;
  // double minSalary;
  // double maxSalary;

  FilterBottomsheet({
    Key? key,
    // required this.onJobCategorySelected,
    // required this.onCategories,
    // required this.minSalary,
    // required this.maxSalary,
  }) : super(key: key);

  @override
  _FilterBottomsheetState createState() => _FilterBottomsheetState();
}

class _FilterBottomsheetState extends State<FilterBottomsheet> {
  var jobController = Get.put(JobController());

  // String? selectedJobCategory;
  // String? selectedCategories;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 25.v),
        decoration: AppDecoration.background
            .copyWith(borderRadius: BorderRadiusStyle.customBorderTL24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCloseRow(context),
            SizedBox(height: 29.v),
            _buildDesignCreativeColumn(context),
            SizedBox(height: 26.v),
            _buildSalariesColumn(context),
            SizedBox(height: 28.v),
            _buildJobsColumn(context),
            SizedBox(height: 30.v),
            CustomElevatedButton(
              text: "Apply Filter",
              onPressed: () async {
                // widget.onJobCategorySelected(selectedJobCategory);
                // widget.onCategories(selectedCategories);
                // Navigator.pop(context, {'minSalary': widget.minSalary, 'maxSalary': widget.maxSalary});

                await jobController
                    .getFilteredJobs()
                    .whenComplete(() => Get.back());
              },
            ),
            SizedBox(height: 15.v),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgComponent1Primary,
          height: 24.adaptSize,
          width: 24.adaptSize,
          onTap: () {
            onTapImgClose(context);
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.h),
          child: Text("Filter", style: CustomTextStyles.titleMedium18),
        ),
        Spacer(),
        InkWell(
          onTap: () async {
            jobController.jobList.value = await jobController.getJobsFuture();
            jobController.tempSearchJob = jobController.jobList;
            jobController.jobList.refresh();
            jobController.tempSearchJob.refresh();
            jobController.minSalary.value =  5000.0;
            jobController.maxSalary.value = 100000.0;
            jobController.update();
            Get.back();

          },
          child: Padding(
            padding: EdgeInsets.only(top: 3.v, bottom: 2.v),
            child: Text("Reset Filters",
                style: CustomTextStyles.titleSmallDeeporangeA200),
          ),
        ),
      ],
    );
  }

  Widget _buildDesignCreativeColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Categories", style: CustomTextStyles.titleMediumBold_1),
          SizedBox(height: 16.v),
          Wrap(
            runSpacing: 16.v,
            spacing: 16.h,
            children: [
              FiftyfiveItemWidget(
                categories: "Backend",
                isSelected: jobController.selectedCategory == "Backend",
                onTap: () {
                  if (jobController.selectedCategory == "Backend") {
                    jobController.selectedCategory = null;
                  } else {
                    jobController.selectedCategory = "Backend";
                  }
                  setState(() {});
                  log("-----jobController.selectedCategory------${jobController.selectedCategory}");
                },
              ),
              FiftyfiveItemWidget(
                categories: "Frontend",
                isSelected: jobController.selectedCategory == "Frontend",
                onTap: () {
                  if (jobController.selectedCategory == "Frontend") {
                    jobController.selectedCategory = null;
                  } else {
                    jobController.selectedCategory = "Frontend";
                  }
                  setState(() {});
                  log("-----jobController.selectedCategory------${jobController.selectedCategory}");
                },
              ),
              FiftyfiveItemWidget(
                categories: "Database",
                isSelected: jobController.selectedCategory == "Database",
                onTap: () {
                  if (jobController.selectedCategory == "Database") {
                    jobController.selectedCategory = null;
                  } else {
                    jobController.selectedCategory = "Database";
                  }
                  setState(() {});
                  log("-----jobController.selectedCategory------${jobController.selectedCategory}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSalariesColumn(BuildContext context) {
    return Column(
      children: [
        _buildPrice(context,
            priceText1: "Min Salary",
            priceText2: "${jobController.minSalary.toInt()}.000/Month"),
        SizedBox(height: 16.v),
        _buildPrice(context,
            priceText1: "Max Salary",
            priceText2: "${jobController.maxSalary.toInt()}.000/Month"),
        SizedBox(height: 16.v),
        SliderTheme(
          data: SliderThemeData(
            trackShape: RoundedRectSliderTrackShape(),
            activeTrackColor: appTheme.deepOrangeA200,
            inactiveTrackColor: appTheme.gray100,
            thumbColor: appTheme.deepOrangeA200,
            thumbShape: RoundSliderThumbShape(),
          ),
          child: RangeSlider(
            values: RangeValues(
                jobController.minSalary.value, jobController.maxSalary.value),
            min: 5000.0,
            max: 100000.0,
            onChanged: (values) {
              setState(() {
                // jobController.minSalary = (values.start / 1000).round() * 1000;
                // jobController.maxSalary = (values.end / 1000).round() * 1000;
                jobController.minSalary.value =
                    (values.start / 1000).roundToDouble() * 1000;
                jobController.maxSalary.value =
                    (values.end / 1000).roundToDouble() * 1000;
              });
            },
          ),
        ),
        SizedBox(height: 2.v),
        _buildPrice(context,
            priceText1: "${jobController.minSalary.toInt()}",
            priceText2: "${jobController.maxSalary.toInt()}.000"),
      ],
    );
  }

  Widget _buildJobsColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Jobs", style: CustomTextStyles.titleMediumBold_1),
          SizedBox(height: 16.v),
          Wrap(
            runSpacing: 16.v,
            spacing: 16.h,
            children: [
              JobsItemWidget(
                jobCategory: "Part Time",
                onTap: () {
                  if (jobController.selectedJobType == "Part Time") {
                    jobController.selectedJobType = null;
                  } else {
                    jobController.selectedJobType = "Part Time";
                  }
                  setState(() {});
                  log("-----jobController.selectedJobType------${jobController.selectedJobType}");
                },
                isSelected: jobController.selectedJobType == "Part Time",
              ),
              JobsItemWidget(
                jobCategory: "Full Time",
                onTap: () {
                  if (jobController.selectedJobType == "Full Time") {
                    jobController.selectedJobType = null;
                  } else {
                    jobController.selectedJobType = "Full Time";
                  }
                  setState(() {});
                  log("-----jobController.selectedJobType------${jobController.selectedJobType}");
                },
                isSelected: jobController.selectedJobType == "Full Time",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrice(
    BuildContext context, {
    required String priceText1,
    required String priceText2,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          priceText1,
          style: CustomTextStyles.labelLargeSemiBold
              .copyWith(color: appTheme.blueGray400),
        ),
        Text(
          priceText2,
          style: CustomTextStyles.labelLargeSemiBold
              .copyWith(color: appTheme.blueGray400),
        ),
      ],
    );
  }

  void onTapImgClose(BuildContext context) {
    Navigator.pop(context);
  }
  //
  // void _handleJobCategorySelected(String? category) {
  //   log("-----_handleJobCategorySelected----${category}");
  //   // widget.onJobCategorySelected(category);
  //
  //   setState(() {
  //     jobController.selectedJobCategory = category;
  //   });
  // }
  //
  // void _handleCategorySelected(String? categories) {
  //   // widget.onJobCategorySelected(categories);
  //
  //   setState(() {
  //     jobController.selectedCategories = categories;
  //   });
  // }
}
