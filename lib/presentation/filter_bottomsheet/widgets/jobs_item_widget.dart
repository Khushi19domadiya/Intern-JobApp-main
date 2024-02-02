import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';

class JobsItemWidget extends StatefulWidget {
  final String jobCategory;

  const JobsItemWidget({Key? key, required this.jobCategory}) : super(key: key);

  @override
  _JobsItemWidgetState createState() => _JobsItemWidgetState();
}

class _JobsItemWidgetState extends State<JobsItemWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return RawChip(
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
          color: isSelected ? Colors.white : Colors.black,
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
      selected: isSelected,
      backgroundColor: isSelected ? appTheme.deepOrangeA200 : Colors.white,
      selectedColor: isSelected ? Colors.deepOrange : Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(
          22.h,
        ),
      ),
      onSelected: (value) {
        setState(() {
          isSelected = value;
        });
      },
    );
  }
}
