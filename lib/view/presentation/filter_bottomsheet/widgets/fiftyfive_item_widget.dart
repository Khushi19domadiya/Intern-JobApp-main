import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:job_app/core/app_export.dart';

class FiftyfiveItemWidget extends StatefulWidget {
  bool isSelected = false;
  final String categories;
  VoidCallback onTap;
  // final Function(String) onCategories;

   FiftyfiveItemWidget({Key? key, required this.categories, /*required this.onCategories*/required this.isSelected,required this.onTap}) : super(key: key);

  @override
  _FiftyfiveItemWidgetState createState() => _FiftyfiveItemWidgetState();
}

class _FiftyfiveItemWidgetState extends State<FiftyfiveItemWidget> {
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
        widget.categories,
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
      // onSelected: (value) {
      //   setState(() {
      //     widget.isSelected = value;
      //
      //     if()
      //
      //
      //     // if (value) {
      //     //   // Notify the parent widget when job category is selected
      //     //   widget.onCategories(widget.categories);
      //     // }
      //   });
      // },
    );
  }
}
