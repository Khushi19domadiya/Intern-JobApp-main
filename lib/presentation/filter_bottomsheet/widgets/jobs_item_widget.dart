import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';

class JobsItemWidget extends StatefulWidget {
  final String jobCategory;
  VoidCallback onTap;

  bool isSelected = false;
  // final Function(String) onJobCategorySelected; // Add callback function

  JobsItemWidget({Key? key, required this.jobCategory/*, required this.onJobCategorySelected*/,required this.isSelected,required this.onTap}) : super(key: key);

  @override
  _JobsItemWidgetState createState() => _JobsItemWidgetState();
}

class _JobsItemWidgetState extends State<JobsItemWidget> {
  // bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      onPressed: widget.onTap,
      padding: EdgeInsets.only(
        top: 14.v,
        right: 16.h,
        bottom: 14.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        widget.jobCategory,
        style: TextStyle(
          color: widget.isSelected ? Colors.white : Colors.black,
          fontSize: 12.fSize,
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w600,
        ),
      ),
      avatar: CustomImageView(
        imagePath: ImageConstant.imgCheckmarkOnprimarycontainer,
        height: 18.adaptSize,
        width: 18.adaptSize,
        margin: EdgeInsets.only(right: 4.h),
      ),
      selected: widget.isSelected,
      backgroundColor: widget.isSelected ? appTheme.deepOrangeA200 : Colors.white,
      selectedColor: widget.isSelected ? Colors.deepOrange : Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(
          22.h,
        ),
      ),

    );
  }
}
