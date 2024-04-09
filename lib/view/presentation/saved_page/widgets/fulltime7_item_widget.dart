import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';
import 'package:job_app/model/user_model.dart';

class Fulltime7ItemWidget extends StatelessWidget {
  final PostJobModel model;
  final String? selectedJobType; // New variable to store selected job type

  Fulltime7ItemWidget({
    Key? key,
    required this.model,
    this.selectedJobType, // Pass selected job type as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 6.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        "${model.jobType}",
        style: TextStyle(
          color: appTheme.blueGray400,
          fontSize: 12.fSize,
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: selectedJobType == model.jobType, // Check if the job type matches the selected job type
      backgroundColor: appTheme.gray100,
      selectedColor: appTheme.gray100,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(
          8.h,
        ),
      ),
      onSelected: (value) {},
    );
  }
}
