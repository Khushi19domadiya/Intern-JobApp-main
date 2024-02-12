import 'package:flutter/material.dart';
import 'package:saumil_s_application/core/app_export.dart';

class FiftyfiveItemWidget extends StatefulWidget {

  final String categories;
  final Function(String) onCategories;

  const FiftyfiveItemWidget({Key? key, required this.categories, required this.onCategories}) : super(key: key);

  @override
  _FiftyfiveItemWidgetState createState() => _FiftyfiveItemWidgetState();
}

class _FiftyfiveItemWidgetState extends State<FiftyfiveItemWidget> {
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
        widget.categories,
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
          if (value) {
            // Notify the parent widget when job category is selected
            widget.onCategories(widget.categories);
          }
        });
      },
    );
  }
}
